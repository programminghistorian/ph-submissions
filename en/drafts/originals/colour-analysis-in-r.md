---
title:  
collection: lessons  
layout: lesson  
authors:
- Nick Redfern

---
title: "An Introduction to Computational Analysis of Film Colour in R "
collection: lessons
layout: lesson
slug: colour-analysis-in-r
date: 2022-MM-DD
authors:
- Nick Redfern
reviewers:
- Firstname Surname
- Firstname Surname
editors:
- Nabeel Siddiqui
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/496
difficulty: TBC
activity: TBC
topics: [TBC]
avatar_alt: TBC
abstract: TBC
doi: TBC
---

{% include toc.html %}


Colour in the cinema has a wide variety of functions that serve both the internal, syntactic organisation of a film and the external, semantic experience of the viewer.[^1] Colour is structural, acting as a force of coherence to create a world for the viewer through the unification of production design, costume design, lighting, cinematography, and post-production colour processing,[^2] while changing colour palettes mark changes in time, location, and the evolution of character. Colour is attentional, dividing the image into foreground and background and drawing our eye to what is important in the frame. Colour is meaningful at the localised level of textual significance, where it is associated with narratively significant objects, characters, or themes, and at the macro level of codified cultural meanings shared among audiences. Colour is emotional, conveying moods and feelings to the viewer and eliciting psychological responses.[^3] Colour is generic, with different types of films associated with particular colour schemas, levels of brightness, and saturation.[^4]

Barbara Flueckiger and Gaudenz Halter note that analyses of film colours have historically relied upon verbal description that privileged hermeneutic interpretation over aesthetics and argue that computational approaches provide a more comprehensive approach to analysing the different dimensions of colour in film.[^5] This lesson demonstrates some methods by which colour in the cinema can be approached computationally. By the end of this lesson, you will be able to:

* Understand the workflow involved in computational analysis of film colour.
* Extract frames from a video file.
* Convert colour data between different colour spaces.
* Calculate the average colour of a frame.
* Apply cluster analysis to construct a representative palette for a film using CLARA.
* Produce high quality visualisations of colour data.

The rest of this tutorial is organised as follows. The next section introduces the key concept of a colour space that we will need to analyse film colour and describes the three colour spaces used in this tutorial. Section three describes the basic workflow for processing colour data and the tools we will use in this tutorial. Section four covers how to convert video files between different formats and extract a sample of frames from a video file for analysis. In section five, we will calculate the average colour of a frame in different colour spaces and plot different attributes of colour in the cinema. Section six uses *k*-medoids clustering using CLARA to construct a palette of representative colours for a film.

In this lesson we will implement a colour analysis workflow using [R](https://www.r-project.org), an open-source environment for statistical computing and graphics. Although, we will cover all the required steps to analyse colour in a film in this lesson, some basic knowledge of R is required. There are many excellent guides to using R available that cover installing R, the assignment of names to variables in the workspace, the different data types in R, and how to work with packages and functions and so we will not cover them here. The website [R Tutorial](http://www.r-tutor.com) is possibly the best place to start if you have never used R before.  Garrett Grolemund and Hadley Wickham's [*R for Data Science*](https://r4ds.had.co.nz/index.html) is an excellent introduction to using R for data science projects.[^6]

# Colour Spaces and Models

Although colour has an objective physical basis in the wavelength of light, colour is a perceived phenomenon for observers.[^7] In order to analyse colour in film, we need method for representing colours: specifically, we need to work in a colour space.

A [colour model](https://en.wikipedia.org/wiki/Color_model) is a method for describing a colour using tuples of numbers, where a [tuple](https://en.wikipedia.org/wiki/Tuple) is a finite ordered list of numbers and is written with round brackets. A [colour space](https://en.wikipedia.org/wiki/Color_space) is a geometrical representation of the range of colours that can be represented by a model, and where the tuple describing a colour corresponds to the coordinates of a colour in a 3-dimensional space. In this tutorial we will work with the RGB, L\*a\*b\*, and LCH(ab) colour spaces.

## The RGB colour model

The [RGB colour model](https://en.wikipedia.org/wiki/RGB_color_model) (Figure 1) is a defined by the [chromaticity](https://en.wikipedia.org/wiki/Chromaticity) of three primary colours, red, green, and blue, with colours produced through the additive mixing of these primaries. There are many different RGB colour spaces, but the one used most commonly is sRGB. It is assumed here that when we talk about the RGB colour space, we are talking about [sRGB](https://en.wikipedia.org/wiki/SRGB). RGB is the most common colour space used for devices that project light, and so is the default colour space for televisions and computer monitors. It is also the default RGB colour space for R packages.

RGB colours are described by a tuple comprising three numbers that represent the values of the red, green, and blue channels. These values are represented on a scale from 0-255 or on a scale from 0-1 for each channel. These scales are equivalent, and conversion between the two scales is simply a matter of dividing or multiplying by 255. For example, cyan contains no red but has the maximum value for both the green and blue channels, and so it has the tuple (0, 255, 255) or (0, 1, 1). When the values in an RGB tuple are equal the colour is achromatic, ranging from black (0, 0, 0) to white ((255, 255, 255) or (1, 1, 1)), with all other tuples on this axis representing shades of grey (e.g., dark grey is (127, 127, 127) or (0.498, 0.498, 0.498)). There is no standard way for RGB colours to be specified in R. Some packages scale RGB colours from 0-1 while others use the scale 0-255, and so the inputs and outputs may be mismatched and require moving from one scale to another. Here we will try to be consistent and use the 0-255 scale whenever possible, so that even if we are required to use the 0-1 scale when processing data, we will always convert the outputs to the 0-255 scale when it comes to plotting and analysing the results.

Colours in the RGB colour space can also be represented as [hex codes](https://www.techopedia.com/definition/29788/color-hex-code) by converting the tuple formed by the values of the red, green, and blue channels to hexadecimal format. The three hexadecimal numbers in a hex code correspond to the values for the red, green, and blue channels, respectively: #RRGGBB. For example, pure red has the RGB tuple (255, 0, 0) and has the corresponding hex code #FF0000, while magenta, as a combination of pure red and pure blue with no green, has an RGB tuple of (255, 0, 255) and the hex code #FF00FF.

<!--Figure 1-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R1.png" caption="Figure 1: An illustration of the RGB colour space, for six values of the blue channel. Black is at (0, 0, 0), white at (255, 255, 255), and grey occurs where R  = G = B between these limits." %}

## Perceptually uniform colour spaces

The RGB colour space is not [perceptually uniform](https://programmingdesignsystems.com/color/perceptually-uniform-color-spaces/); that is, the perceived difference between two RGB colours is not proportional to the [Euclidean distance](https://en.wikipedia.org/wiki/Euclidean_distance) between them so that differences in the values of the attributes of a colour do not correspond to the differences we actually see between colours. To solve this problem, we can use the L\*a\*b\* colour space, which is perceptually uniform.

The [L\*a\*b\* colour space](https://en.wikipedia.org/wiki/CIELAB_color_space) (Figure 2) is defined by three attributes:

* Lightness: perceptual lightness, measured as a percentage
* a\*: chromaticity along the green (-a\*) – red (+a\*) axis
* b\*: chromaticity along the blue (-b\*) – yellow (+b\*) axis

Theoretically, a\* and b\* are unbounded, but in practice most packages in R clamp the range of each attribute to [-128, 127]. Achromatic colours occur where the values of a\* and b\* are both zero and change with increasing lightness from black (L\* = 0%) to white (L\* = 100%), with grey values between these limits.

<!--Figure 2-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R2.png" caption="Figure 2: An illustration of the L\*a\*b\* colour space for a range of lightness values across the range [-120, 120] for a\* and b\*. Achromatic colours occur where a\* = b\* = 0 and varies with lightness from black (L\* = 0%) to white (L\* = 100%, 0, 0), with grey between these limits." %}

Neither of the RGB and L\*a\*b\* colour spaces is intuitive. [LCH(ab)](https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_model) is a polar representation of the L\*a\*b\* colour space (Figure 3) that is much easier to understand and has the following attributes:

* Lightness: this is identical to lightness in the L\*a\*b\* colour space defined above.
* Chroma: the saturation or vividness of a colour, measured as the distance from the achromatic axis and reported as a percentage.
* Hue: the basic colour represented as the angle on  a colour wheel, where red = 0°, yellow = 90°, green = 180°, and blue = 270°.

Achromatic colours occur when C = 0%, and vary with lightness, from black (L = 0%) to white (L = 100%). Hues are arbitrary for achromatic colours.

<!--Figure 3-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R3.png" caption="Figure 3: An illustration of the LCH(ab) colour space for a range of lightness values. Achromatic colours occur at C = 0% with arbitrary hue and vary with lightness from black (L = 0%) to white (L = 100%)." %}

It will be necessary whenever plotting the results of our analysis using the L\*a\*b\* and LCH(ab) colour spaces to convert the values of their respective attributes to the RGB colour space because in order to display colours on a screen they must be RGB. Computer monitors use RGB colour; they do not display L\*a\*b\* or LCH (ab) colours. Every colour function in R performs this conversion under the hood, irrespective of the colour attributes they take as an input. The L\*a\*b\* or LCH(ab) are preferred when it comes to processing colour as data because of their perceptual uniformity and it is easier to think about colours in these spaces; but the colours we are actually looking at on a screen are RGB. This can have some significant drawbacks: it is possible to specify colours in the LCH(ab) colour space that cannot be rendered in an RGB colour space. Fortunately for us, films are made to be watched on screens. The standard colour spaces for high definition, [Rec.709](https://en.wikipedia.org/wiki/Rec._709), and ultra-high definition, [Rec.2020](https://en.wikipedia.org/wiki/Rec._2020), are both RGB colour spaces, though they have different [gamuts](https://en.wikipedia.org/wiki/Gamut). Rec.709 has the same gamut as sRGB, which means that an HD sRGB screen will be able to display 100% of the Rec.709 colour space used in production. We are therefore unlikely to come across colours that do not exist in the sRGB colour space and this should not limit our analyses.

# Colour analysis workflow

A [pixel](https://en.wikipedia.org/wiki/Pixel) is an atom, the smallest element of a digital image. Like an atom, it is made up of elements at an even smaller scale: the sub-atomic particles of digital imaging are the three channels it takes to represent the colour of a pixel – red, green, and blue. A set of pixels make up an image, with the resolution determined by the number of columns and rows of pixels in the two-dimensional array that stores the image as data. A film is made up of a set of images, recorded and replayed at some frame rate (typically 24 or 25 frames per second). It is easy to see that the number of data points we have to work with grows to be large very quickly: a 100-minute-long feature film at 24 frames per second with a resolution of 1280 × 720 pixels per frame has 3 × 1280 × 720 × 24 × 60 × 100 = 398 131 200 000 individual data points. This is a *small* number: describing the colour of longer films at higher resolution (such as 4K Ultra HD) and higher frame rates (e.g., 60 fps) will require a substantially greater number of data points.

To make any analysis of colour in a film feasible, it is necessary to reduce the number of data points to something manageable with the computational resources of a desktop computer or laptop. The workflow involved in analysing colour in the cinema therefore involves two stages:

* *Sampling*: selecting frames for inclusion in an analysis based on their timecode (every *n*-th frame or *n* frames per second) or their representativeness based on the segmentation of a film into coherent sequences.
* *Data reduction*: the pixels in a frame are reduced to a single value or a small set of values that are usually based on either the average or dominant colour of the pixels, or the representativeness of a set of exemplar colours in a palette based on clustering methods.

There are numerous methods for visualising colour in the cinema, including [movie barcodes](https://moviebarcode.tumblr.com), [cinemetrics](http://cinemetrics.fredericbrodbeck.de), [z-projections](http://typecast.qwriting.qc.cuny.edu/2013/10/07/western-roundup/), [palettes](https://moviesincolor.com), [treemaps](https://en.wikipedia.org/wiki/Treemapping), [Color_dT plots](http://www.digitalhumanities.org/dhq/vol/14/4/000500/000500.html), and more. See Flueckiger and Halter (2020) for an overview. All of these methods employ this two-stage workflow of sampling frames and reducing the colour data they contain to a limited number of values, possibly with more than one iteration of each step in any given analysis.

## Setting up the project

### FFmpeg

R provides us with an interface to perform operations on video files, but it does not actually process video files. For this we will need [FFmpeg](https://ffmpeg.org), a command-line based utility for decoding, encoding, and converting media files that is the workhorse of many packages across different languages for media processing. Whenever you are using R (or [Python](https://www.python.org) or [Julia](https://julialang.org)) to work with video and/or audio files, you are, in reality, likely using FFmpeg.

FFmpeg does not require installation on Windows, but it is necessary to set an environment path to FFmpeg so that commands addressed to it are carried out. Instructions in how to set a path for FFmpeg are available for Windows users [here](https://www.wikihow.com/Install-FFmpeg-on-Windows).

On MacOS, FFmpeg is easily installed as a package from [Homebrew](https://formulae.brew.sh/formula/ffmpeg#default).

*Programming Historian* has a [guide to working with FFmpeg](https://programminghistorian.org/en/lessons/introduction-to-ffmpeg) (Rodriguez 2018) if you would like to learn more.

### RStudio and the `here` package

It is recommended that RStudio, the integrated development environment for R, is used for this lesson. You can download and install the version of RStudio appropriate to your system [here](https://www.rstudio.com/products/rstudio/).

Using RStudio means we can create a [project](https://r4ds.had.co.nz/workflow-projects.html) for this lesson. This will simplify our workflow by keeping all the associated files in a single directory and avoid the need for absolute paths.

The first step in this lesson, then, is to create a project in a new directory. To do this open RStudio, and click `File > New Project`. When the New Project Wizard dialogue box opens,

1. select New Directory
2. select New Project to create an empty project
3. Give your directory a name and browse to where you want it to be located on your computer
4. click Create Project

This will create a `.Rproj` file in the new directory you have created. Any time you wish to resume work on this lesson, simply open the project directory and double-click on the `.Rproj` file. This will open the project in RStudio with the correct [working directory](https://bookdown.org/ndphillips/YaRrr/the-working-directory.html) and command history, and will automatically open any files you were working on the lat time you closed the project.

A key advantage of working with RStudio projects is the ability to use [relative paths](https://malco.io/2018/11/05/why-should-i-use-the-here-package-when-i-m-already-using-projects/) with the `here` package. Using absolute paths means anytime a directory is moved or shared, code has to be updated to match changes in the working directory and/or directory structure. By basing our workflow around a projects we can be confident that our working directory is always correct and by using the `here` package when reading and writing files relative to the project directory, our code will always work even if we change the location of the working directory.

### Packages

This lesson uses ten R packages, which are summarised in Table 1.

| Package      | Description                                              | Functions                                                    |
| ------------ | -------------------------------------------------------- | ------------------------------------------------------------ |
| `av`         | Perform operations on video files                        | `av_video_convert()`, `av_video_images()`, `av_video_info()` |
| `farver`     | Convert between colour spaces                            | `convert_colour()`                                           |
| `fpc`        | *k*-medoid cluster analysis using CLARA                  | `pamk()`                                                     |
| `ggpubr`     | Arranging plots in figures                               | `ggarrange()`                                                |
| `here`       | Use relative paths to access data                        | `here()`                                                     |
| `imager`     | Image loading and manipulation                           | `load.image()`, `R()`, `G()`, `B()`                          |
| `pacman`     | Install and load packages                                | `p_load()`                                                   |
| `tidyverse`  | Data wrangling and visualisation                         | `filter()`, `ggplot()`, `mutate()`, `select()`               |
| `treemapify` | Data visualisation using treemaps                        | `treemapify()`                                               |
| `viridis`    | Colour schemes for plots in conjunction with `tidyverse` | NA                                                           |

Table 1: R packages and functions used in this tutorial

First, we need to install the `pacman` package that we will use for package management. This makes handling packages much simpler and cuts down the amount of code needed to set up a workspace for a project.

#### Listing 1: Install pacman package

```r
install.packages("pacman")
```

Once `pacman` is installed, we can use the following command to install any missing packages we may need and to load them for data processing.

#### Listing 2: Install pacman package

```r
pacman::p_load(av, here, farver, fpc, ggpubr, imager, tidyverse, treemapify, viridis)
```

Now we are ready to go and get our film for analysis.

## *Hero* (2018)

The film used in this tutorial is *Hero* (2018), a short film by Daniel Martinez Lara funded by the Blender Cloud, that tells the story of two heroes fighting for control of a mysterious golden object that is essential to the prosperity of their respective homelands.  

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/pKmSdY56VtY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen data-external="1"></iframe></center>

The film is open source and is freely available under a Creative Commons Attribution 4.0 International license and can be download from [wikimedia commons](https://commons.wikimedia.org/wiki/File:HERO_-_Blender_Open_Movie-full_movie.webm).

In this tutorial we will start with the WebM 720P version of the film. To download this version of the film, click on the link above, scroll down to find the version labelled `WebM 720P`, and right click on the download file symbol and select `Save linked content as ...` or `Save link as ...`. Be sure to download the version marked as `WebM 720P` and **not** the version marked as `VP9 720P`. The file `HERO_-_Blender_Open_Movie-full_movie.webm.720p.webm` should be 45.1MB in size.

Make sure you save the WebM file in the **project folder** we created above.

## Video processing with `av`

WebM is not a terribly convenient video format to work with, and so to make our lives easier, we will convert the video file to the mp4 format using `av::av_video_convert()` and give it the filename `hero.mp4` (with a resulting filesize of 30.0MB). *Hero* was produced to showcase the grease pencil tools in Blender, and the closing credits include some interesting shots of the production process. However, we don’t want these frames in our analysis and so we can make a system call directly to FFmpeg from within R to trim the video file. This will give us a reduced version of the original film that includes all the frames up to the beginning of the credits, which start at 2 minutes and 27 seconds. To avoid confusion, we will save this reduced version of the film with the filename `hero_reduced.mp4` that is 30.2MB in size. In this command, we are instructing FFmpeg to make a copy of the input video file (`hero.mp4`) that starts at 00.000 and runs to 147.000, and to store the output in the destination file `hero_reduced.mp4`. The call to FFmpeg is the same one we would make at the command line if we were not using R, but when making a `system` call from within R we *must* identify our command as a character string – note the use of double quote marks – because the call includes spaces. Depending on the size of the mp4 file, this process may take some time to run.

#### Listing 3: Convert and trim a video file using `av` and FFmpeg

```r
# Convert the WebM file to mp4
av_video_convert("HERO_-_Blender_Open_Movie-full_movie.webm.720p.webm", output = "hero.mp4", verbose = TRUE)

# Trim the file to remove the end credit sequence
system("ffmpeg -ss 00.000 -i hero.mp4 -c:v libx264 -crf 18 -to 147.000 -c:a copy hero_reduced.mp4")
```

### Extracting frames from a video file

The first stage in our colour analysis workflow is to sample frames from the video. We can check the properties of the video file with `av::av_media_info()`. 

#### Listing 4: Get video file description

```r
av_media_info("hero_reduced.mp4")
```

This gives us the duration of the video file, along with details of the video and audio formats:

```
## $duration
## [1] 147.03
## 
## $video
##   width height codec frames framerate  format
## 1  1280    536  h264   3525  23.97602 yuv420p
## 
## $audio
##   channels sample_rate codec frames bitrate layout
## 1        2       48000   aac   6892  128590 stereo
```

We see from the output that the duration of the film is 147.03 seconds with a frame rate of 23.976 frames per second and a total of 3525 frames. From this we want to extract a large enough number of frames so that our sample will be representative of the shots in the film as a whole. At the same time, we do not want to overburden our computational resources with redundant data. Taking three frames every second will give us a sample of 441 frames, where the time elapsed between consecutive frames is 0.33 seconds.

The function `av::av_video_images()` splits a video file into frames and requires a video file as input, a destination directory to store the images, the format of the images to be outputted, and the number of frames per second to be sampled. Depending on the number of frames we choose to extract, this process may take a while to run.

#### Listing 5: Sample frames from *Hero*

```r
av_video_images("hero_reduced.mp4", destdir = here("frames"), format = "jpg", fps = 3)
```

The command `destdir = here("frames")` will create a folder in our project directory called frames in which we store the frames we have sampled from the reduced version of the film. It is from this directory within our project directory from which we will later read the frames.

In this tutorial we will work with video frames as jpegs, but we could work with PNG files by setting `format` to `format = "png"`. PNG files are lossless and so the file size for each image will be larger, resulting an increase in the computational resources required for analysis.

The number of frames to extract from a video file is a contextual decision determined on a case-by-case basis of what we hope to achieve with our analysis, the duration and frame rate of the film, and the computational resources available to us.

# The average colour of a frame

The data reduction method most widely used when analysing colour in film is the average colour of a frame. Here, we will calculate the average colour of a frame in both the RGB and L\*a\*b\* colour spaces and compare the results. The average colour of a frame in RGB is a tuple where the values are the means of the red, green, and blue channels of that frame: (<span style="text-decoration:overline">&#119877;</span>, <span style="text-decoration:overline">&#119866;</span>, <span style="text-decoration:overline">&#119861;</span>). Similarly, the average colour of a frame in the L\*a\*b\* colour space is a tuple comprising the mean values of each attribute of a frame: (<span style="text-decoration:overline">	
&#119871;\*</span>, <span style="text-decoration:overline">&#119886;\*</span>, <span style="text-decoration:overline">&#119887;\*</span>).

To calculate the average colour of each frame, we apply a `for` loop that iterates over a list of objects, applying a block of code to each object in the list. The `for` loops in Listings 6 and 7 loads each frame we have sampled from *Hero*, calculates the average colour of the frame, and stores the result in a [data frame](https://r4ds.had.co.nz/tidy-data.html). 

First, we get a list of the filenames of all the images in our frames folder which we will store in the object `images` that we will use at various stages of this tutorial:

```r
images <- list.files(here("frames"), pattern = "*.jpg$", full.names = TRUE)
```

We want to include all the frames we have sampled in the object `images` and so we set `pattern = "*.jpg$"` to list all the files that have the extension `.jpg` at the end of their filename. By setting `full.names = TRUE` the directory path is added to the file names to give a relative file path to a frame. This is used to load the frames using `imager::load.image()`.

To store the result of the `for` loop we need an empty data frame for our RGB data. Note that in order to store the average colour for every frame, we *must* create an empty data frame as a destination for our data *outside* the `for` loop. If we create the empty data frame inside the `for` loop it will be created anew every time and will contain only the data for the last frame in the working directory when the loop completes. We call the data frame that stores our RGB data `df_rgb` so that the class of the object is always clear from from preface `df_` and the content of the data frame is clear from the rest of the objects name. To initialise an empty data frame we need to declare the class of the object followed by empty brackets.

```r
df_rgb <- data.frame()
```

We can now calculate the average colour of a frame in RGB colour space and populate our empty data frame with the results so that for each frame in our data set a row in the data frame `df_rgb` will store the name of the image in our `frames` folder (`frame_id`) and the mean value of the red (`R`), green (`G`), and blue (`B`) channels of a frame. These objects are combined into a data frame `rgb` that will have one row by collecting the columns together using `cbind.data.frame()`. At the end of each pass of the loop a new row is added to `df_rgb` `using rbind.data.frame()` containing the data for a frame.

#### Listing 6: Calculate the average colour of a frame in RGB colour space

```r
# Get a list of the image files in the frames folder - make sure full.names=TRUE
images <- list.files(here("frames"), pattern = "*.jpg$", full.names = TRUE)

# Create an empty data frame to store the result of the loop
df_rgb <- data.frame()

for (i in images){

  # Grab the name of i-th frame in the list images but drop the jpeg extension
  frame_id <- gsub(pattern = ".jpg$", "", basename(as.character(i)))

  # Load the i-th frame from images
  im <- load.image(i)

  # Separate the R, G, B channels of a frame, store the colour data as a data frame, and scale by 255
  r <- as.data.frame(R(im)) %>% rename(r = value) %>% select(r)
  g <- as.data.frame(G(im)) %>% rename(g = value) %>% select(g)
  b <- as.data.frame(B(im)) %>% rename(b = value) %>% select(b)
  rgb <- cbind.data.frame(r, g, b) %>% mutate(r = r * 255, g = g * 255, b = b * 255) 

  # Tidy up the workspace by removing the things we no longer need after 
  # collecting and arranging the data from a frame
  rm(im, r, g, b)

  # Get the average value of each channel in the RGB colour space
  rgb <- rgb %>% summarise(r = mean(r), g = mean(g), b = mean(b))

  # Combine the frame id and the mean channel values into a data frame
  rgb <- cbind.data.frame(frame_id, rgb)

  # Add to a new row to df_rgb
  df_rgb <- rbind.data.frame(df_rgb, rgb)
}
```
We can inspect the results of the loop by looking at some rows from `df_rgb`.

```r
# Show some rows of the data frame
df_rgb[58:63,]
```

|     | frame_id<br>`chr` | R<br>`dbl` | G<br>`dbl` | B<br>`dbl` |
| --- | -------------- | ---------- | ---------- | ---------- |
| 58  | image_000058   | 154.2801   | 110.8010   | 104.1484   |
| 59  | image_000059   | 155.0439   | 111.6329   | 104.7774   |
| 60  | image_000060   | 167.2177   | 127.3386   | 124.5169   |
| 61  | image_000061   | 167.6803   | 127.5854   | 124.9104   |
| 62  | image_000062   | 168.2137   | 127.8521   | 125.3026   |
| 63  | image_000063   | 168.6153   | 128.1676   | 125.5957   |

The process is essentially the same for finding the average colour of a frame in L\*a\*b\* colour space (Listing 7). To do this we extract the red, green, and blue channels of each frame, convert the RGb data to L\*a\*b\*, and calculate the mean value of each of the attributes L\*, a\*, and b\*.

We already have a list of the frames in our data set in our environment (the object `images` we created above), so all we need to do is create a new empty data frame for the L\*a\*b\* data (`df_lab`) and apply a new `for` loop.

This loop will take longer to run than the loop in Listing 6 because it requires more steps and takes longer to process the data due to the need to convert colours from RGB to L\*a\*b\* before averaging. We will also convert the average L\*a\*b colour to its polar representation LCH(ab), which we will later use to plot the hue and chroma of the frames in our data set. We also need to convert the average colours in L\*a\*b\* colour space to RGB so we can plot them (because, as noted, above, we can *only* display RGB values).

#### Listing 7: Calculate the average colour of a frame in L\*a\*b\* colour space

```r
# Create an empty data frame to store the results of the loop
df_lab <- data.frame()

for (i in images){

  # Grab the name of each image but drop the jpeg extension
  frame_id <- gsub(pattern = ".jpg$", "", basename(as.character(i)))

  # Load image
  im <- load.image(i)

  # Separate the R, G, B channels, store the colour data as a data frame, and scale by 255
  r <- as.data.frame(R(im)) %>% rename(r = value) %>% select(r)
  g <- as.data.frame(G(im)) %>% rename(g = value) %>% select(g)
  b <- as.data.frame(B(im)) %>% rename(b = value) %>% select(b)
  rgb <- cbind.data.frame(r, g, b) %>% mutate(r = r * 255, g = g * 255, b = b * 255) 

  # Tidy up the workspace by removing the things we no longer need after 
  # collecting and arranging the data from the image
  rm(im, r, g, b)

  # Convert RGB values to the L*a*b* colour space
  lab <- convert_colour(rgb, from = "rgb", to =  "lab")

  # Get the average of each attribute in the L*a*b* colour space
  lab <- lab %>% summarise(L = mean(l), A = mean(a), B = mean(b))

  # Convert the average frame colour in the L*a*b* colour space to the LCH(ab) colour space to obtain the chroma and hue values
  lch <- convert_colour(lab, from = "lab", to =  "lch")

  # Select the chroma (C) and hue (H) columns only because L is the same as the lightness value in L*a*b*
  lch <- lch %>% select(c, h) %>% rename(C = c, H = h)

  # Convert the average L*a*b* values to the RGB colour space for plotting 
  rgb <- convert_colour(lab, from = "lab", to = "rgb")

  # Combine the data for a frame
  pix <- cbind.data.frame(frame_id, lab, lch, rgb)

  # Compile the data for each frame in the sample
  df_lab <- rbind.data.frame(df_lab, pix)
}
```

We can inspect the same rows we looked at above to see the mean attributes of the frames in the L\*a\*b\* and LCH(ab) colour spaces.

```r
# Show some rows of the data frame
df_lab[58:63,]
```

|     | frame_id<br>`chr` | L<br>`dbl` | A<br>`dbl` | B<br>`dbl` | C<br>`dbl` | H<br>`dbl` | r<br>`dbl` | g<br>`dbl` | b<br>`dbl` |
| --- | -------------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
| 58  | image_000058   | 50.46646   | 16.53308   | 10.712487  | 19.70025   | 32.94095   | 153.3979   | 109.4193   | 102.6688   |
| 59  | image_000059   | 50.77038   | 16.46068   | 10.789166  | 19.68146   | 33.24290   | 154.1496   | 110.2238   | 103.2833   |
| 60  | image_000060   | 56.76660   | 15.39836   | 7.526184   | 17.13921   | 26.04782   | 167.1311   | 126.3213   | 123.7643   |
| 61  | image_000061   | 56.89181   | 15.50414   | 7.484687   | 17.21623   | 25.76915   | 167.6146   | 126.5738   | 124.1574   |
| 62  | image_000062   | 57.03260   | 15.63162   | 7.466675   | 17.32335   | 25.53220   | 168.1875   | 126.8503   | 124.5507   |
| 63  | image_000063   | 57.16993   | 15.66134   | 7.496116   | 17.36287   | 25.57759   | 168.6250   | 127.1803   | 124.8500   |

Column names in a data frame need to be unique but using both the RGB and L\*a\*b\* colour spaces will leave us with two columns named `b`, one for the b* attribute of L\*a\*b\* and one for the blue channel in RGB. This is why we changed the names of the columns of the attributes of  the L\*a\*b\* colour space to uppercase letters, but we left the RGB colour attributes as lowercase. Object names are case sensitive in R, so `B` and `b` will be unique and will not conflict.

We can compare the results obtained when working in different colour spaces by plotting the average colour of each frame as a temporally ordered dot plot (Listing 8). We have 441 frames in our sample and because 441 is equal to 21<sup>2</sup> arranging the results as a 21 × 21 array will give us a pleasingly [Hirst](https://en.wikipedia.org/wiki/Damien_Hirst)-like visualisation. First, we need to create a data frame of the x and y coordinates we will use for plotting the dots. Combining this data frame, with RGB values from `df_rgb` and `df_lab` gives us the data we need to create the dot plots for each colour space.

#### Listing 8: Plot the average colours in different colour spaces as temporally ordered dot plots

```r
# Create a data frame of coordinates for plotting
x <- data.frame(x = rep(1:21, 21)) %>% arrange(x)
y <- rep(1:21, 21)
df_xy <- cbind.data.frame(x, y)

# Combine plotting coordinates with RGB and L*a*b* data -
# we only need to select the r, g, and b columns for plotting
df_dot_rgb <- cbind.data.frame(df_xy, df_rgb[2:4])
df_dot_lab <- cbind.data.frame(df_xy, df_lab[7:9])

# Create the dot plot from the RGB data
rgb_dot_plot <- ggplot(data = df_dot_rgb) +
  geom_point(aes(x = x, y = y, colour = rgb(r, g, b, maxColorValue = 255)), size = 3) +
  scale_colour_identity() +
  coord_flip() +
  scale_x_continuous(trans = "reverse") + 
  labs(title = "Average RGB colour") +
  theme_void()

# Create the dot plot from the L*a*b* data
lab_dot_plot <- ggplot(data = df_dot_lab) +
  geom_point(aes(x = x, y = y, colour = rgb(r, g, b, maxColorValue = 255)), size = 3) +
  scale_colour_identity() +
  coord_flip() +
  scale_x_continuous(trans = "reverse") + 
  labs(title = "Average L*a*b* colour") +
  theme_void()

# Combine the plots into a single figure
dot_figure <- ggarrange(rgb_dot_plot, lab_dot_plot, nrow = 2, align = "v")

# Call the plot
dot_figure
```

<!--Figure 4-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R4.png" caption="Figure 4: Temporally ordered dot plots of the average colour of 441 frames sampled from *Hero* in the RGB and L\*a\*b\* colour spaces." %}

There does not appear to be a large difference between the corresponding pixels in the two plots. Certainly, in terms of the hue of the dots, there is no large difference between the results produced in different colour spaces, though there are some discernible differences in brightness and saturation. The average L\*a\*b\* colours tend to be darker than the average RGB colours because the latter introduces a bias to brighter colours into our data. This is particularly noticeable for grey pixels in Figure 4. However, these differences are small and if we chose to work with the RGB colour space to describe the average colour we would not arrive at radically different conclusions to working with L\*a\*b\* colours, despite the lack of perceptual uniformity. 

However, the RGB colour space's lack of perceptual uniformity will impact our later analyses. When we come to apply cluster analysis in section six we will get inaccurate results using the average RGB colours because the RGB colour space is non-Euclidean. Consequently, the Euclidean distance between in RGB colours does not reflect perceived differences in colour, rendering clustering methods that use the Euclidean distance metric such as *k*-means clustering inappropriate. We will therefore continue our analysis using the average frame colours in the L\*a\*b\* colour space and its polar representation LCH(ab).

The dots in each plot in Figure 4 are arranged so that they are temporally ordered left to right and top to bottom and so provide some limited information about how colour changes over the course of the film. In the next section, we will create several plots that will allow us to look in more detail at the distribution of the average colours of the frames and the temporal structure of colour in *Hero*.

# Visualising film colours in a colour space

In this section, we will work with the average colour of a frame in the L\*a\*b\* and LCH(ab) colour spaces, which are stored in the data frame `df_lab` we created in Listing 7 above, in order to visualise the results we have obtained. The first task is to plot the distribution of the average colours in the colour space (Listing 9). This allows us to see the range of colours present in the film.

#### Listing 9: Plot the average colour of a frame in L\*a\*b\* space using the data frame `df_lab`

```r
# Create the plot
lab_plot <- ggplot(data = df_lab) + 
  geom_point(aes(x = A, y = B, colour = rgb(r, g, b, maxColorValue = 255))) +
  scale_colour_identity() +
  labs(x = "Green - Red (a*)",
       y = "Blue - Yellow (b*)") +
  theme_minimal()

# Create the density plot
lab_plot_2d <- ggplot(data = df_lab) +
  geom_density_2d_filled(aes(x = A, y = B)) +
  scale_fill_viridis(option = "viridis", discrete = TRUE, direction = 1) +
  labs(x = "Green - Red (a*)",
       y = "Blue - Yellow (b*)",
       fill = "Density") +
  guides(fill = "none") +
  theme_minimal()

# Combine the plots into a single figure
lab_figure <- ggarrange(lab_plot, lab_plot_2d, 
                        nrow = 2, align = "v", labels = "AUTO")

# Call the figure
lab_figure
```

<!--Figure 5-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R5.png" caption="Figure 5: The distribution (A) and density (B) of the average colour of 441 frames sampled from *Hero* in L\*a\*b\* colour space." %}

From Figure 5.a we see that the range of colours in the film is concentrated within a relatively narrow range of values in the L*a*b* space. We can also see what colours are absent: the bottom left quadrant is empty indicating there are no cyan pixels. Figure 5.A gives us an overall idea of the distribution of the average colours in the film, but it also obscures much useful information. For example, there are numerous overlaid data points where a* = b* = 0. This is due to the several black screens from the opening and closing credits, and the one frame in the sample with a lightness of 100%, where a white flash is used as a transition between scenes. It is easier to see the concentration of pixels in a colour space by plotting the two-dimensional density using `geom_density_2d_filled`. Figure 5.B shows us there is a concentration of points at the origin we might otherwise have overlooked. There are also several other concentrations of data points indicating clusters of colours that we will address in section six below.

#### Listing 10: Plot the average colour of a frame in LCH(ab) space using the data frame `df_lab`

```r
# Plot the average colour of a frame using hue and chroma
lch_plot <- ggplot(data = df_lab) + 
  geom_point(aes(x = H, y = C, colour = rgb(r, g, b, maxColorValue = 255))) +  
  scale_colour_identity() +  
  coord_polar(theta = "x") +  
  scale_x_continuous(limits = c(0, 360), breaks = seq(0, 330, 30)) +  
  scale_y_continuous(name = "Chroma (%)", limits = c(0,100)) +  
  theme_minimal() +  
  theme(axis.title.x = element_blank())

# Plot chroma against lightness
chroma_light_plot <- ggplot(data = df_lab) +  
  geom_point(aes(x = C, y = L, colour = rgb(r, g, b, maxColorValue = 255))) +  
  scale_colour_identity() +  
  labs(x = "Chroma (%)",  
       y = "Lightness (%)") +  
  theme_minimal()

# Combine the plots into a single figure
lch_figure <- ggarrange(lch_plot, chroma_light_plot, 
                        ncol = 2, align = "h", labels = "AUTO")

# Call the figure
lch_figure
```

<!--Figure 6-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R6.png" caption="Figure 6: The distribution of hue and chroma (A) and chroma and lightness (B) of the average colour of 441 frames sampled from *Hero*." %}

Plotting the average colour of each sampled frame in LCH(ab) space in Figure 6.A provides an alternative representation of the information in Figure 5.A that is easier to understand becaue hue values are more intuitive than a* and b*. This plot also includes chroma on the radial distance from the centre and shows that the average colours have a limited range of chroma values. We can also plot chroma against lightness (Figure 6.B) in order to see the relationship between these two attributes. Again, we see that both attributes have a limited range of values for frames in the sample. Overall, the impression we get from looking at the information displayed in Figures 5 and 6 is that this film has a limited palette of relatively light, unsaturated hues colours.

In order to see how the lightness and chroma evolve over the course of the film we can plot them against time (Listing 11). We will therefore need to create a frame vector to number each frame in order and a time vector with time gaps of one-third of a second and add to the data frame `df_lab` that contains our L\*a\*b\* and LCH(ab) data.

#### Listing 11: Plot lightness and chroma of the against time of the average colour of a set of frames

```r
# Add frame and time vectors to the pixel data for plotting
df_lab <- df_lab %>% mutate(frame = 1:length(df_lab$frame_id),
                            time = frame * 1/3)

# Plot lightness against time
light_time_plot <- ggplot(data = df_lab) + 
  geom_path(aes(x = time, y = L), colour = "grey40") +
  geom_point(aes(x = time, y = L, colour = rgb(r, g, b, maxColorValue = 255))) +
  scale_colour_identity() +
  scale_x_continuous(breaks = seq(0, 140, 20)) +
  labs(x = "Time (s)",
       y = "Lightness (%)") +
  theme_minimal()

# Plot chroma against time
chroma_time_plot <- ggplot(data = df_lab) + 
  geom_path(aes(x = time, y = C), colour = "grey40") +
  geom_point(aes(x = time, y = C, colour = rgb(r, g, b, maxColorValue = 255))) +
  scale_colour_identity() +
  scale_x_continuous(breaks = seq(0, 140, 20)) +
  scale_y_continuous(limits = c(0, 30), breaks = seq(0, 30, 5)) +
  labs(x = "Time (s)",
       y = "Chroma (%)") +
  theme_minimal()

# Combine the plots into a single figure
lch_t_figure <- ggarrange(light_time_plot, chroma_time_plot, 
                          nrow = 2, align = "v", labels = "AUTO")

# Call the figure
lch_t_figure
```

<!--Figure 7-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R7.png" caption="Figure 7: Lightness (A) and chroma (B) against time of the average colour of 441 frames sampled from *Hero*." %}

Figure 7 is instructive because it challenges our sense of colour as a single object and shows that we need to consider each of the attributes of a colour individually. In Figure 7.A we can segment the film based on the lightness values of the average colours into two sections (leaving aside the opening and closing credits): lightness shows a slight increasing trend from 10 seconds until 87 seconds, when the fight on the airship during the storm begins, and then shows another increasing trend from 89.7 seconds to 143 seconds. In Figure 7.B there is an increasing trend in chroma from 24.3 seconds, when the first hero places the mysterious artefact in the machine, until the climax of the film at 143 seconds.

# Constructing a colour palette for a film

Constructing a colour palette for a film is an unsupervised machine learning problem involving the sorting *n* objects (i.e., pixels) into *k* clusters (i.e., colours) using [cluster analysis](https://en.wikipedia.org/wiki/Cluster_analysis) so that the centroid of a cluster functions an exemplar of all the data points assigned to that cluster.[^8] Typically, [*k*-means clustering](https://en.wikipedia.org/wiki/K-means_clustering) is used for this process and there are many demonstrations available on how do this. Rather than add to them here, we will use a [Partitioning Around Medoids](https://en.wikipedia.org/wiki/K-medoids) (PAM) approach suitable for large data sets in which each cluster is represented by a member of that cluster called a [medoid](https://en.wikipedia.org/wiki/Medoid). *k*-means clustering is a much quicker algorithm than PAM, and so we will use [CLARA](https://towardsdatascience.com/17-clustering-algorithms-used-in-data-science-mining-49dbfa5bf69a#5190) (Clustering Large Applications) as a clustering method suitable for *k*-medoids clustering with large data sets. CLARA proceeds by drawing multiple random samples from a data set of size *m*, applying PAM to each sample to find the optimal set of medoids based on the minimisation of a distance measure (such as the Euclidean distance or [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry)), and retaining the best clustering based on the set of medoids that has the smallest dissimilarity for the whole data set.

We will implement CLARA using `fpc::pamk()` (see Listing 12), which will allow us to search for the optimal value of *k* that best fits the data across a range of values. The average colours of the frames have a limited range of hues, and so we will limit possible values of *k* to the range [5, 15]. 

There are several methods of selecting the optimal number of clusters and here we will use the [average silhouette width](https://en.wikipedia.org/wiki/Silhouette_(clustering)) (`criterion = "asw"`). The silhouette value measures the *cohesion* of anobject relative to the cluster to which it belongs and the *separation* of an object relative to other clusters. The average silhouette value of a cluster measures how cohesive the objects in a cluster are and the average silhouette value of a data set is a measure of how well the data has been clustered.

The L\*a\*b\* colour space is perceptually uniform with the perceived difference between two colours well approximated by the Euclidean distance between them and so we will use this as a distance measure for clustering. 

We need to set `usepam = FALSE` in order for the `pamk()` function to apply CLARA rather than the default PAM algorithm, and we will draw 100 random samples with each sample containing 200 frames from our data set.

We will also set `SCALING = FALSE` because we will scale the data manually before applying CLARA. The scale command implements a [z-score transformation](https://en.wikipedia.org/wiki/Standard_score),

<center>
&#119911; = (&#119909; - &#120583;)/&#120590; , 
</center><br>

so that each attribute will have a [mean](https://en.wikipedia.org/wiki/Mean) (&#120583;) of 0 and [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) (&#120590;) of 1. Scaling the colour attributes prior to clustering is necessary because the different attributes of an L\*a\*b\* colour are on different scales with different variances. If we do not scale the data the attribute with the largest variance will dominate the output of the clustering algorithm. Once clustering has been performed, the medoids need to be rescaled so that they are in the same scale as the original data and are meaningful values in the L\*a\*b\* colour space. Therefore, we will need to get the mean and standard deviation of each colour attribute in order to reverse the &#119911;-transformation of the medoids identified by the CLARA algorithm  so that they are meaningful in the colour space. To reverse the transformation, we simply multiply the values in the tuple of a medoid by the standard deviation and add the mean of each attribute.

The results of the clustering analysis can be visualised as a treemap (Figure 8) with the different colours of the palette represented as a set of nested rectangles where the area of each rectangle is proportional to the number of pixels in that cluster. This is an efficient way of representing the colours in a palette and retains information about the prevalence of a colour in a data set.

#### Listing 12: Apply *k*-medoids clustering using CLARA and visualise the result as a treemap

```r
# Calculate the means and standard deviations of colour attributes ready for rescaling
mu_L <- mean(df_lab$L); sd_L <- sd(df_lab$L)
mu_A <- mean(df_lab$A); sd_A <- sd(df_lab$A)
mu_B <- mean(df_lab$B); sd_B <- sd(df_lab$B)

# Select the L*a*b* data from df_lab for partitioning and apply the z-score transformation
df_lab_scaled <- df_lab %>% select(L, A, B) %>% scale

# Apply CLARA using fpc::pamk()
clara_res <- pamk(df_lab_scaled, krange = 5:15, criterion = "asw", 
                  usepam = FALSE, scaling = FALSE, samples = 100, 
                  sampsize = 200, metric = "euclidean")

# Get the k medoids of the optimal solution returned by CLARA
medoids <- as.data.frame(clara_res$pamobject$medoids)

# Get the number of data points in each cluster
clara_data <- clara_res$pamobject$clusinfo[,1]

# Create a data frame including the number of data points in each cluster, 
# the percentage of data points in each cluster (per), 
# and the rescaled medoids in L*a*b* space
medoids_rescaled <- medoids %>% mutate(size = clara_data) %>%
  mutate(per = round(size/sum(size), 3)) %>%
  mutate(L_rn = (L * sd_L) + mu_L) %>%
  mutate(A_rn = (A * sd_A) + mu_A) %>%
  mutate(B_rn = (B * sd_B) + mu_B) %>%
  select(4:8)

# Convert the L*a*b* values of the medoids to RGB for plotting and combine with medoids_rescaled data frame
rgbPalette <- convert_colour(medoids_rescaled[3:5],  from = "lab", to = "rgb")
medoids_rescaled <- cbind.data.frame(medoids_rescaled, rgbPalette)

# Draw a treemap of the palette using treempify::geom_treemap()
palette_treemap <- ggplot(data = medoids_rescaled) +
  geom_treemap(aes(area = per), 
               fill = rgb(medoids_rescaled$r, 
                          medoids_rescaled$g, 
                          medoids_rescaled$b, 
                          maxColorValue = 255)) +
  theme_minimal()

# Call the plot
palette_treemap
```

<!--Figure 8-->

{% include figure.html filename="An-introduction to-computational analysis-of-film-colour-in-R8.png" caption="Figure 8: Treemap palette of average colour of 441 frames from *Hero* produced by *k*-medoids clustering using CLARA." %}

The treemap of the colour palette in Figure 8 has six colours, five of which are relatively light and unsaturated, and which cover a narrow range of hues. This result confirms our interpretation based on the distribution of colours in the L\*a\*b\* and LCH(ab) colour spaces above, with the additional information of the relative proportion of the size of those colours.

The number of clusters in the palette may vary according to the range of values of *k* searched. For example, expanding the range of *k* in Listing 12 to `5:20` returns an optimal clustering with 19 medoids, but the differences between several of the colours of the medoids are difficult to distinguish and the number of pixels in a cluster becomes small. It is important to remember that when treating the construction of a colour palette as a machine learning problem, the solution returned is optimal and not perfect; that is, it will be the best solution available under a set of restrictions, including the available data, the algorithm selected, and the chosen parameters for that algorithm.

# Conclusion

In this tutorial we have covered a range of topics in computational analysis of film colour that create opportunities for understanding colour in the cinema and created several different visualisations of colour in a short film. These visualisations perform three key functions in any project employing computational approaches to film colour. First, they are descriptive, presenting a lot of information about colour in a film in a way that is efficient and easy for the audience to comprehend. Second, they are communicative, allowing us to overcome the inherent problem of describing the colour in a film verbally and to use the colours themselves. Finally, and most importantly, they are analytic, allowing us to see features in the use of colour in a film that may be otherwise difficult to identify from watching the film. The difference in the evolution of lightness and chroma over time is a good example of how data visualisation allows us to see something new about the film.

# Endnotes

[^1]: For an overvier of the aesthetics of colour in the cinema see Simon Brown, Sarah Street, and Liz Watkins, "Introduction," in *Color and the Moving Image: History, Theory, Aesthetics, Archive*, eited by Simon Brown, Sarah Street, and Liz Watkins (New York, NY: Routledge), 1-9; Paul Coates, *Cinema and Colour: The Saturated Image* (Basingstoke: Palgrave Macmillan, 2010); and Wendy Everett, "Mapping colour: an introduction to the theories and practices of colour," in *Questions of Colour in Cinema: From Paintbrush to Pixel*, edited by Wendy Everett (Oxford: Peter Lang, 2007), 7-38.

[^2]: Ornam Rotem, "The Syntactic Role Of Colour in Film," *Kinema: A Journal for Film and Audiovisual Media* 19, no. 1 (2003): 5-26. [https://doi.org/10.15353/kinema.vi.1050](https://doi.org/10.15353/kinema.vi.1050).

[^3]: Hyeon-Jeong Suk and Hans Irtel, "Emotional response to color across media," *Color Research & Application* 35, no. 1 (2010): 64–77. [https://doi.org/10.1002/col.20554](https://doi.org/10.1002/col.20554)

[^4]: I-Ping Chen, Fang-Yi Wu, and Chih-Hsiang Lin, "Characteristic color use in different film genres," *Empirical Studies of the Arts* 30, no. 1 (2012): 39–57. [https://doi.org/10.2190/EM.30.1.e](https://doi.org/10.2190/EM.30.1.e).

[^5]: Barbara Flueckiger and Gaudenz Halter, "Methods and advanced tools for the analysis of film colors in digital humanities," *DHQ: Digital Humanities Quarterly* 14, no. 4 (2020): [http://www.digitalhumanities.org/dhq/vol/14/4/000500/000500.html](http://www.digitalhumanities.org/dhq/vol/14/4/000500/000500.html).

[^6]: Hadley Wickham and Garrett Grolemund, *R for Data Science: Import, Tidy, Transform, Visualize, and Model Data* (Sebastopol,CA: O’Reilly, 2016).

[^7]: Andreas Koschan and Mongi A. Abidi, *Digital Color Image Processing* (Hoboken, NJ: John Wiley & Sons, 2008), 37.

[^8]: Leonard Kaufman, and Peter J. Rousseeuw, *Finding Groups in Data: An Introduction to Cluster Analysis* (Hoboken, NJ: John Wiley and Sons, 1990).
