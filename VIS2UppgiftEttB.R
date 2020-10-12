library("ggplot2") # detta inkluderar biblioteket ggplot2 sÃ¥ att funktioner frÃ¥n den kan anvÃ¤ndas
setwd("C:\\Users\\vrike\\Downloads") # hÃ¤r sÃ¤ger vi Ã¥t programmet att byta till detta directoryt fÃ¶r att lÃ¤sa och skriva
data <- read.csv("VIS1 Lon.csv") # hÃ¤r lÃ¤ser vi in datan fÃ¶r uppgift 1 B, och C frÃ¥n VIS1 Lon.csv, samt definerar den som data
withoutOutliers <- filter(data, Lon < 50000) # hÃ¤r skapar vi ett nytt dataobjekt av det gamla
# fÃ¶rutom att vi tar bort alla element som Ã¤r under 50000
ggplot(data, aes(x = Lon, y = Alder)) + # hÃ¤r skapar vi ett ggplot objekt med datan som vi definerade i raden ovan. Vi sÃ¤tter ocksÃ¥ aesthetics fÃ¶r x, och y. Namnen defineras frÃ¥n data objektets kolumner.
  geom_point(size = 2.5) + 
  scale_x_continuous(breaks = c(10000,20000,30000,40000,50000,60000), limits = c(10000,60000)) + # detta ändrar limits för x axeln, samt hur många stödlinjer som ska visas
  scale_y_continuous(breaks = c(25,35,45), limits = c(23.2,47)) + # detta ändrar hur många linjer på y axeln som visas
  # ropar vi pÃ¥ en funktion geom_point som skapar ett scatter plot objekt och sÃ¤tter punkterna i detta objekt till 2.5
  #vi anvÃ¤nder oss Ã¤ven av se = FALSE, som gÃ¶r att fÃ¶rtroendebanden inte visas. Vi anvÃ¤nder ocksÃ¥ en implicit praxisformel (formula = y ~ x)
  #detta skapar regressionslinjen fÃ¶r som sÃ¤ger att y Ã¤r beroende av x, som Ã¤r den oberoende variabeln, eftersom den Ã¤r pÃ¥ hÃ¶ger sida av ~. Vi definerar ocksÃ¥ aestheticen fÃ¶r color som "A", detta kommer att anvÃ¤ndas senare
  geom_smooth(data = data, method = lm, se = FALSE, formula = y ~ x, aes(color = "Med extremvärden")) + # hÃ¤r skapar vi den andra regressionslinjen med metoden lm som stÃ¥r fÃ¶r linear model. Denna metod skapar en standard regressionsmodell.
  geom_smooth(data = withoutOutliers, method = lm, se = FALSE, formula = y ~ x, aes(color = "Utan extremvärden")) +
  # i den andra geom_smoothen gÃ¶r vi en exakt likadan smooth som i raden Ã¶ver, fÃ¶rutom att den anvÃ¤nder sig av data
  # som inte inkluderar extremvÃ¤rdet 57564
  # vi anvÃ¤nder bÃ¥de se = FALSE, och formula = y ~ x, tillsammans med definitionen color = "B", som ocksÃ¥ kommer till anvÃ¤ndning i raden nedan.
  scale_colour_manual(name="legend", values=c("red", "blue")) +# hÃ¤r sÃ¤tter vi fÃ¤rgerna och legender fÃ¶r regressionslinjerna
  #Legenden dÃ¶per vi till Legend, och vÃ¤rdena pÃ¥ fÃ¤rgerna fÃ¥r A = "red", och B = "blue" i ordning
  labs(x = "Lön",
       y = "Ålder",
       title = "Spridningsdiagram med regressionslinje",
       subtitle = "över sambandet mellan ålder och lön på arbetsplatsen NotReal AB",
       caption = "Källa: Utdrag från lönedatabasen på NotReal AB") +
  #i labs sÃ¥ definerar vi namn fÃ¶r x-axeln, y-axeln, titeln, subtiteln, och footnoten.
  theme(axis.title.y = element_text(angle = 0, hjust = 0, vjust = 0.7),
        plot.title = element_text(size = 15, hjust = 0, face = "bold", color = "maroon", vjust = -0.5),
        plot.subtitle = element_text(size = 9, hjust = 0, face = "italic", color = "chocolate1"),
        plot.caption = element_text(size = 10, hjust = 0, face = "italic", color = "navy"))
  #i theme definerar vi lite grafiska egenskaper fÃ¶r axlarnas, och titlarnas utseende, b.la vinkel, centrering, fÃ¤rg osv.
