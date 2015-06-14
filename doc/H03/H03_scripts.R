
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#====================================================================#
# Hypothesis 03:
# Do drivers with different genders have different accident pattern?
#====================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)


# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "P_USER", "P_SEX", "C_CONF")] )

## summary(sub)

# Select only records of Drivers
sub[ !sub$P_USER==1, "P_USER" ] <- NA
sub$P_USER  <- factor(sub$P_USER , levels=c(1), labels=c("Driver"))

# Select only those Female or Male (remove the unknown or NAs)
sub[ !sub$P_SEX %in% c("F","M"), "P_SEX" ] <- NA
sub$P_SEX  <- factor(sub$P_SEX , levels=c("F","M"), labels=c("Female","Male"))

sub[sub$C_CONF %in% c("UU","XX","QQ"), "C_CONF" ] <- NA

# Create another attribute as Major Category of Collission Type
# Single Vehicle, Two Vehicles Same Direction, Two Vehicles Different Direction and Hitting Parked Vehicle

sub$Collision  <- sapply(as.character(sub$C_CONF), switch, 
                           "01"="A"
                          ,"02"="A"
                          ,"03"="A"
                          ,"04"="A"
                          ,"05"="A"
                          ,"06"="A"
                          ,"21"="B"
                          ,"22"="B"
                          ,"23"="B"
                          ,"24"="B"
                          ,"25"="B"
                          ,"31"="C"
                          ,"32"="C"
                          ,"33"="C"
                          ,"34"="C"
                          ,"35"="C"
                          ,"36"="C"
                          ,"41"="D"
                        )

sub$Collision <- factor( sub$Collision, levels=c("A","B","C","D")
                          ,labels=c("Single Vehicle"
                                   ,"Two Vehicles Same Direction"
                                   ,"Two Vehicles Different Direction"
                                   ,"Hit a Parked Vehicle"))

# head(sub)
# summary(sub)
# str(sub)

# sub$C_CONF <- factor(sub$C_CONF , 
#                      levels=c("01","02","03","04","05"
#                               ,"06","21","22","23","24"
#                               ,"25","31","32","33","34"
#                               ,"35","36","41","QQ"),
#                      labels=c(
#                               "01- Hit a moving object"
#                              ,"02- Hit a stationary object"
#                              ,"03- Ran off left shoulder"
#                              ,"04- Ran off right shoulder"
#                              ,"05- Rollover on roadway"
#                              ,"06- Any other single vehicle"
#                              ,"21- Rear-end collision"
#                              ,"22- Side swipe"
#                              ,"23- Left turn conflict"
#                              ,"24- Right turn conflict"
#                              ,"25- Other 2-vechile same direction"
#                              ,"31- Head-on collision"
#                              ,"32- Approaching side-swipe"
#                              ,"33- Left turn opposing traffic"
#                              ,"34- Right turn conflicts"
#                              ,"35- Right angle collision"
#                              ,"36- Other 2-vehicle different direction"
#                              ,"41- Hit a parked motor vehicle"
#                              ,"QQ- Others"
#                      ))
# 

# summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","User","Gender","Collision_Code","Collision_Category")

# summary(sub)
# summary(D)

tab<-table( D$Gender, D$Year, D$Collision_Category , dnn = c("Gender","Year","Collision_Category")) 

# tab


##-----------------------------------------
##      Generate Table
##-----------------------------------------
# tab[,,1]
# tab[,,2]
# tab[,,3]
# tab[,,4]


##-----------------------------------------
##      Generate Graph
##-----------------------------------------
library(ggplot2)

df <- as.data.frame(tab)

ggplot(data=df, aes(x=Year, y=Freq )) +
       geom_line( aes(group=Gender , color=Gender) ,size=2) +
       labs(x="Year", y="Number of Collisions", title="Accident Trends Per Driver's Gender Per Collision Category") +
        facet_grid(~Collision_Category) + 
        theme(legend.position="bottom", 
        plot.title = element_text(size=20, face="bold", vjust=2) , 
        legend.title = element_text(size=15), 
        axis.text.x= element_text(angle=90, size=8,  vjust=0.5), 
        axis.text.y= element_text(angle=50, size=10 ) ,
        strip.text = element_text(size=15)
        )  



        
