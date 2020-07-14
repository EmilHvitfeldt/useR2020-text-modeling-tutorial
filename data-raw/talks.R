library(tidyverse)
library(rvest)
library(here)

pycon2018 <- read_html("https://pycon-archive.python.org/2018/schedule/talks/list/") %>%
  html_nodes('div[class="presentation-description"]') %>%
  html_text() %>%
  tibble(description = .,
         language = "python",
         year = 2018)

pycon2019 <- read_html("https://us.pycon.org/2019/schedule/talks/list/") %>%
  html_nodes('div[class="presentation-description"]') %>%
  html_text() %>%
  tibble(description = .,
         language = "python",
         year = 2019)


erum2020 <- read_html("https://milano-r.github.io/erum2020program/regular-talks.html") %>%
  html_nodes("div[class='section level3']") %>%
  html_text() %>%
  map_chr(~ str_split(.x, "Abstract:\n")[[1]][2]) %>%
  tibble(description = .,
         language = "r",
         year = 2020)

user2019 <- read_html("https://www.user2019.fr/talk_schedule/") %>%
  html_nodes('table tbody') %>%
  html_nodes('tr[class!="filtered"]') %>%
  html_text()  %>%
  tibble(description = .,
         language = "r",
         year = 2019)

talks <- bind_rows(
  pycon2019,
  pycon2018,
  user2019,
  erum2020
)

write_csv(talks, here("data/talks.csv"))

