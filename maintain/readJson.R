library(jsonlite)
library(here)
data <- fromJSON("N3.json")
#注意学习使用向量化能力啊
na <- data$furigana == ""
data$furigana[na] <- data$word[na]

saveRDS(data, here("lib", "Databases", "wordList.rds"))
