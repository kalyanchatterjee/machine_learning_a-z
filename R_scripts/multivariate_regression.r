ami_data <- read.table("http://static.lib.virginia.edu/statlab/materials/data/ami_data.DAT")
names(ami_data) <- c("TOT","AMI","GEN","AMT","PR","DIAP","QRS")

summary(ami_data)
pairs(ami_data)
regressor <- lm(formula = cbind(TOT, AMI) ~ GEN + AMT + PR + DIAP + QRS, data = ami_data)