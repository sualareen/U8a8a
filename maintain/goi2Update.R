library(here)

#读取
goi2root <- readRDS(here("lib", "Databases", "jlpt3_goi2.rds"))
goi2read <- read.csv(here("temp.csv"), sep = ",", header = FALSE, stringsAsFactors = FALSE)

#维护
#1列名更新
colnames(goi2read) <- c("過去問", "文例", "問題", "選択肢１", "選択肢２", "選択肢３", "選択肢４", "正解")
df <- rbind(goi2root, goi2read)
#2排序更新7
#sorted_goi1read <- goi1read[order(goi1read[,7]), ]
#3新增一列,列名为“是否真题”的日文表达，然后默认值为FALSE
#goi1root$過去問 <- "000000N3goi1"
#4重复值舍弃
unique_df <- unique(df)

#保存
saveRDS(unique_df, here("lib", "Databases", "jlpt3_goi2.rds"))

# 清空temp.csv文件 (Clear the temp.csv file)
cat("", file = here("temp.csv"))