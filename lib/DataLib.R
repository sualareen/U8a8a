library(here)

df_twc <- read.csv(here("lib", "Databases", "TWC.csv"))
df_cjk <- read.csv(here("lib", "Databases", "cjk.csv"))
df_kjl <- read.csv(here("lib", "Databases", "KanjiLevel.csv"))

df_hifi <- readRDS(here("lib", "Databases", "hifiCaption.rds"))
df_jlpt3_goi1 <- readRDS(here("lib", "Databases", "jlpt3_goi1.rds"))