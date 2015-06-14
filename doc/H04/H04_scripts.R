
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#====================================================================#
# Hypothesis 04:
# Is there a certain age range of drivers that are more likely 
# to be involved in a single vehicular accident?
#====================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)


# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "P_USER", "P_AGE", "C_CONF")] )

## summary(sub)

# Select only records of Drivers
sub[ !sub$P_USER==1, "P_USER" ] <- NA
sub$P_USER  <- factor(sub$P_USER , levels=c(1), labels=c("Driver"))


# Remove those with invalid age
sub[ sub$P_AGE %in% c("00","01","02","03","04","05","06"
                      ,"07","08","09","10","11","12"
                      ,"NN","UU","XX"), "P_AGE" ] <- NA

sub$P_AGE <- factor(sub$P_AGE)

# summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","User","Age","Collision_Type")

summary(D)

plot(D$Age)

names(tab)

tab<-table( D$Year, D$Age , dnn = c("Year","Age")) 


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

g <- ggplot(data=df, aes(x=Age, y=Freq )) +
        geom_line( aes(group=Year , color=Year) , size=1 ) +
        labs(x="AGE", y="Number of Collisions", title="Single Vehicular Accident Trends of Driver's Age Per Year") +
        theme(legend.position="bottom", 
              plot.title = element_text(size=20, face="bold", vjust=2) , 
              legend.title = element_text(size=15), 
              legend.text =  element_text(size=15), 
              axis.text.x= element_text(angle=90, size=10,  vjust=0.5), 
              axis.text.y= element_text(angle=50, size=15 ) 
        )  


png(filename="H04_GraphA.png" , width=1000, height=500)
plot(g)
dev.off()

        
