library("ggpubr")
library(extrafont)
library(dplyr)
library(stringr)

loadfonts()

# generate energy consumption result for every trade burst/burst 
# treatment: high_even vs high_burst
# treatment: burst------------------------------------------------------------------------------------
setwd(".")
files = list.files(path="./burst/", pattern="*.csv")
energyCon = list()

for (i in 1:length(files)) {
  print(i)
  myfile = read.csv(paste("./burst/", files[i], sep=""))
  energyCon[i] = (sum(myfile[2],na.rm = TRUE)/lengths(myfile[1]))/1000000*5*60      
}
df_burst <- data.frame(energy_consumption = unlist(energyCon))

# descriptive statistics 
summary(df_burst)
library(ggplot2)
# histogram
ggplot(df_burst, aes(energy_consumption)) + geom_histogram(bins = 30)+
  labs(x = "energy consumption")

# treatment: even-----------------------------------------------------------------------------------
files = list.files(path="./even/", pattern="*.csv")
energyCon = list()

for (i in 1:length(files)) {
  print(i)
  myfile = read.csv(paste("./even/", files[i], sep=""))
  energyCon[i] = (sum(myfile[2],na.rm = TRUE)/lengths(myfile[1]))/1000000*5*60   
}
df_even <- data.frame(energy_consumption = unlist(energyCon))

# descriptive statistics 
summary(df_burst)
library(ggplot2)
# histogram
ggplot(df_even, aes(energy_consumption)) + geom_histogram(bins = 30)+
  labs(x = "energy consumption")

# dealing with the whole set-----------------------------------------------------------------------
df_burst <- data.frame(energy_consumption = df_burst[c(1 : 40),])
df_burst <- cbind(df_burst, data.frame(treatment = 'burst'))
df_even <- cbind(df_even, data.frame(treatment = 'even'))
df <- rbind(df_even, df_burst)
# box-plot

ticks <- c("Burst", "Even")

ggplot(data = df, aes(x = treatment, y = energy_consumption, fill = treatment)) + geom_boxplot() + theme_pubr() + theme(legend.position = "none") + labs(x="Distribution of arrival", y="Energy consumption (J)") + scale_x_discrete(labels= ticks)

ggsave("./boxplot_rq2.pdf", scale = 1.5, height = 7, width = 10, unit = "cm", device=cairo_pdf)
embed_fonts("./boxplot_rq2.pdf", outfile="./boxplot_rq2.pdf")

# assumption checking-------------------------------------------------------------------------------
# if normal distribution
qqnorm(df_burst$energy_consumption)
shapiro.test(df_burst$energy_consumption)
qqnorm(df_even$energy_consumption)
shapiro.test(df_even$energy_consumption)

# homogeneity of variances
library(stats) 
fligner.test(energy_consumption ~ treatment, df) 

# hypothesis test ----------------------------------------------------------------------------------
#wilcox.test(df_even$energy_consumption, df_burst$energy_consumption, paired=TRUE, conf.int=TRUE)
wilcox.test(df_even$energy_consumption, df_burst$energy_consumption, paired=FALSE, conf.int=TRUE)
# effect size
library(effsize)
cliff.delta(df_even$energy_consumption, df_burst$energy_consumption)
# density
plot(density(df_burst$energy_consumption), main = "",)
lines(density(df_even$energy_consumption), col = "red")

df_burst <- df_burst %>% mutate_at("treatment", str_to_title)
df_even <- df_even %>% mutate_at("treatment", str_to_title)

density_data <- rbind(df_burst, df_even)

ggplot(data = density_data, aes(x = energy_consumption, fill=treatment)) + geom_density(alpha=0.4) + theme_pubr() + labs(x="Energy consumption (J)", y="Density") + theme(legend.title=element_blank(), legend.position = c(0.9, 0.9), legend.box = "vertical")

ggsave("./density.pdf", scale = 1.5, height = 7, width = 10, unit = "cm", device=cairo_pdf)
embed_fonts("./density.pdf", outfile="./density.pdf")

# legend("topright",                                  
#        legend = c("Burst", "Even"),
#        col = c("black", "red"),
#        lty = 1)
