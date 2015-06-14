
## National Collision Database Data Analysis
## version 1.0
## By Rodrigo Melgar - June 2015
#========================================================#
# Hypothesis 02:
# Which passenger seat position in the Light Duty Vehicles 
# is the safest/most dangerous?
#========================================================#


##-----------------------------------------
#         Read and Extract Data
##-----------------------------------------

NCDB <- read.csv(file='NCDB_1999_to_2011.csv')

## show the first and last 10 records
# NCDB[ c(1:10,4900581:4900590), ]
# summary(NCDB)


# Subset the required columns filtering out the NA
sub <- with(NCDB,  NCDB[ ,c("C_YEAR", "V_TYPE", "P_PSN", "P_ISEV", "P_USER")] )

summary(sub)


# Select only the Light Duty Vehicles (car, van, Light utility vehicles or truchs)
# NULLify the the rest of vehicle types that are not Light Duty Vehicles
sub[ !sub$V_TYPE=="01", "V_TYPE" ] <- NA
sub$V_TYPE  <- factor(sub$V_TYPE , levels=c("01"), labels=c("Light Duty Vehicle"))

# Select only those 1st to 3rd rows (except for Driver's position)
sub[ !sub$P_PSN %in% c("12","13","21","22","23","31","32","33"), "P_PSN" ] <- NA

sub$P_PSN <- factor(sub$P_PSN , 
                    levels=c(      "12","13"
                                   ,"21","22","23"
                                   ,"31","32","33"
                    ),
                    labels=c(
                             "Front Center"
                            ,"Front Right"
                            ,"2nd Row Left"
                            ,"2nd Row Center"
                            ,"2nd Row Right"
                            ,"3rd Row Left"
                            ,"3rd Row Center"
                            ,"3rd Row Right")
                    ,ordered = TRUE
                    )


# sub$P_PSN <- factor(sub$P_PSN , 
#                      levels=c(      "12","13"
#                               ,"21","22","23"
#                               ,"31","32","33"
#                               ),
#                      labels=c(
#                                "12- Front row, center"
#                               ,"13- Front, row, right"
#                               ,"21- Second row, left"
#                               ,"22- Second row, center"
#                               ,"23- Second row, right"
#                               ,"31- Third row, left"
#                               ,"32- Third row, center"
#                               ,"33- Third row, right"
#                      ))

# Nullify those unknown/not applicable severity
sub[ !sub$P_ISEV %in% c("1","2","3"), "P_ISEV" ] <- NA
sub$P_ISEV  <- factor(sub$P_ISEV , levels=c(1,2,3), labels=c("No Injury","Injury","Fatality"))

# NULLify to filter only records of Passengers
sub[ !sub$P_USER==2, "P_USER" ] <- NA
sub$P_USER  <- factor(sub$P_USER , levels=c(2), labels=c("Passenger"))


# summary(sub)
D <- sub[complete.cases(sub),]
summary(sub)
summary(D)


tab<-table( D$P_PSN, D$P_ISEV , dnn = c("Position","Severity")) 
tab

DF <- as.data.frame(tab)


dftab <-as.data.frame(tab)
dftab <- reshape(dftab, idvar="Position" , timevar="Severity", direction="wide")
colnames(dftab)=c("Position","No_Injury","Injury","Fatality")

dftab$Total <- with( dftab,  No_Injury+Injury+Fatality)
dftab$Injury_Probability <- with(dftab, Injury/Total)
dftab$Fatality_Probability <- with(dftab, Fatality/Total)
dftab$Injury_Fatality <- with(dftab, (Injury+Fatality)/Total)


##-----------------------------------------
##      Generate Table
##-----------------------------------------
# Probability of Injury and Fatality
dftab

##-----------------------------------------
##      Generate Graph
##-----------------------------------------

## convert "dftab" to long format into "bd"
## as bargraph data for Fatality and Injury Proability
bd1 <- cbind(dftab[ ,c(1,7)],Severity="Fatality")
colnames(bd1) <- c("Position", "Probability","Severity")
bd2 <- cbind(dftab[ ,c(1,6)],Severity="Injury")
colnames(bd2) <- c("Position", "Probability","Severity")
bd <- rbind(bd1,bd2)
## bd

library(ggplot2)

g1 <- ggplot(data=bd, aes(x=factor(Position), y=Probability, fill=Severity) )  + 
        geom_bar(stat="identity" , alpha=2/3) +
        labs(x="Passenger Position In Light Duty Vehicles", y="Probability of Injury"
             , title="Injury Probability of Passenger Positions of Light Duty Vehicles") +
        theme( plot.title = element_text(size=20, face="bold", vjust=2) , 
               legend.title = element_text(size=10), 
               axis.text.x= element_text(angle=70, size=15,  vjust=0.5), 
               axis.text.y= element_text(angle=0, size=15)
               ,legend.position="right")  

png(filename="H02_GraphA.png" , width=1000, height=500)
plot(g1)
dev.off()

-----

        