#Programming Historian YouTube R Script as of Jan 10 2024 (not markdown)


install.packages(c("tidyverse", "quanteda", "quanteda.textmodels", "quanteda.textplots", "stringi"))



#load packages needed for data wrangling
library(tidyverse); library(lubridate); library(ggplot2); library(purrr); library(stringi)





########## COMBINING YOUTUBE DATA TOOLS DOWNLOADED VIDEOS INTO ONE DATAFRAME
# combining downloads into one large data frame of videos and comments

# load in files containing comments and add videoId column from file name
comment_files <- list.files(path = "ytdt_data/",
                            recursive = TRUE,
                            pattern = "\\comments.csv$",
                            full.names = TRUE)
comment_files

all_comments <- read_csv(comment_files, id = "videoId", col_select = c(
  commentId = id,
  authorName,
  commentText = text),
  show_col_types = FALSE) %>% 
  suppressWarnings()

all_comments$videoId <- str_extract(
  all_comments$videoId, "(?<=ytdt_data\\/).+(?=\\/videoinfo)"
  )
all_comments


# load in files containing video data 

video_files <- list.files(path = "ytdt_data/",
                            recursive = TRUE,
                            pattern = "basicinfo\\.csv$",
                            full.names = TRUE)
video_files




# pivoting, so data organized by row rather than column

all_videos <- read_csv(video_files, col_names = FALSE, id = "videoId", show_col_types = FALSE) %>%
  mutate(videoId = str_extract(videoId, "(?<=ytdt_data\\/).+(?=\\/videoinfo)")) %>%
  pivot_wider(names_from = X1, values_from = X2) %>%
  select(videoId, videoChannelTitle = channelTitle, videoTitle = title, commentCount)

# confirm channel titles, and number of comments per channel
all_videos


# join video and comment data
all_data <- inner_join(all_comments, all_videos)
count(all_data, sort(videoChannelTitle))



# add partisan indicator as factor for later visualization - NOTE - USERS SHOULD UPDATE THIS AS APPROPRIATE TO THEIR PROJECT
all_data$partisan <- all_data$videoChannelTitle
all_data <- all_data |> 
  mutate(partisan = as.factor(case_when(
    partisan %in% c("Ben Shapiro", "New York Post", "Fox News", "DailyWire+") ~ "right",
    partisan == "NBC News" ~ "left",
    TRUE ~ partisan))
  )
glimpse(all_data)




##Part IV: Pre-processing and Cleaning YouTube Data
library(quanteda)  # Calling this library later to avoid conflicts


#Clean the Data
# create custom stopword list, including both custom and quanteda stopwords.  Remove stopwords.
# Additionally, convert to lowercase, and remove punctuation and html

my_stopwords <- c(stopwords("en"), "brostein", "derrick", "camry")

all_data$text <- all_data$commentText %>%
  str_to_lower() %>%
  str_remove_all(str_c("\\b", my_stopwords, "\\b", collapse = "|"))

all_data$text <- all_data$text %>% 
  str_remove_all("[:punct:]||&#39|[$]") %>% 
  str_remove_all("[@][\\w_-]+|[#][\\w_-]+|http\\S+\\s*|<a href|<U[+][:alnum:]+>|[:digit:]*|<U+FFFD>")


#remove any duplicate rows
all_data <- all_data %>% unique()
print(paste(nrow(all_data), "comments remaining"))


# Create new column with duplicate words removed from each comment
all_data$uniqueWords <- sapply(str_split(all_data$text, " "), function(x) paste(unique(x), collapse = " "))  



# Remove any comments with less than 10 words 
all_data <- all_data %>% mutate(    
  numbWords = str_count(all_data$uniqueWords, boundary("word"))) %>% filter(
    numbWords >= 10)

print(paste(nrow(all_data), "comments remaining"))




#optional: Can export data here
write.csv(all_data, "all_data.csv")


##Part V: Exploring YouTube Comments with Wordfish

#Selecting Comments for the Corpus
wfAll <- select(all_data, commentId, uniqueWords, videoChannelTitle, partisan, numbWords)



#Building the Corpus
options(width = 110)

corp_all <- corpus(wfAll, docid_field = "commentId", text_field = "uniqueWords")
summary(docvars(corp_all))



#Tokenization and DFM Creation
toks_all <- tokens(corp_all, 
#                        remove_punct = TRUE,
#                        remove_symbols = TRUE,
#                        remove_numbers = TRUE,
#                        remove_url = TRUE,
                       remove_separators = TRUE)

#Optimizing the Corpus for Wordfish
dfmat_all <- dfm(toks_all)
print(paste("you created", "a dfm with", ndoc(dfmat_all), "documents and", nfeat(dfmat_all), "features"))



dfmat_all <- dfm_keep(dfmat_all, min_nchar = 4)
dfmat_all <- dfm_trim(dfmat_all, min_docfreq = 0.01, min_termfreq = 0.0001, termfreq_type = "prop")

print(dfmat_all)



#List of most frequent 25 words
topWords <- topfeatures(dfmat_all, 25, decreasing = TRUE) %>% names() %>% sort()
topWords


library(quanteda.textmodels)

#Run the Wordfish model
tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)




library(quanteda.textplots)


#plot all **FEATURES**
wf_feature_plot <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling")
wf_feature_plot



#  #plot all **COMMENTS** -- ggplot version of COMMENT data
wf_comment_df <- tibble(
  theta = tmod_wf_all[["theta"]],
  alpha = tmod_wf_all[["alpha"]],
  partisan = as.factor(tmod_wf_all[["x"]]@docvars$partisan)
)

wf_comment_plot <- ggplot(wf_comment_df) + geom_point(aes(x = theta, y = alpha, color = partisan), shape = 1) +
  scale_color_manual(values = c("blue", "red")) + labs(title = "Wordfish Model Visualization - Comment Scaling", 
                                                       x = "Estimated theta", y= "Estimated psi")
wf_comment_plot







#------------------------------------------------------ Add'l feature level model/visualization after final / additional stopword removal

#Remove any additional stopwords
more_stopwords <- c("edward", "bombed", "calmly")    # Removing these to focus on main visualization (remove tails)
dfmat_all <- dfm_remove(dfmat_all, pattern = more_stopwords)



#Run the Wordfish model
tmod_wf_all <- textmodel_wordfish(dfmat_all, dispersion = "poisson", sparse = TRUE, residual_floor = 0.5, dir=c(2,1))
summary(tmod_wf_all)



#plot all **FEATURES**
wf_feature_plot_more_stopwords <- textplot_scale1d(tmod_wf_all, margin = "features") + 
  labs(title = "Wordfish Model Visualization - Feature Scaling") 
wf_feature_plot_more_stopwords


# SAVE the final version of the feature scaling visualization
ggsave("Wordfish Model Visualization - Feature Scaling.jpg", plot=wf_feature_plot_more_stopwords)
