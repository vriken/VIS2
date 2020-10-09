library("ggplot2") # detta inkluderar biblioteket ggplot2 så att funktioner från den kan användas
setwd("C:\\Users\\vrike\\Downloads") # här säger vi åt programmet att byta till detta directoryt för att läsa och skriva
data <- read.csv("VIS1 Lon.csv") # här läser vi in datan för uppgift 1 B, och C från VIS1 Lon.csv, samt definerar den som data
withoutOutliers <- filter(data, Lon < 50000) # här skapar vi ett nytt dataobjekt av det gamla
# förutom att vi tar bort alla element som är under 50000
ggplot(data, aes(x = Alder, y = Lon)) + # här skapar vi ett ggplot objekt med datan som vi definerade i raden ovan. Vi sätter också aesthetics för x, och y. Namnen defineras från data objektets kolumner.
  geom_point(size = 2.5) + # ropar vi på en funktion geom_point som skapar ett scatter plot objekt och sätter punkterna i detta objekt till 2.5
  #vi använder oss även av se = FALSE, som gör att förtroendebanden inte visas. Vi använder också en implicit praxisformel (formula = y ~ x)
  #detta skapar regressionslinjen för som säger att y är beroende av x, som är den oberoende variabeln, eftersom den är på höger sida av ~. Vi definerar också aestheticen för color som "A", detta kommer att användas senare
  geom_smooth(data = data, method = lm, se = FALSE, formula = y ~ x, aes(color = "Med extremvärden")) + # här skapar vi den andra regressionslinjen med metoden lm som står för linear model. Denna metod skapar en standard regressionsmodell.
  geom_smooth(data = withoutOutliers, method = lm, se = FALSE, formula = y ~ x, aes(color = "Utan extremvärden")) +
  # i den andra geom_smoothen gör vi en exakt likadan smooth som i raden över, förutom att den använder sig av data
  # som inte inkluderar extremvärdet 57564
  # vi använder både se = FALSE, och formula = y ~ x, tillsammans med definitionen color = "B", som också kommer till användning i raden nedan.
  scale_colour_manual(name="legend", values=c("red", "blue")) +# här sätter vi färgerna och legender för regressionslinjerna
  #Legenden döper vi till Legend, och värdena på färgerna får A = "red", och B = "blue" i ordning
  labs(x = "Lön",
       y = "Ålder",
       title = "Spridningsdiagram med regressionslinje",
       subtitle = "över sambandet mellan ålder och lön på arbetsplatsen NotReal AB",
       caption = "Källa: Utdrag från lönedatabasen på NotReal AB") +
  #i labs så definerar vi namn för x-axeln, y-axeln, titeln, subtiteln, och footnoten.
  theme(axis.title.y = element_text(angle = 0, hjust = 0, vjust = 0.7),
        plot.title = element_text(size = 15, hjust = 0, face = "bold", color = "maroon", vjust = -0.5),
        plot.subtitle = element_text(size = 9, hjust = 0, face = "italic", color = "chocolate1"),
        plot.caption = element_text(size = 10, hjust = 1, face = "italic", color = "navy"))
  #i theme definerar vi lite grafiska egenskaper för axlarnas, och titlarnas utseende, b.la vinkel, centrering, färg osv.
