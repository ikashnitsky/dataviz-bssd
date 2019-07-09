

library(eurostat)

# n2p1 <- get_eurostat("demo_r_d2jan"

eu_gind <- get_eurostat("demo_gind")

eu_gind$indic_de %>% unique()

# list countries ordered by pop size
countries <- eu_gind %>% 
        mutate(cntr = geo %>% paste) %>% 
        filter(nchar(cntr) == 2, 
               time %>% lubridate::year() == 2017,
               indic_de == "POPT") %>% 
        arrange(desc(values)) %>% 
        pull(cntr)
        

set.seed(911)

hereweare <- c("Sally Sonia Simmons", "BLANCA IRIÑIZ", "Rafael Navarro", "Iracy Silva Pimienta", "Paola Vazquez", "Emmanuel Olamijuwon", "Juan Antonio Romero", "Andrea PERALTA", "Jitka Sbala", "Jose Rafael Caro", "Juliana Jaramillo", "Sarai Miranda", "Adrian Palacios", "Sarah Raferty")


nstud <- length(hereweare)

ncntr <- countries[1:nstud]


df_assign <- tibble(
        email = hereweare,
        country = sample(ncntr)
) 

df_assign %>% View
        
        