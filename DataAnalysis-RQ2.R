# generate energy consumption result for every trade burst/burst 
# treatment: high_even vs high_burst
# treatment: burst------------------------------------------------------------------------------------
setwd("E:/vu-master/Y2P1/ass3/results_rq2/burst")
files = list.files(pattern="*.csv")
energyCon = list()

for (i in 1:length(files)) {
  print(i)
  myfile = read.csv(files[i])
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
setwd("E:/vu-master/Y2P1/ass3/results_rq2/even")
files = list.files(pattern="*.csv")
energyCon = list()

for (i in 1:length(files)) {
  print(i)
  myfile = read.csv(files[i])
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
ggplot(data = df, aes(x = treatment, y = energy_consumption, color = treatment)) + geom_boxplot()

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
legend("topright",                                  
       legend = c("burst", "even"),
       col = c("black", "red"),
       lty = 1)
