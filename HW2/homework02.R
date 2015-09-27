# =====================================================
# Stat133: HW2
# Author(s): Gaston Sanchez
# Description: This assignment has 3 main purposes:
#       - working with data frames, vectors and factors
#       - practice basic manipulation of data structures
#       - creation of simple graphics
# Data: Camping Tents
# Packages: readr
# =====================================================


# Please submit your own R script file to bcourses


# Write your name
# Name:Shulin




# =====================================================
# Reading Datatables in R
# =====================================================
# We'll start practicing reading tables in R
# The data for this assignment is in the file 'tents1.csv'
# (available in the folder 'datasets' in the 
# github repository of the course)
# =====================================================


# First let's use download.file() to download 
# the data file 'tents1.csv' to your computer;
# You'll have to specify your own destination ('destfile')
# e.g. in my case I'm specifying: "~/Downloads/tents1.csv"
# (your 'destfile' will probably be different!)
download.file(
  url = 'https://raw.githubusercontent.com/gastonstat/stat133/master/datasets/tents1.csv', 
  destfile = '/Users/Shulin/programming/stat133/stat133-git/HW2/tents1.csv')


# Importing Option 1:
# Use read.csv() to import 'tents1.csv' and assign it to
# an object called 'tdf1'




# Importing Option 2:
# Use read.csv() to import 'tents1.csv' and assign it to
# an object called 'tdf2'.
# In this case, strings must NOT be converted into factors!




# Importing Option 3:
# Create a character vector 'col_class' with the following classes
# for the columns (to be used with argument 'colClasses')
# - name:     character
# - brand:    character
# - price:    numeric
# - weight:   numeric
# - height:   integer
# - bestuse:  factor
# - seasons:  factor
# - capacity: factor


# Use read.table() to import 'tents1.csv' and assign it to 
# an object called 'tdf3';
# Pass the vector col_class to the argument 'colClasses',
# and specify the right field separator, and header




# Importing Option 4:
# Use read_csv() from package "readr" to import 'tents1.csv'
# and assign it to an object called 'tents'
# Use the argument 'col_types' to specify column types:
# - name:     character
# - brand:    character
# - price:    numeric
# - weight:   numeric
# - height:   integer
# - bestuse:  character
# - seasons:  character
# - capacity: character
library(readr)
tents_url <- '/Users/Shulin/programming/stat133/stat133-git/HW2/tents1.csv'
tents <- read_csv(tents_url, col_name = TRUE, col_types = 'ccddiccc')



# =====================================================
# Inspecting data frames
# =====================================================
# Once you have your data frame 'tents', the next step 
# involves performing a first exploration
# =====================================================


# inspect the data structure of 'tents'
str(tents)

# check the class of the object 'tents'
class(tents)

# how many rows in the dataset?
nrow(tents)

# how many columns in the dataset?
ncol(tents)

# names of columns
colnames(tents)

# take a look at the first 5 rows
head(tents, 5)

# take a look at the last 3 rows
tail(tents, 3)



# =====================================================
# Quantitative Variables:
# =====================================================
# Exploring the quantitative variables
# 1) price
# 2) weight
# 3) height
# =====================================================


# get numeric summaries of each quantitative variable
summary(tents$price)
summary(tents$weight)
summary(tents$height)

# instead of using the summary() function, find functions
# that allow you to get the following summaries for 'price'
# - minimum value
min(tents$price)
# - first quartile (i.e. 25th percentile)
quantile(tents$price, 0.25)
# - median value (i.e. 50th percentile)
median(tents$price)
# - mean value
mean(tents$price)
# - third quartile (i.e. 75th percentile)
quantile(tents$price, 0.75)
# - maximum value
max(tents$price)
# - inter-quartile range (IQR)
IQR(tents$price)
# - standard deviation
sd(tents$price)

# weight is given in grams;
# add a new variable 'weight_lbs' to 'tents' for weight in pounds
tents$weight_lbs <- tents$weight * 0.00220462 


# height is given in centimeters;
# add a new variable 'height_in' to 'tents' for height in inches
tents$height_in = tents$height * 0.3937010

# how many tents have a price greater than $400
sum(tents$price > 400)

# how many tents have a price less than or equal to $300
sum(tents$price <= 300)

# how many tents have a price between $300 and $400
# (including both $300 and $400 prices)
sum(tents$price <= 400 & tents$price >= 300)

# what's the name of the tent with maximum price
tents$name[which.max(tents$price)]

# what's the name of the tent with minimum price
tents$name[which.min(tents$price)]

# what's the name of the tent with maximum weight
tents$name[which.max(tents$weight)]

# what's the name of the tent with minimum weight
tents$name[which.min(tents$weight)]


# select the data of tents with 
# price > $400 AND weight < 1500 grams
#since it's a df, we need rows and cols
tents[tents$price > 400 & tents$weight < 1500, ]

# calculate the 90th percentile for height and 
# assign it to the object 'height_p90'
height_p90 <- quantile(tents$height, .90)

# calculate the 90th percentile for weight and 
# assign it to the object 'weight_p90'
weight_p90 <- quantile(tents$weight, .90)


# select the data of tents with 
# height > height_p90 AND weight > weight_p90
tents[tents$height > height_p90 & tents$weight > weight_p90, ]




# obtain a new data frame called 'rei' containing
# the data of those tents with brand 'rei';
# and inspect its dimension

#toLook
rei <- data.frame(tents[tents$brand == "rei",])


# Use the cut() function to create a factor 'price_cut' from 
# all the tent prices;
# for the argument 'breaks' give a vector of cutting points
# such that the obtained levels are as follows:
#    (0, 100]
#  (100, 200]
#  (200, 300]
#  (300, 400]
#  (400, 500]
#  (500, 600]
#  (600, 700]
price_cut <- cut(tents$price, breaks= seq(0,700,by=100))

# use table() to check the obtained frequencies of 'price_cut'
table(price_cut)



# Use cut() to create a factor 'weight_cut' by using the
# breaking points and labels according to the following table:
# ----------------------
#     intervals | labels
# --------------|-------
#     (0, 1000] |  1kg
#  (1000, 2000] |  2kg
#  (2000, 3000] |  3kg
#  (3000, 4000] |  4kg
#  (4000, 5000] |  5kg
#  (5000, 6000] |  6kg
#  (6000, 7000] |  7kg
#  (7000, 8000] |  8kg
#  (8000, 9000] |  9kg
# ----------------------


# verify that the frequencies given by table(weight_cut) are:
# 1kg 2kg 3kg 4kg 5kg 6kg 7kg 8kg 9kg 
#   3  24  30   7   7   2   9   3   3 
weight_cut <- cut(tents$weight, breaks = seq(0,9000,1000))
table(weight_cut)



# =====================================================
# Statistical graphics of Quantitative Variables
# =====================================================
# for each quantitative variable, obtain the following plots:
# - histogram
# - boxplot
# - density curve
# (look at each graphic carefully and see what types 
# of distribution patterns show each variable)
# =====================================================
hist(tents$price, col = "blue")
hist(tents$weight, col = "purple")

boxplot(tents$price, horizontal = TRUE, main = "Price")
boxplot(tents$weight, horizontal = TRUE, main = "Weight")

plot(density(tents$price))
plot(density(tents$weight))


# Obtain scatter plots of:
# price, height
# price, weight
# height, weight

plot(tents$price, tents$height)
plot(tents$price, tents$weight)
plot(tents$height, tents$weight)



# Obtain a scatter plot matrix of price, height, and weight
pairs(tents[ , 3:5])



# =====================================================
# Plot challenge: 
# Here's a small graphic challenge; you'll need to 
# read the documentation of plot() and par()
# =====================================================
# Obtain a scatter plot of weight and height such that:
# - Axis are labeled with the corresponding variable name
# - Points are colored with alpha transparency
#   (choose a color of your preference)
# - The symbol of points are filled triangles
# - x-axis ranges from 0 to 10000
# - y-axis ranges from 80 to 220
# - Include a title
plot.new()
#given the xy limit of the graoh
plot.window(xlim = c(0, 10000), ylim = c(80, 220))
#add an axis below
axis(side = 1, at = seq(0,10000,2000))
#add an left axis
axis(side = 2, at = seq(80, 220, 20))

mtext('Weight', side = 1, line = 3)
mtext('Height', side = 2, line = 2.5)
points(tents$weight, tents$height, pch = 25, col = '#CC00FF', cex = 1.3)
text(tents$weight, tents$height, labels = abbreviate(tents$weight), 
     col = '#99FFCC', cex = 0.9, pos = 4)
title('Weight and Height')







# =====================================================
# Qualitative Variables
# =====================================================
# Now let's focus on the qualitative variables:
# 1) brand
# 2) bestuse
# 3) seasons
# 4) capacity
# =====================================================


# get frequency tables of each qualitative variable
table(tents$brand)
table(tents$bestuse)
table(tents$seasons)
table(tents$capacity)


# what is the brand with less number of tents
least_tent <- sort(table(tents$brand), decreasing = FALSE)
least_tent[1]

# are there any tents of brand 'rei'?
# and if so, how many?
is.element('rei', tents$brand)
sum(tents$brand == "rei")

# are there any tents of brand 'mountain-hardwear'
# and if so, how many?
is.element('mountain-hardwear', tents$brand)
sum(tents$brand == "mountain-hardwear")

# how many 'rei' tents are intended to be
# used ('bestuse') for Mountaineering
sum(tents$brand == "rei" & tents$bestuse == "Mountaineering")

# what unique brands have tents intended to be used for 'Mountaineering'
unique(tents$brand[(tents$bestuse == "Mountaineering")])



# =====================================================
# Statistical graphics of Qualitative Variables
# =====================================================
# for 'bestuse', 'seasons', and 'capacity' obtain 
# the following plots:
# - bar plot
# - dot chart
# - pie chart
# (feel free to change colors, add titles, and rank values)
# =====================================================
barplot(table(tents$bestuse))
barplot(table(tents$seasons))
barplot(table(tents$capacity))
dotchart(table(tents$bestuse))
dotchart(table(tents$seasons))
dotchart(table(tents$capacity))
pie(table(tents$bestuse))
pie(table(tents$seasons))
pie(table(tents$capacity))

# =====================================================
# Plot challenge: 
# =====================================================
# Make a barplot for 'brand' such that:
# - bars are horizontally oriented
# - bars are arranged in decreasing order
# - bars without a border
# - brand labels are perpendicular to the y-axis
#   (i.e. labels horizontally oriented)
# - modify margins in order to have enough room for labels 
# - x-axis ranges from 0 to 25
# - include a title

par(mar=c(2,2,1,1))
barplot(sort(table(tents$brand)), horiz=TRUE, las=2, border=NA, xlim=c(0,25),
        main="Brand")






# =====================================================
# More basic manipulations
# =====================================================


# summary of 'price' of big-agnes tents
summary(tents[tents$brand == "big-agnes", "price"])

# summary of 'price' of rei tents
summary(tents[tents$brand == "rei", "price"])

# cross-table of seasons and bestuse
# install.packages("gmodels") if you dont have such library installed yet.
library(gmodels)
CrossTable(tents$seasons, tents$bestuse)

# =====================================================
# Bivariate Plots
# =====================================================


# use boxplot() to plot the distribution of 'weight' 
# conditional to:
# - brand
# - bestuse
# - capacity
# - seasons
# (get a boxplot for each categorical variable)
boxplot(weight~brand, data = tents, main = "Weight and Brand")
boxplot(weight~bestuse, data = tents, main = "Weight and Bestuse")
boxplot(weight~capacity, data = tents, main = "Weight and Capacity")
boxplot(weight~seasons, data = tents, main = "Weight and Seasons")





# make a scatter-plot of height and weight, using 
# 'capacity' as a factor for the color argument
plot(tents$height, tents$weight, col = factor(tents$capacity))

# get the same scatter plot but now pass 'bestuse'
# as a factor for the color argument
plot(tents$height, tents$weight, col = factor(tents$bestuse))

# remember that factors are internally stored as
# integer vectors. To get the integers associated to the 
# levels of a factor you can use unclass(). For instance:


# make the same scatter plot, using 'bestuse' as factor for colors,
# and using the integers associated to factor 'bestuse' for the
# argument that changes the type of plotted symbol
plot(tents$height, tents$weight, col = factor(tents$bestuse), pch = unclass(factor(tents$bestuse)))





# =====================================================
# Plot challenge: 
# =====================================================


# obtain a new data frame called 'big_agnes'
# by subsetting tents of brand 'big-agnes'
big_agnes <- subset(tents, brand == "big-agnes")

# create a vector of colors for big-agnes tents according to 'bestuse':
# 'Carcamping' tents in color 'tomato'
# 'Backpacking' tents in color 'orange'
colors <- c(big_agnes$bestuse)
colors[big_agnes$bestuse == "Carcamping"] <- "tomato"
colors[big_agnes$bestuse == "Backpacking"] <- "orange"
big_agnes$color <- colors


# Make a scatter plot of 'weight' and 'height' (of 'big-agnes' tents)
# The background of the entire plot must be of color 'gray95'
# Instead of points, show the name of each big-agnes tent
# Use the vector of colors to color tent names
# Include a legend in the bottom-right corner indicating the 
# 'bestuse' types and their corresponding colors
# Add a title

par(bg = "gray95")
#type='n' here is to erase the points inside the graph
plot(big_agnes$weight, big_agnes$height, main = "weight and height",
    type="n")
legend(6850, 130, legend=c("Carcamping", "Backpacking"),
       col=c("tomato", "orange"), lty=1:2, cex=0.8)
text(big_agnes$weight, big_agnes$height, labels=big_agnes$name, cex= 0.8,  
     col = big_agnes$color)

