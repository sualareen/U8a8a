library(here)
library(dplyr)
library(stringr)
#读取
goi1root <- readRDS(here("lib", "Databases", "jlpt3_goi1.rds"))
goi1read <- read.csv(here("temp.csv"), sep = ",", header = FALSE, stringsAsFactors = FALSE)

#维护
#1列名更新
colnames(goi1read) <- c("文例", "問題", "選択肢１", "選択肢２", "選択肢３", "選択肢４", "正解", "過去問")
df <- rbind(goi1root, goi1read)
#2排序更新7
#sorted_goi1read <- goi1read[order(goi1read[,7]), ]
#3新增一列,列名为“是否真题”的日文表达，然后默认值为FALSE
#goi1root$過去問 <- "000000N3goi1"
#4重复值舍弃
unique_df <- unique(df)
#5行数据修订
dplyr <- filter(goi1root, 問題 == "専門家")
anti_df <- anti_join(goi1root, dplyr)
#6去掉所有空格
#df_cleaned <- goi1root %>%
#  mutate(across(where(is.character), ~ str_replace_all(., " ", "")))
#保存
df <- goi1root %>% 
  filter(goi1root$過去問 != "000000N3goi1")
saveRDS(df_cleaned, here("lib", "Databases", "jlpt3_goi1.rds"))
saveRDS(df, here("lib", "Databases", "jlpt3_goi1.rds"))

# 清空temp.csv文件 (Clear the temp.csv file)
cat("", file = here("temp.csv"))
