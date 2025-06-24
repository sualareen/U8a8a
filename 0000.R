library(stringr)
library(readxl)
script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

file_path <- "C:/Users/Administrator/Desktop/forMiniToolsTemp/U8a8a/temp.txt"
lines <- readLines(file_path, encoding = "UTF-8")

TWC_file <- file.path(script_dir, "lib", "TWC.xlsx")
TWC_data <- read_excel(TWC_file) 
#删除空行
line <- lines[lines != ""]
text <- paste(line, collapse = ",")
form_text <- str_replace_all(text, "[\\s\\t]", "")
list_of_texts <- strsplit(form_text, "\\*")[[1]]

a <- strsplit(list_of_texts[[6]], ",")[[1]]
temp_df <- data.frame(lemma = a, stringsAsFactors = FALSE)
temp_df <- temp_df[-1, , drop = FALSE]

#kanji yomi pindu dsc
# 创建新的空数据框 
empty_df <- na.omit(TWC_data[TWC_data$レマ == "", ])

for (i in 1:nrow(temp_df$Kanji)) {
  value <- temp_df$Kanji[i]
  other <- na.omit(TWC_data[TWC_data$レマ == value, ])
}