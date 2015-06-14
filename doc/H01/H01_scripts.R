

## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#========================================================#
# Hypothesis 01:
# Which types of vehicular collisions have high trend of 
# fatalities and injuries from 1999 to 2011?
#========================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
NCDB[ c(1:10,4900581:4900590), ]
summary(NCDB)


# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "C_CONF", "P_ISEV")] )

# Ignore (Nullify) if the severity is not (Injury or Fatality)
sub[ !sub$P_ISEV %in% c("2","3"), "P_ISEV" ] <- NA
sub$P_ISEV  <- factor(sub$P_ISEV , levels=c(2,3), labels=c("Injury","Fatality"))

sub[sub$C_CONF %in% c("UU","XX"), "C_CONF" ] <- NA
sub$C_CONF <- factor(sub$C_CONF , 
                     levels=c("01","02","03","04","05"
                              ,"06","21","22","23","24"
                              ,"25","31","32","33","34"
                              ,"35","36","41","QQ"),
                     labels=c(
                             "01- Hit a moving object"
                             ,"02- Hit a stationary object"
                             ,"03- Ran off left shoulder"
                             ,"04- Ran off right shoulder"
                             ,"05- Rollover on roadway"
                             ,"06- Any other single vehicle"
                             ,"21- Rear-end collision"
                             ,"22- Side swipe"
                             ,"23- Left turn conflict"
                             ,"24- Right turn conflict"
                             ,"25- Other 2-vechile same direction"
                             ,"31- Head-on collision"
                             ,"32- Approaching side-swipe"
                             ,"33- Left turn opposing traffic"
                             ,"34- Right turn conflicts"
                             ,"35- Right angle collision"
                             ,"36- Other 2-vehicle different direction"
                             ,"41- Hit a parked motor vehicle"
                             ,"QQ- Others"
                     ))

# summary(sub)
D <- sub[complete.cases(sub),]
summary(D)
tab<-table(D$C_CONF, D$C_YEAR , dnn = c("Collision_Type","Year")) 
tab

##-----------------------------------------
##      Generate Table
##-----------------------------------------
addmargins(tab)


##-----------------------------------------
##      Generate Graph
##-----------------------------------------

library(ggplot2)
library(grid)

df <- as.data.frame(tab)

note1 = grobTree(textGrob("(21) Rear-end collision", 
           x=0.45,  y=0.85, hjust=0,
   gp=gpar(col="darkgreen", fontsize=12, fontface="italic")))

note2 = grobTree(textGrob("(35) Right angle collision", 
                            x=0.18,  y=0.61, hjust=0,
                            gp=gpar(col="darkmagenta", fontsize=12, fontface="italic")))

note3 = grobTree(textGrob("(06)- Any other single vehicle", 
                             x=0.35,  y=0.43, hjust=0,
                             gp=gpar(col="darkolivegreen", fontsize=12, fontface="italic")))

note4 = grobTree(textGrob("36- Other 2-vehicle different direction", 
                          x=0.25,  y=0.30, hjust=0,
                          gp=gpar(col="darkmagenta", fontsize=12, fontface="italic")))


ggplot(data=df, aes(x=Year, y=Freq )) +
       geom_line( aes(group=Collision_Type , color=Collision_Type) ,size=1) +
       labs(x="Year", y="Total Fatality and Injury", title="Total Fatality and Injury Per Collision Per Year") +
       theme( 
        plot.title = element_text(size=20, face="bold", vjust=2) , 
        legend.title = element_text(size=20), 
        axis.text.x= element_text(angle=50, size=10,  vjust=0.5), 
        axis.text.y= element_text(angle=50, size=15 )
        )  +
        annotation_custom(note1) +
        annotation_custom(note2) +
        annotation_custom(note3) +
        annotation_custom(note4) 

        
##-----------------------------------------
## Hypothesis Test
##-----------------------------------------

## Top 3 of the most recent year
dfTop3 <-df[ order(-as.integer(df$Year),-df$Freq) ,][1:3,]

## Data Points of Top 3 of the most recent year
result <- as.data.frame(df[ df$Collision_Type == dfTop3[1,1] , "Year" ])
colnames(result) <- "Year"
result$Rear_End_Collision = df[ df$Collision_Type == dfTop3[1,1] , "Freq"]
result$Right_Angle_Collision = df[ df$Collision_Type == dfTop3[2,1] , "Freq"]
result$Other_Single_Vehicle = df[ df$Collision_Type == dfTop3[3,1] , "Freq"]

result

wctest1 <- wilcox.test(result$Rear_End_Collision, result$Right_Angle_Collision, paired=TRUE, alternative="greater")
wctest2 wilcox.test(result$Rear_End_Collision, result$Other_Single_Vehicle, paired=TRUE, alternative="greater")

wctest1
wctest2


