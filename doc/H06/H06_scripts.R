
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#================================================================================#
# Hypothesis 06:
# Which types of accidents are more frequent in various road surface conditions?
#================================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)

# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "C_RSUR", "C_CONF")] )

## summary(sub)


# Exclude all those unknown or NA Road Surfaces
sub[ sub$C_RSUR %in% c("Q","U","X") , "C_RSUR" ] <- NA

# sub$C_RSUR  <- factor(sub$C_RSUR
#                       , levels=c("1","2","3","4","5","6","7","8","9")
#                       , labels=c( "Dry/normal"
#                                   ,"Wet"
#                                   ,"Snow"
#                                   ,"Slushy"
#                                   ,"Icy"
#                                   ,"Sand/gravel"
#                                   ,"Muddy"
#                                   ,"Oil"
#                                   ,"Flooded"
#                       )
#                 )

## will just limit to 5 types (will remove other types)
sub[ sub$C_RSUR %in% c("6","7","8","9") , "C_RSUR" ] <- NA

sub$C_RSUR  <- factor(sub$C_RSUR
                      , levels=c("1","2","3","4","5")
                      , labels=c( "Dry/normal"
                                 ,"Wet"
                                 ,"Snow"
                                 ,"Slushy/Wet Snow"
                                 ,"Icy"
                                )
                      )


sub[sub$C_CONF %in% c("UU","XX"), "C_CONF" ] <- NA


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



summary(sub)



# summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","Road_Surface","Collision_Type","Collision_Category")

summary(D)


tab<-table( D$Collision_Category, D$Year, D$Road_Surface, dnn = c("Collision_Category","Year","Road_Surface")) 

tab


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
# head(df)

g <- ggplot(data=df, aes(x=Year, y=Freq )) +
        geom_line( aes(group=Collision_Category , color=Collision_Category) ,size=2 , alpha=0.7) +
        labs(x="Year", y="Number of Collisions", title="Collision Trends Per Road Surface") +
        facet_grid(~Road_Surface) + 
        theme(legend.position="bottom", 
              plot.title = element_text(size=30, face="bold", vjust=2) , 
              legend.title = element_text(size=12), 
              legend.text = element_text(size=12), 
              axis.text.x = element_text(angle=90, size=10,  vjust=0.5), 
              axis.title.x= element_text(size=20 ) ,
              axis.text.y= element_text(angle=50, size=15 ) ,
              axis.title.y= element_text(size=20 ) ,
              strip.text = element_text(size=12)
        )  

g

png(filename="H06_GraphA.png" , width=1000, height=500)
plot(g)
dev.off()


