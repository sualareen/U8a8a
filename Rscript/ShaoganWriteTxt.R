#导入包
library(readxl)
library(tidyverse)

#定义函数

#获取汉字列
set_kanji_df <- function(temp){
  #初始化数据框
  kanji_df <- data.frame(count = integer(), 番号 = integer(), 漢字文字列 = character(), stringsAsFactors = FALSE)
  count <- 1
  #获取汉字字符
  for (i in seq_along(temp)) {
    text <- temp[i]
    kanji_chars <- paste0(unlist(regmatches(text, gregexpr("[\u4E00-\u9FFF]", text))))
    for (kanji in kanji_chars) {
      kanji_df <- rbind(kanji_df, data.frame(count = count, 番号 = i,　漢字文字列  = kanji, stringsAsFactors = FALSE)) 
      count <- count + 1
    }
}
  #降重
  kanji_df <- kanji_df[!duplicated(kanji_df[c("番号", "漢字文字列")], fromLast = FALSE),]
  #建表
  kanji_df <- merge(kanji_df, cjk_data, by.x = "漢字文字列", by.y = "hyoushi", all.x = TRUE)
  #获取读音
  return(kanji_df)
}

# 检测操作系统类型 
os_type <- .Platform$OS.type 
# 获取桌面路径 
if (os_type == "windows") { 
  desktop_path <- file.path(Sys.getenv("USERPROFILE"), "Desktop") 
} else { 
  desktop_path <- file.path(Sys.getenv("HOME"), "Desktop") 
}
#定义脚本目录
script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)

#构建几个相对路径
currentDay <- format(Sys.Date(), "%Y-%m-%d")
filename <- paste0(currentDay, ".txt")
sgn_file <- file.path(script_dir, "..", "lib", "shonagon.xlsx")
cjk_file <- file.path(script_dir, "..", "lib", "cjk_unified_ideographs.xlsx")
writeTxt_file <- file.path(desktop_path, filename)


#读入文件
sgn_data <- read_excel(sgn_file) 
cjk_data <<- read_excel(cjk_file)

#格式化sgn_file数据框
sgn_data <- sgn_data %>% 
  mutate(全文脈 = paste0(表示番号, " ", coalesce(前文脈, ""), coalesce(検索文字列, ""), coalesce(後文脈, "")))
temp <- sgn_data$全文脈

kanji_df <- set_kanji_df(temp)
#排序
kanji_df <- kanji_df[order(kanji_df$count),]

temp <- vector("character", length(unique(kanji_df$番号)))

for (i in unique(kanji_df$番号)) {
  s <- "\t"
  subset_df <- kanji_df[kanji_df$番号 == i, ]
  for (j in seq_along(subset_df$count)) {
    s <- paste0(s, subset_df$漢字文字列[j], "\t", subset_df$yomi[j], "\n\t")
  }
  temp[i] <- s
}

#
sgn_data$漢字情報 <-　temp 
#前言内容
writeLines("这里可以写前言", writeTxt_file)
#正文
sgn_data <- sgn_data %>% 
  mutate(w = paste0(全文脈, "\n", 漢字情報, "\n備考："))

write.table(sgn_data$w, file = writeTxt_file, 
            row.names = FALSE, col.names = FALSE, quote = FALSE,
            sep = "\n", append = TRUE)
