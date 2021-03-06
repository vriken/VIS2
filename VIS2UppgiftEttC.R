library("ggplot2") # detta inkluderar biblioteket ggplot2 s� att funktioner fr�gan den kan anv�ndas
data <- read.csv("https://raw.githubusercontent.com/vriken/VIS2/main/data/VIS1%20Lon.csv") # här läser vi in datan för uppgift 1 B, och C frågan VIS1 Lon.csv, samt definerar den som data
ggplot2::theme_set(ggplot2::theme_bw()) # h�r s�tter jag theme globalt i alla ggplot2 funktioner till
withoutOutliers <- filter(data, Lon < 50000) # h�r skapar vi ett nytt dataobjekt av det gamla
# f�rutom att vi tar bort alla element som �r under 50000
ggplot(data, aes(x = Alder, y = Lon)) + # h�r skapar vi ett ggplot objekt med datan som vi definerade i raden ovan. Vi s�tter ocks� aesthetics f�r x, och y. Namnen defineras fr�n data objektets kolumner
  scale_y_continuous(breaks = c(10000,20000,30000,40000,50000,60000), limits = c(10000,60000)) + # detta �ndrar limits fÃ¶r y axeln, samt hur m�nga stÃ¶dlinjer som ska visas
  scale_x_continuous(breaks = c(25,30,35,40,45), limits = c(23.2,47)) + # detta �ndrar hur m�nga linjer p� x axeln som visas
  # ropar vi p� en funktion geom_point som skapar ett scatter plot objekt och s�tter punkterna i detta objekt till 2.5
  #vi anv�nder oss �ven av se = FALSE, som g�r att f�rtroendebanden inte visas. Vi anv�nder ocks� en implicit praxisformel (formula = y ~ x)
  #detta skapar regressionslinjen f�r som s�ger att y �r beroende av x, som �r den oberoende variabeln, eftersom den �r p� h�ger sida av ~. Vi definerar ocks� aestheticen f�r color som "A", detta kommer att anv�ndas senare
  geom_smooth(data = data, method = lm, se = FALSE, formula = y ~ x, aes(color = "Med extremv�rden")) + # h�r skapar vi den andra regressionslinjen med metoden lm som st�r f�r linear model. Denna metod skapar en standard regressionsmodell.
  geom_smooth(data = withoutOutliers, method = lm, se = FALSE, formula = y ~ x, aes(color = "Utan extremv�rden")) +
  geom_point(size = 2.5) +
  # i den andra geom_smoothen g�r vi en exakt likadan smooth som i raden �ver, f�rutom att den anv�nder sig av data
  # som inte inkluderar extremv�rdet 57564
  # vi anv�nder b�de se = FALSE, och formula = y ~ x, tillsammans med definitionen color = "B", som ocks� kommer till anv�ndning i raden nedan.
  scale_colour_manual(name="legend", values=c("red", "blue")) +# h�r s�tter vi f�rgerna och legender f�r regressionslinjerna
  #Legenden d�per vi till Legend, och v�rdena p� f�rgerna f�r A = "red", och B = "blue" i ordning
  labs(x = "�lder",
       y = "L�n",
       title = "Spridningsdiagram med regressionslinje",
       subtitle = "�ver sambandet mellan �lder och l�n p� arbetsplatsen NotReal AB",
       caption = "K�lla: Utdrag fr�n l�nedatabasen p� NotReal AB") +
  #i labs s� definerar vi namn f�r x-axeln, y-axeln, titeln, subtiteln, och footnoten.
  theme(axis.title.y = element_text(angle = 0, hjust = 0, vjust = 0.7),
        axis.text.y = element_text(size = 11),
        axis.text.x = element_text(size = 11),
        legend.text = element_text(size = 11), 
        plot.title = element_text(size = 15, hjust = 0, face = "bold", color = "maroon", vjust = -0.5),
        plot.subtitle = element_text(size = 9, hjust = 0, face = "italic", color = "chocolate1"),
        plot.caption = element_text(size = 10, hjust = 0, face = "italic", color = "navy"))
#i theme definerar vi lite grafiska egenskaper f�r axlarnas, och titlarnas utseende, b.la vinkel, centrering, f�rg osv.