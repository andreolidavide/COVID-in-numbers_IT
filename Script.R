# Load the necessary libraries
library(tidyverse)
# Disable scientific notation for this session
options(scipen=999)

# Recover the national data and store it in the national_data data frame
national_data_URL <- "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv"
national_data  <-  read_csv(national_data_URL)
national_data  <-  read_csv("./dpc-covid19-ita-andamento-nazionale.csv")

# Recover the regional data and store it in the regional_data data frame
regional_data_URL <- "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv"
regional_data <- read_csv(file=regional_data_URL)
regional_data  <-  read_csv("./dpc-covid19-ita-regioni.csv")

# Recover the population by age range for each region and store it in the regional_population_by_age data frame
regional_population_by_age_URL <- "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-statistici-riferimento/popolazione-istat-regione-range.csv"
regional_population_by_age <- read_csv(file=regional_population_by_age_URL)
regional_population_by_age <- read_csv("./popolazione-istat-regione-range.csv")

# Recover the vaccine data by age group and store it in the vaccine_data_by_age data frame
vaccine_data_by_age_URL <- "https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-latest.csv"
vaccine_data_by_age <- read_csv(vaccine_data_by_age_URL)
vaccine_data_by_age <- read_csv("./somministrazioni-vaccini-latest.csv")

# Recover the vaccine data and store it in the vaccine_data data frame
vaccine_data_URL <- "https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-summary-latest.csv"
vaccine_data <- read_csv(vaccine_data_URL)
vaccine_data <- read_csv("./somministrazione-vaccini-summary-latest.csv")

ggplot(data = national_data) +
  geom_point(mapping = aes(x = data, y=totale_positivi))

#Confronto tra nuovi positivi totale_casi giorno corrente - totale_casi giorno precedente e picco terapie intensive, in scala log per renderlo più confrontabile
ggplot(data = national_data) +
  geom_point(mapping = aes(x = data, y=nuovi_positivi)) + 
  geom_point(mapping = aes(x = data, y=terapia_intensiva)) + 
  scale_y_log10()

#Confronto tra nuovi positivi totale_casi giorno corrente - totale_casi giorno precedente e picco terapie intensive, in scala log per renderlo più confrontabile
filter(national_data, data < "2020-07-01") %>% 
  ggplot() +
  geom_point(mapping = aes(x = data, y=nuovi_positivi)) + 
  geom_point(mapping = aes(x = data, y=terapia_intensiva)) + 
  scale_y_log10()

#Confronto tra positivi e tamponi giornalieri
mutate(national_data, tamponi_giornalieri = tamponi - lag(tamponi), percentuale_positivi = nuovi_positivi / tamponi_giornalieri * 100) %>% 
  filter(percentuale_positivi > 0) %>% 
  ggplot() +
  geom_line(mapping = aes(x = data, y=percentuale_positivi))

  