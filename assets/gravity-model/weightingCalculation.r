install.packages(MASS) #1
library(MASS) #2


gravityModelData <- read.csv("VagrantsExampleData.csv") #3

gravityModel <- glm.nb(vagrants~log(population)+log(distance)+wheat+wages+wageTrajectory, data=gravityModelData, na.action=na.exclude) #4
summary(gravityModel) #5