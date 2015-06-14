
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#====================================================================#
# Hypothesis 05:
# In terms of single vehicular accidents, are young male drivers 
# more dangerous compared to female drivers?
#====================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)

# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "P_USER", "P_AGE", "P_SEX", "C_CONF")] )

## summary(sub)

# Select only records of Drivers
sub[ !sub$P_USER==1, "P_USER" ] <- NA
sub$P_USER  <- factor(sub$P_USER , levels=c(1), labels=c("Driver"))

# Select only those Male and Female
sub[ !sub$P_SEX %in% c("F","M"), "P_SEX" ] <- NA
sub$P_SEX  <- factor(sub$P_SEX , levels=c("F","M"), labels=c("Female","Male"))

# Exclude those age beyond 16 and 21
sub[ !sub$P_AGE %in% c("16","17","18","19","20","21"), "P_AGE" ] <- NA
sub$P_AGE <- factor(sub$P_AGE)

# summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","User","Age","Gender","Collision_Type")

summary(D)

tab<-table( D$Gender, D$Year , dnn = c("Gender","Year")) 

tab

##-----------------------------------------
##      Generate Table
##-----------------------------------------
t(tab)

##-----------------------------------------
##      Generate Graph
##-----------------------------------------
library(ggplot2)

df <- as.data.frame(tab)

# head(df)

g<- ggplot(data=df, aes(x=Year, y=Freq )) +
        geom_line( aes(group=Gender , color=Gender) , size=2 ) +
        labs(x="Year", y="Number of Collisions", title="Single Vehicular Accident Trends of Young Drivers (Age 16-21) Per Gender") +
        theme(legend.position="bottom", 
              plot.title = element_text(size=20, face="bold", vjust=2) , 
              legend.title = element_text(size=20), 
              legend.text = element_text(size=20), 
              axis.text.x= element_text(angle=45, size=20,  vjust=0.5), 
              axis.text.y= element_text(angle=50, size=20 ) 
        )  

png(filename="H05_GraphA.png" , width=1000, height=500)
plot(g)
dev.off()

        
