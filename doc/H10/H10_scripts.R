
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#================================================================================#
# Hypothesis 10:
# Which particular day and time of the week have high collision rate?
#================================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)

# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "C_WDAY", "C_HOUR", "P_ISEV")] )

# head(sub)

## summary(sub)


# Exclude all those unknown or NA Weekdays
sub[ !sub$C_WDAY %in% c("1","2","3","4","5","6","7") , "C_WDAY" ] <- NA

sub$C_WDAY  <- factor(sub$C_WDAY
                      , levels=c("1","2","3","4","5","6","7")
                      , labels=c( "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
                      , ordered = TRUE
                )


# Exclude all those unknown or NA Hour
sub[ sub$C_HOUR %in% c("UU","XX") , "C_HOUR" ] <- NA

sub$C_HOUR  <- factor(sub$C_HOUR
                      , levels=c("00","01","02","03","04","05"
                                ,"06","07","08","09","10","11"
                                ,"12","13","14","15","16","17"
                                ,"18","19","20","21","22","23")
                      , labels=c("12am","1am","2am","3am","4am","5am"
                                 ,"6am","7am","8am","9am","10am","11am"
                                 ,"12pm","1pm","2pm","3pm","4pm","5pm"
                                 ,"6pm","7pm","8pm","9pm","10pm","11pm")
                      , ordered = TRUE
)




# Exclude all those unknown or NA INJURY SEVERITY
sub[ !sub$P_ISEV %in% c("1","2","3") , "P_ISEV" ] <- NA

sub$P_ISEV <- factor( sub$P_ISEV, levels=c("1","2","3")
                      ,labels=c("No Injury","Injury","Fatality") )

summary(sub)

sub <- sub[complete.cases(sub),]

summary(sub)

# ### Create Week-Hour factor vector
# f2 <- levels(sub$C_HOUR)
# f3 <-       paste("M", f2)
# f3 <- c(f3, paste("T", f2) )
# f3 <- c(f3, paste("W", f2) )
# f3 <- c(f3, paste("Th", f2) )
# f3 <- c(f3, paste("F", f2) )
# f3 <- c(f3, paste("Sa", f2) )
# f3 <- c(f3, paste("Su", f2) )
# wkhrfactor <- factor(f3, levels=f3, labels=f3, ordered=TRUE)

# # Add new attribute Week Hour with ordered factor
# sub$WkHr <- factor(paste(as.character(sub$C_WDAY), as.character(sub$C_HOUR))
#                       ,levels = wkhrfactor
#                       ,labels = wkhrfactor
#                       )

# colnames(sub) <- c("Year","Day","Hour","Severity","WeekHour")

colnames(sub) <- c("Year","Day","Hour","Severity")

# head(sub)



##-----------------------------------------
##      Generate Table
##-----------------------------------------
# tab <- table(sub$WeekHour, sub$Severity)
# addmargins(tab)

head(sub)
tab <- table(sub$Day, sub$Hour ,sub$Severity)

addmargins(tab)

tab



##-----------------------------------------
##      Generate Graph
##-----------------------------------------

library(ggplot2)

df <- as.data.frame(tab)

colnames(df) <- c("Day","Hour","Severity","Freq")

head(df)

g <- ggplot(data=df, aes(x=Hour, y=Freq )) +
        geom_line( aes(group=Severity , color=Severity) ,size=1) +
        labs(x="Hour", y="Frequency", title="Frequency of Accidents Every Hour Within The Week") +
        facet_grid(~Day) +
        theme( legend.position = "bottom",
               plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=15), 
               legend.text = element_text(size=15), 
               axis.text.x= element_text(angle=90, size=8,  vjust=0.5), 
               axis.title.x = element_text(size=20), 
               axis.text.y= element_text(angle=60, size=10 ),
               axis.title.y = element_text(size=20), 
               strip.text = element_text(size=15))  


 g
 png(filename="H10_GraphA.png" , width=1000, height=500)
 plot(g)
 dev.off()

##-----------------------------------------
##      Generate Graph for Fatality
##-----------------------------------------


subfatal <- sub[ sub$Severity=="Fatality", ]
subfatal$Severity <- factor(subfatal$Severity)

# head(subfatal)

tabfatal <- table(subfatal$Day, subfatal$Hour , subfatal$Severity )
# addmargins(tabfatal)

dffatal <- as.data.frame(tabfatal)
colnames(dffatal) <- c("Day","Hour","Severity","Freq")

head(dffatal)

g2 <-  ggplot(data=dffatal, aes(x=Hour, y=Freq )) +
        geom_line( aes(group=Severity , color=Severity) ,size=1) +
        labs(x="Hour", y="Frequency", title="Frequency of FATAL Accidents Every Hour Within The Week") +
        facet_grid(~Day) +
        theme( legend.position = "bottom",
               plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=15), 
               legend.text = element_text(size=15), 
               axis.text.x= element_text(angle=90, size=8,  vjust=0.5), 
               axis.title.x = element_text(size=20), 
               axis.text.y= element_text(angle=60, size=10 ),
               axis.title.y = element_text(size=20), 
               strip.text = element_text(size=15))  


g2
png(filename="H10_GraphB.png" , width=1000, height=500)
plot(g2)
dev.off()
