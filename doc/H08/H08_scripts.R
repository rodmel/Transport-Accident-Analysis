## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#================================================================================#
# Hypothesis 08:
# What roadway configurations (e.g. intersection, ramp etc.) combined with weather 
# (e.g. sunny, raining, snowing etc.) have high frequency of collision?
#================================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "C_WTHR", "C_RCFG","P_ISEV")] )

## summary(sub)

## # Exclude all those unknown or NA  Weather
sub[sub$C_WTHR %in% c("U","X"), "C_WTHR" ] <- NA
sub$C_WTHR <- factor(sub$C_WTHR
             ,levels=c("1","2","3","4","5","6","7","Q")
             , labels=c(
                "Clear and Sunny"
                ,"Overcast or Cloudy"
                ,"Raining"
                ,"Snowing"
                ,"Freezing Rain"
                ,"Visibility Limitation"
                ,"Strong Wind"
                ,"Others")
                )

## # Exclude all those unknown or NA Roadway Configuration
sub[sub$C_RCFG %in% c("UU","XX"), "C_RCFG" ] <- NA
sub$C_RCFG <- factor(sub$C_RCFG 
        ,levels=c("01","02","03","04","05","06","07"
                  ,"08","09","10","11","12","Q")
        ,labels=c(
         "Non-Intersection"
        ,"Intersection"
        ,"Parking Lot or Driveway"
        ,"Railroad Level"
        ,"Bridge or Overpass"
        ,"Tunnel or Underpass"
        ,"Passing Lane"
        ,"Ramp"
        ,"Traffic Circle"
        ,"Express Lane Freeway"
        ,"Collector Lane Freeway"
        ,"Transfer Lane Freeway"
        ,"Others"
))


## Exclude all those unknown or NA Severity
sub[sub$P_ISEV %in% c("U","X","N"), "P_ISEV" ] <- NA
## sub$V_TYPE <- factor(sub$V_TYPE) 
sub$P_ISEV <- factor(sub$P_ISEV , labels=c(
        "No_Injury"
        ,"Injury"
        ,"Fatality"
))

#----------------------------------------

summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","Weather","Roadway","Severity")

summary(D)


##-----------------------------------------
##      Generate Table
##-----------------------------------------

tbl <- table(D$Roadway, D$Weather , dnn=c("Roadway","Weather"))

# Roadway Configuration and Weather
addmargins(tbl)

(nrow(NCDB)-nrow(D))/nrow(NCDB) ## 17% removed due to NA;s (4.05 M remained out of 4.9 M )

##-----------------------------------------
##      Generate Graph
##-----------------------------------------
library(ggplot2)

dftbl <-  as.data.frame(tbl)

head(dftbl)

g  <-   ggplot(data=dftbl, aes(x=factor(Roadway), y=Freq, fill=Weather) )  + 
        geom_bar(stat="identity" , alpha=2/3) +
        labs(x="Roadway Configuration", y="Number of Collisions"
             , title="Vehicle Collisions Based on Weather and Roadway Configuration\n1999 to 2011") +
        theme( plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=15), 
               axis.text.x= element_text(angle=0, size=15,  vjust=0.5), 
               axis.text.y= element_text(angle=0, size=15),
               axis.title.x = element_text(size=20),
               axis.title.y = element_text(size=20),
               legend.position="right")  +
        coord_flip()

png(filename="H08_GraphA.png" , width=1000, height=500)
plot(g)
dev.off()

#--oOo----oOo----oOo----oOo----oOo----oOo----oOo----oOo----oOo----oOo--#


summary(D)

DINJFAT= D[ !D$Severity=="No_Injury", ]
DFAT= D[ D$Severity=="Fatality", ]

tblINJFAT <- table(DINJFAT$Roadway, DINJFAT$Weather , dnn=c("Roadway","Weather"))
tblDFAT <- table(DFAT$Roadway, DFAT$Weather , dnn=c("Roadway","Weather"))

dfINJFAT <- as.data.frame(tblINJFAT)
dfFAT <- as.data.frame(tblDFAT)

H8GIF<- ggplot(data=dfINJFAT, aes(x=factor(Roadway), y=Freq, fill=Weather) )  + 
        geom_bar(stat="identity" , alpha=2/3) +
        labs(x="Roadway Configuration", y="Number of Collisions"
             , title="Collisions Based on Weather and Roadway Configuration\n(Collisions with INJURY/FATALITY - 1999 to 2011") +
        theme( plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=15), 
               axis.text.x= element_text(angle=0, size=15,  vjust=0.5), 
               axis.text.y= element_text(angle=0, size=15),
               axis.title.x = element_text(size=20),
               axis.title.y = element_text(size=20),
               legend.position="right")  +
        coord_flip()

png(filename="H08_H8GIF.png" , width=1000, height=500)
plot(H8GIF)
dev.off()

H8GFAT<- ggplot(data=dfFAT, aes(x=factor(Roadway), y=Freq, fill=Weather) )  + 
        geom_bar(stat="identity" , alpha=2/3) +
        labs(x="Roadway Configuration", y="Number of Collisions"
             , title="Collisions Based on Weather and Roadway Configuration\nFATAL COLLISIONS 1999 to 2011") +
        theme( plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=15), 
               axis.text.x= element_text(angle=0, size=15,  vjust=0.5), 
               axis.text.y= element_text(angle=0, size=15),
               axis.title.x = element_text(size=20),
               axis.title.y = element_text(size=20),
               legend.position="right")  +
        coord_flip()

png(filename="H08_H8GFAT.png" , width=1000, height=500)
plot(H8GFAT)
dev.off()



tab<-table( D$Collision_Category, D$Year, D$Road_Alignment, dnn = c("Collision_Category","Year","Road_Alignment")) 

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

,size=2
, cex=1

ggplot(data=df, aes(x=Year, y=Freq )) +
        geom_line( aes(group=Collision_Category , color=Collision_Category) , size=2 , alpha=0.7) +
        labs(x="Year", y="Number of Collisions", title="Collision Trends Per Road Alignment") +
        facet_grid(~Road_Alignment) + 
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

g<- ggplot(data=df, aes(x=Year, y=Freq )) +
        geom_line( aes(group=Collision_Category , color=Collision_Category) , size=2 , alpha=0.7) +
        labs(x="Year", y="Number of Collisions", title="Collision Trends Per Road Alignment") +
        facet_grid(~Road_Alignment) + 
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
png(filename="H08_GraphA.png" , width=1000, height=500)
plot(g)
dev.off()


