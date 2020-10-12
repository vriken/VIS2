library("ggplot2")
library("reshape2")
library("dplyr")
#här inkluderar vi lite diverse bibliotek
setwd("C:/Users/vrike/Downloads")
#här ändrar vi working directoryt
data <- read.csv("VIS2 COVID-19.csv")
#här skapar vi ett dataobjekt med namnet data, som läser av datafilen VIS2 COVID19.....
#med read.csv() funktionen
data <- melt(data,
             id.vars = "Statistikdatum",
             variable.name = "Plats",
             value.name = "Totalt")
#här manipulerar vi dataobjektet genom att använda melt() funktionen, som gör datan till en long
#Detta behöver vi göra för att sammanfoga Stockholms-och-Östergötlandskolumnerna.
#Sen sätter vi namn för de olika kolumerna, vi sätter namnet för denna sammanfogade kolumn till
#Plats. Vi skapar också ett nytt namn för Totalt_antal_fall som blir "Totalt"
data <- filter(data, Plats != "Totalt_antal_fall")
#denna rad tar bort alla Platser i datan med namnet "Totalt_antal_fall, eftersom detta inte söks
#i grafen 
ggplot(data = data,
       aes(x = as.Date(Statistikdatum, tryFormats = c("%d/%m/%y")), # jag behövde lägga till ett explicit sätt att kolla för vilket format för att använda scale_x_date
           y = Totalt,
           group = Plats,
           color = Plats)
) +
  #här skapar vi ett ggplot objekt som använder sig av datafilen som är modifierad.
  #vi definerar också aes'en så att den använder sig av statistikdatum som x värde, som använder sig av
  #as.Date() funktionen som gör så att vi kan använda scale_x_date() funktionen på rad 47.
  #Totalt, som y värde. Group som Plats, och färger som Plats
  labs(caption = "Källa: Folkhälsomyndigheten", # detta lägger till en footnote
       subtitle = "Med regionerna Stockholm, och Östergötland", # detta lägger till och ändrar subtiteln för grafen
       title = "Jämförelse av olika regioners COVID-19 utveckling" # dettalägger till och ändrar titeln för grafen
  ) +
  
  ylab("Totalt antal \nCOVID-19 fall" # detta ändrar y-axelns text
  ) +
  
  theme(axis.text.x = element_text(angle = 35,
                                   vjust = 0.5,
                                   size = 11),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5,
                                    size = 14),
        legend.title = element_text(size = 14,),
        legend.text = element_text(size = 14),
        legend.key.size = unit(0.75, "cm")
  ) +
  
  # Theme raderna ändrar attributerna för x axelns texts rotation och centrerar den till mitten. Vi bestämde oss för att inte ändra storleken på datumen eftersom det blev oläsbart när dem var för stora
  # Den ändrar också på y axelns rotation, storlek, och centrering
  # vi ändrar också storleken på legendens titel, som i detta fall är "Plats"
  # Tillsammans med legend-texten "som i detta fall är "Stockholm", och "Östergötland"
  # Det sista vi ändrar i theme är legend key size, som är de små fyrkanterna där färgerna för linjerna ritas.
  # denna skala använder sig av en statisk 0.75cm storlek, detta kan vara problematiskt om man ska visa grafen på en väldigt stor skärm

geom_line() +  # denna rad ritar ut grafen
  scale_x_date(date_breaks = "3 weeks", date_labels = "%Y-%m-%d", name = "Datum") #
#denna rad ändrar ticksen för x skalan så att den visar datum för varannan vecka i formatet YYYY-MM-DD
#den ändrar också namnet för x axeln så att den är "Datum
  
  