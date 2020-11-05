library("ggplot2") # detta inkluderar biblioteket ggplot2 så att funktioner frågan den kan användas
data <- read.csv("https://raw.githubusercontent.com/vriken/VIS2/main/data/VIS1%20Lon.csv") # här läser vi in datan för uppgift 1 B, och C frågan VIS1 Lon.csv, samt definerar den som data
ggplot2::theme_set(ggplot2::theme_bw()) # h�r s�tter jag theme globalt i alla ggplot2 funktioner till
# fårutom att vi tar bort alla element som är under 50000
ggplot(data, aes(x = Alder, y = Lon)) + # här skapar vi ett ggplot objekt med datan som vi definerade i raden ovan. Vi sätter också aesthetics får x, och y. Namnen defineras från data objektets kolumner
  scale_y_continuous(breaks = c(10000,20000,30000,40000,50000,60000), limits = c(10000,60000)) + # detta ändrar limits fÃÂ¶r y axeln, samt hur många stÃÂ¶dlinjer som ska visas
  scale_x_continuous(breaks = c(25,30,35,40,45), limits = c(23.2,47)) + # detta ändrar hur många linjer på x axeln som visas
  # ropar vi på en funktion geom_point som skapar ett scatter plot objekt och sätter punkterna i detta objekt till 2.5
  #vi använder oss även av se = FALSE, som går att fårtroendebanden inte visas. Vi använder också en implicit praxisformel (formula = y ~ x)
  #detta skapar regressionslinjen får som säger att y är beroende av x, som är den oberoende variabeln, eftersom den är på höger sida av ~. Vi definerar också aestheticen får color som "A", detta kommer att användas senare
  geom_smooth(data = data, method = lm, se = FALSE, formula = y ~ x, aes(color = "Med extremv�rden")) + # här skapar vi den andra regressionslinjen med metoden lm som står får linear model. Denna metod skapar en standard regressionsmodell.
  geom_point(size = 2.5) +
  # i den andra geom_smoothen går vi en exakt likadan smooth som i raden över, fårutom att den använder sig av data
  # som inte inkluderar extremvärdet 57564
  # vi använder både se = FALSE, och formula = y ~ x, tillsammans med definitionen color = "B", som också kommer till användning i raden nedan.
  scale_colour_manual(name="Regressionslinjer", values=c("red", "blue")) +# här sätter vi färgerna och legender får regressionslinjerna
  #Legenden döper vi till Legend, och värdena på färgerna får A = "red", och B = "blue" i ordning
  labs(x = "�lder",
       y = "L�n",
       title = "Spridningsdiagram med regressionslinje",
       subtitle = "�ver sambandet mellan �lder och l�n p� arbetsplatsen NotReal AB",
       caption = "K�lla: Utdrag fr�n l�nedatabasen p� NotReal AB") +
  #i labs så definerar vi namn får x-axeln, y-axeln, titeln, subtiteln, och footnoten.
  theme(axis.title.y = element_text(angle = 0, hjust = 0, vjust = 0.7, size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14), 
        plot.title = element_text(size = 15, hjust = 0, face = "bold", vjust = -0.5),
        plot.subtitle = element_text(size = 11, hjust = 0, face = "italic"),
        plot.caption = element_text(size = 11, hjust = 0, face = "italic"))
#i theme definerar vi lite grafiska egenskaper får axlarnas, och titlarnas utseende, b.la vinkel, centrering, färg osv.
