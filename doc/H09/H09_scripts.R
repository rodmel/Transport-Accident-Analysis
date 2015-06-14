
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#================================================================================#
# Hypothesis 09:
# Which types of accidents are more frequent in various road alignments?
#================================================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)

# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "C_MNTH", "P_ISEV")] )

## summary(sub)


# Exclude all those unknown or NA Road Surfaces
sub[ !sub$C_MNTH %in% c("01","02","03","04","05","06" 
                       ,"07","08","09","10","11","12") , "C_MNTH" ] <- NA

sub$C_MNTH  <- factor(sub$C_MNTH
                      , levels=c("01","02","03","04","05","06" 
                                 ,"07","08","09","10","11","12")
                      , labels=c( "JAN","FEB","MAR","APR"
                                  ,"MAY","JUN","JUL","AUG"
                                  ,"SEP","OCT","NOV","DEC")
                      , ordered = TRUE
                )


# Exclude all those unknown or NA INJURY SEVERITY
sub[ !sub$P_ISEV %in% c("1","2","3") , "P_ISEV" ] <- NA

sub$P_ISEV <- factor( sub$P_ISEV, levels=c("1","2","3")
                         ,labels=c("No Injury","Injury","Fatality") )


summary(sub)



# summary(sub)

D <- sub[complete.cases(sub),]

colnames(D) <- c("Year","Month","Severity")

summary(D)


tab<-table( D$Month, D$Year, D$Severity, dnn = c("Month","Year","Severity")) 
tab

tab2<-table( D$Month, D$Year, dnn = c("Month","Year")) 
tab2

head(D)

DFatality <- D[D$Severity=="Fatality",]
tabFatality <- table(DFatality$Month, DFatality$Year, dnn=c("Month","Year"))

# head(tabFatality)

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


str(df)

##-----------------------------------------
##  Generate Table for Total Collisions
##-----------------------------------------

## Monthly Trend of Total Collisions
addmargins( t(tab2))

##-----------------------------------------
##  Generate Graph for Total Collisions
##-----------------------------------------
dftab2 <- as.data.frame(tab2)
# head( dftab2)
g1 <- ggplot(data=dftab2, aes(x=Month, y=Freq )) +
        geom_line( aes(group=Year , color=Year) ,size=1) +
        labs(x="Month", y="Number of Collisions", title="Monthly Trends of Collisions") +
        theme( 
                plot.title = element_text(size=20, face="bold", vjust=2) , 
                legend.title = element_text(size=20), 
                axis.text.x= element_text(angle=50, size=10,  vjust=0.5), 
                axis.text.y= element_text(angle=50, size=15 )
        ) 


png(filename="H09_GraphA.png" , width=1000, height=500)
plot(g1)
dev.off()



dfTabFatality <- as.data.frame(tabFatality)
# head( dfTabFatality)

##-----------------------------------------
##      Generate Table for Fatality
##-----------------------------------------
## Monthly Trend of Fatalities
addmargins( t(tabFatality))

##-----------------------------------------
##  Generate Graph for Total Collisions
##-----------------------------------------
g2 <- ggplot(data=dfTabFatality, aes(x=Month, y=Freq )) +
        geom_line( aes(group=Year , color=Year) ,size=1) +
        labs(x="Month", y="Number of Fatality", title="Monthly Trends of Fatality") +
        theme( 
                plot.title = element_text(size=20, face="bold", vjust=2) , 
                legend.title = element_text(size=20), 
                axis.text.x= element_text(angle=50, size=10,  vjust=0.5), 
                axis.text.y= element_text(angle=50, size=15 )
        ) 


png(filename="H09_GraphB.png" , width=1000, height=500)
plot(g2)
dev.off()


# g
# png(filename="H07_GraphA.png" , width=1000, height=500)
# plot(g)
# dev.off()


