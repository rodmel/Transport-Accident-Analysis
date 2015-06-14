

###National Collision Database Data Dictionary
#####Possible values and their meaning for each attribute

No.| ATTRIBUTE  | SIZE  | DESCRIPTION                                  |
---|------------|-------|----------------------------------------------|
1  | C_YEAR     |  4	| Year in which the collision occurred 	       |
2  | C_MNTH     |  2	| Month in which the collision occurred        |
3  | C_WDAY     |  1	| Day of the week the collision occurred       |
4  | C_HOUR     |  2	| Collision hour                               |
5  | C_SEV      |  1	| Collision severity                           |
6  | C_VEHS     |  2	| Number of vehicles involved in collision     |
7  | C_CONF     |  2	| Collision configuration                      |
8  | C_RCFG     |  2	| Roadway configuration	                       |
9  | C_WTHR     |  1	| Weather condition	                       |
10 | C_RSUR     |  1	| Road surface                                 |
11 | C_RALN     |  1	| Road alignment	                       |
12 | C_TRAF     |  2	| Traffic control                              |
13 | V_ID       |  2    | Vehicle sequence number                      |
14 | V_TYPE     |  2    | Vehicle type                                 |
15 | V_YEAR     |  4    | Vehicle model year                           |
16 | P_ID       |  2    | Person sequence number                       |
17 | P_SEX      |  1    | Person sex                                   |
18 | P_AGE      |  2    | Person age	                               |
19 | P_PSN      |  2    | Person position	                       |
20 | P_ISEV     |  1    | Injury Severity (Medical treatment required) |
21 | P_SAFE     |  2    | Safety device used	                       |
22 | P_USER     |  1    | Road user class	                       |


1)  C_YEAR - Year in which the collision occurred
```
Code        Description
19yy-20yy      yy = last two digits of the calendar year. (e.g. 90, 91, 92)
```

2)  C_MNTH - Month in which the collision occurred
```
Code    Description
01      January
02      February
03      March
04      April
05      May
06      June
07      July
08      August
09      September
10      October
11      November
12      December
UU      Unknown
XX      Jurisdiction does not provide this data element
```

3)  C_WDAY - Day of the week the collision occurred 
```
Code      Description
1      Monday
2      Tuesday
3      Wednesday
4      Thursday
5      Friday
6      Saturday
7      Sunday
U      Unknown
X      Jurisdiction does not provide this data element
```


4)  C_HOUR - Collision hour
```
Code      Description
00      Midnight to  0:59
01       1:00 to  1:59
02       2:00 to  2:59
03       3:00 to  3:59
04       4:00 to  4:59
05       5:00 to  5:59
06       6:00 to  6:59
07       7:00 to  7:59
08       8:00 to  8:59
09       9:00 to  9:59
10      10:00 to 10:59
11      11:00 to 11:59
12      12:00 to 12:59
13      13:00 to 13:59
14      14:00 to 14:59
15      15:00 to 15:59
16      16:00 to 16:59
17      17:00 to 17:59
18      18:00 to 18:59
19      19:00 to 19:59
20      20:00 to 20:59
21      21:00 to 21:59
22      22:00 to 22:59
23      23:00 to 23:59
UU      Unknown
XX      Jurisdiction does not provide this data element
```


5)  C_SEV - Collision severity
```
Code      Description
1      Collision producing at least one fatality
2      Collision producing non-fatal injury
U      Unknown
X      Jurisdiction does not provide this data element
```


6)  C_VEHS - Number of vehicles involved in collision
```
Code      Description
01 - 98   01 - 98 vehicles involved.
99        99 or more vehicles involved.
UU        Unknown
XX        Jurisdiction does not provide this data element
```


7)  C_CONF - Collision configuration
```
Code    Description
        SINGLE VEHICLE IN MOTION:
01  Hit a moving object e.g. a person or an animal
02  Hit a stationary object e.g. a tree
03  Ran off left shoulder including rollover in the left ditch
04  Ran off right shoulder including rollover in the right ditch
05  Rollover on roadway
06  Any other single vehicle collision configuration
        TWO VEHICLES IN MOTION - Same Direction of Travel:
21  Rear-end collision
22  Side swipe
23  One vehicle passing to the left of the other, or left turn conflict
24  One vehicle passing to the right of the other, or right turn conflict
25  Any other two vehicle - same direction of travel configuration
        TWO VEHICLES IN MOTION- Different Direction of Travel:
31  Head-on collision
32  Approaching side-swipe
33  Left turn across opposing traffic
34  Right turn, including turning conflicts
35  Right angle collision
36  Any other two-vehicle - different direction of travel configuration
        TWO VEHICLES IN MOTION - Hit a Parked Motor Vehicle:
41  Hit a parked motor vehicle
        OTHERS
QQ  Choice is other than the preceding values
UU  Unknown
XX  Jurisdiction does not provide this data element
```


8)  C_RCFG - Roadway configuration
```
Code    Description
01      Non-intersection      e.g. 'mid-block'
02      At an intersection of at least two public roadways
03      Intersection with parking lot entrance/exit, driveway or laneway
04      Railroad level crossing
05      Bridge, overpass, viaduct
06      Tunnel or underpass
07      Passing or climbing lane
08      Ramp
09      Traffic circle
10      Express lane of a freeway system
11      Collector lane of a freeway system
12      Transfer lane of a freeway system
QQ      Choice is other than the preceding values
UU      Unknown
XX      Jurisdiction does not provide this data element
```


9)  C_WTHR - Weather condition
```
Code   Description
1      Clear and sunny
2      Overcast, cloudy but no precipitation
3      Raining
4      Snowing, not including drifting snow
5      Freezing rain, sleet, hail
6      Visibility limitation (drifting snow, fog, smog, dust, smoke)
7      Strong wind
Q      Choice is other than the preceding values
U      Unknown
X      Jurisdiction does not provide this data element
```


 
10)  C_RSUR - Road surface
```
Code   Description
1      Dry, normal
2      Wet
3      Snow (fresh, loose snow)
4      Slush ,wet snow
5      Icy      Includes packed snow
6      Sand/gravel/dirt (Refers to the debris on the road) 
7      Muddy
8      Oil (Includes spilled liquid or road application)
9      Flooded
Q      Choice is other than the preceding values
U      Unknown
X      Jurisdiction does not provide data element
```


11)  C_RALN - Road alignment
```
Code   Description
1      Straight and level
2      Straight with gradient
3      Curved and level
4      Curved with gradient
5      Top of hill or gradient
6      Bottom of hill or gradient      "Sag"
Q      Choice is other than the preceding values
U      Unknown
X      Jurisdiction does not provide this data element
```


 
12)  C_TRAF - Traffic control
```
Code    Description
01      Traffic signals fully operational
02      Traffic signals in flashing mode
03      Stop sign
04      Yield sign
05      Warning sign      Yellow diamond shape sign
06      Pedestrian crosswalk      
07      Police officer      
08      School guard, flagman      
09      School crossing
10      Reduced speed zone
11      No passing zone sign
12      Markings on the road      e.g. no passing
13      School bus stopped with school bus signal lights flashing
14      School bus stopped with school bus signal lights not flashing
15      Railway crossing with signals, or signals and gates
16      Railway crossing with signs only
17      Control device not specified
18      No control present
QQ      Choice is other than the preceding values
UU      Unknown
XX      Jurisdiction does not provide this data element
```


13)  V_ID - Vehicle sequence number
```
Code      Description
01 - 98   01 - 98
99        Vehicle sequence number assigned to pedestrians
UU        Unknown.  
                In cases where a person segment cannot be correctly matched 
                with the vehicle that he/she was riding in, 
                the Vehicle Sequence Number is set to UU.
```

14)  V_TYPE - Vehicle type
```
Code Description
01   Light Duty Vehicle (car, van, Light utility vehicles or  trucks)
05   Panel/cargo van <= 4536 KG GVWR (Panel or window type of van)
06   Other trucks and vans <= 4536 KG GVWR (Unspecified, or any of LTVs)
07   Unit trucks > 4536 KG GVWR (heavy trucks, with/without a trailer)
08   Road tractor  with or without a semi-trailer
09   School bus (standard large type)
10   Smaller school bus (smaller type, seats < 25 passengers)
11   Urban and Intercity Bus      
14   Motorcycle and moped (Motorcycle and limited-speed motorcycle)
16   Off road vehicles/motorcycles (e.g. dirt bikes, ATVs) 
17   Bicycle      
18   Purpose-built motorhome exclude pickup campers
19   Farm equipment      
20   Construction equipment      
21   Fire engine      
22   Snowmobile      
23   Street car      
NN   Data element is not applicable (e.g. "dummy" for the pedestrian)
QQ   Choice is other than the preceding values
UU   Unknown      
XX   Jurisdiction does not provide this data element
```

 
15)  V_YEAR - Vehicle model year
```
Code       Description
19yy-20yy  Model Year 19YY to 20YY where 00<= YY <= Current Year + 1
NNNN       Data is not applicable (e.g. "dummy" for the pedestrian)
UUUU       Unknown
XXXX       Jurisdiction does not provide this data element
```


16)  P_ID - Person sequence number
```
Code      Description
01 - 99   01 - 99
NN        Data is not applicable (e.g. "dummy" for the parked car)
UU        Unknown      e.g. applies to runaway cars
```


17)  P_SEX - Person sex
```
Code   Description
F      Female
M      Male
N      Data is not applicable (e.g. “dummy" parked car)
U      Unknown      e.g. applies to runaway cars
X      Jurisdiction does not provide this data element
```


18)  P_AGE - Person age
```
Code     Description
00       Less than 1 Year old
01 – 98  1 to 98 Years old
99       99 Years or older
NN       Data is not applicable (e.g. "dummy" for parked car) 
UU       Unknown      e.g. applies to runaway cars
XX       Jurisdiction does not provide this data element
```

 
19)  P_PSN - Person position
```
Code    Description
11      Driver
12      Front row, center
13      Front row, right outboard, including passenger in sidecar
21      Second row, left outboard, including motorcycle passenger
22      Second row, center
23      Second row, right outboard
31      Third row, left outboard
32      Third row, center
33      Third row, right outboard etc.      
96      Position unknown, but the person was definitely an occupant
97      Sitting on someone’s lap
98      Outside passenger compartment (e.g. back of a pick-up truck)
99      Pedestrian      
NN      Data is not applicable (e.g. "dummy" for parked car) 
QQ      Choice is other than the preceding value
UU      Unknown      e.g. applies to runaway cars
XX      Jurisdiction does not provide this data element
```


20)  P_ISEV - Injury Severity (Medical treatment required)
```
Code   Description
1      No Injury
2      Injury      
3      Fatality (died immediately or within the time limit)
N      Data is not applicable (e.g. "dummy" for parked car) 
U      Unknown      e.g. applies to runaway cars
X      Jurisdiction does not provide this data element
```


 
21)  P_SAFE - Safety device used
```
Code    Description
01      No safety device used or No child restraint used
02      Safety device used or child restraint used
09      Helmet worn (e.g. for motorcyclists, bicyclists, snowmobilers) 
10      Reflective clothing worn (riders and pedestrians)
11      Both helmet and reflective clothing used
12      Other safety device used
13      No safety device equipped (e.g. buses)
NN      Data is not applicable (e.g. "dummy" for parked car)
QQ      Choice is other than the preceding values
UU      Unknown      e.g. applies to runaway cars
XX      Jurisdiction does not provide this data element
```


22)  P_USER - Road user class
```
Code   Description
1      Motor Vehicle Driver
2      Motor Vehicle Passenger
3      Pedestrian
4      Bicyclist
5      Motorcyclist
U      Not stated / Other / Unknown
```
