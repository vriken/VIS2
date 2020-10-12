library("ggplot2") # detta inkluderar biblioteket ggplot2 sÃÂ¥ att funktioner frÃÂ¥n den kan anvÃÂ¤ndas
setwd("C:\\Users\\vrike\\Downloads") # hÃÂ¤r sÃÂ¤ger vi ÃÂ¥t programmet att byta till detta directoryt fÃÂ¶r att lÃÂ¤sa och skriva
data <- read.csv("VIS1 Lon.csv") # hÃÂ¤r lÃÂ¤ser vi in datan fÃÂ¶r uppgift 1 B, och C frÃÂ¥n VIS1 Lon.csv, samt definerar den som data
withoutOutliers <- filter(data, Lon < 50000) # hÃÂ¤r skapar vi ett nytt dataobjekt av det gamla
# fÃÂ¶rutom att vi tar bort alla element som ÃÂ¤r under 50000
ggplot(data, aes(x = Lon, y = Alder)) + # hÃÂ¤r skapar vi ett ggplot objekt med datan som vi definerade i raden ovan. Vi sÃÂ¤tter ocksÃÂ¥ aesthetics fÃÂ¶r x, och y. Namnen defineras frÃÂ¥n data objektets kolumner.
  geom_point(size = 2.5) + 
  scale_x_continuous(breaks = c(10000,20000,30000,40000,50000,60000), limits = c(10000,60000)) + # detta Ã¤ndrar limits fÃ¶r x axeln, samt hur mÃ¥nga stÃ¶dlinjer som ska visas
  scale_y_continuous(breaks = c(25,35,45), limits = c(23.2,47)) + # detta Ã¤ndrar hur mÃ¥nga linjer pÃ¥ y axeln som visas
  # ropar vi pÃÂ¥ en funktion geom_point som skapar ett scatter plot objekt och sÃÂ¤tter punkterna i detta objekt till 2.5
  #vi anvÃÂ¤nder oss ÃÂ¤ven av se = FALSE, som gÃÂ¶r att fÃÂ¶rtroendebanden inte visas. Vi anvÃÂ¤nder ocksÃÂ¥ en implicit praxisformel (formula = y ~ x)
  #detta skapar regressionslinjen fÃÂ¶r som sÃÂ¤ger att y ÃÂ¤r beroende av x, som ÃÂ¤r den oberoende variabeln, eftersom den ÃÂ¤r pÃÂ¥ hÃÂ¶ger sida av ~. Vi definerar ocksÃÂ¥ aestheticen fÃÂ¶r color som "A", detta kommer att anvÃÂ¤ndas senare
  geom_smooth(data = data, method = lm, se = FALSE, formula = y ~ x, aes(color = "Med extremvärden")) + # hÃÂ¤r skapar vi den andra regressionslinjen med metoden lm som stÃÂ¥r fÃÂ¶r linear model. Denna metod skapar en standard regressionsmodell.
  geom_smooth(data = withoutOutliers, method = lm, se = FALSE, formula = y ~ x, aes(color = "Utan extremvärden")) +
  # i den andra geom_smoothen gÃÂ¶r vi en exakt likadan smooth som i raden ÃÂ¶ver, fÃÂ¶rutom att den anvÃÂ¤nder sig av data
  # som inte inkluderar extremvÃÂ¤rdet 57564
  # vi anvÃÂ¤nder bÃÂ¥de se = FALSE, och formula = y ~ x, tillsammans med definitionen color = "B", som ocksÃÂ¥ kommer till anvÃÂ¤ndning i raden nedan.
  scale_colour_manual(name="legend", values=c("red", "blue")) +# hÃÂ¤r sÃÂ¤tter vi fÃÂ¤rgerna och legender fÃÂ¶r regressionslinjerna
  #Legenden dÃÂ¶per vi till Legend, och vÃÂ¤rdena pÃÂ¥ fÃÂ¤rgerna fÃÂ¥r A = "red", och B = "blue" i ordning
  labs(x = "Lön",
       y = "ålder",
       title = "Spridningsdiagram med regressionslinje",
       subtitle = "över sambandet mellan ålder och lön på arbetsplatsen NotReal AB",
       caption = "Källa: Utdrag från lönedatabasen på NotReal AB") +
  #i labs sÃÂ¥ definerar vi namn fÃÂ¶r x-axeln, y-axeln, titeln, subtiteln, och footnoten.
  theme(axis.title.y = element_text(angle = 0, hjust = 0, vjust = 0.7),
        plot.title = element_text(size = 15, hjust = 0, face = "bold", color = "maroon", vjust = -0.5),
        plot.subtitle = element_text(size = 9, hjust = 0, face = "italic", color = "chocolate1"),
        plot.caption = element_text(size = 10, hjust = 0, face = "italic", color = "navy"))
  #i theme definerar vi lite grafiska egenskaper fÃÂ¶r axlarnas, och titlarnas utseende, b.la vinkel, centrering, fÃÂ¤rg osv.
