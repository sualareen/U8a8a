library(here)

#读取
goi5root <- readRDS(here("lib", "Databases", "jlpt3_goi5.rds"))
goi5read <- read.csv(here("temp.csv"), sep = ",", header = FALSE, stringsAsFactors = FALSE)

#维护
#1列名更新
colnames(goi5read) <- c("問題", "選択肢１", "選択肢２", "選択肢３", "選択肢４", "正解", "過去問")
df <- rbind(goi5root, goi5read)
#2排序更新7
#sorted_goi1read <- goi1read[order(goi1read[,7]), ]
#3新增一列,列名为“是否真题”的日文表达，然后默认值为FALSE
#goi1root$過去問 <- "000000N3goi1"
#4重复值舍弃
unique_df <- unique(df)

#保存
saveRDS(goi5read, here("lib", "Databases", "jlpt3_goi5.rds"))

# 清空temp.csv文件 (Clear the temp.csv file)
cat("", file = here("temp.csv"))
