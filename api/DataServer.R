# 返回hifi音频id
#* @param pracNum 练习数目
#* @get /hifi
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_hifi[sample(nrow(df_hifi), pracNum), ]
  return(df)
}

# 返回JLPTN3的词汇1类型的测试
#* @param pracNum 练习数目
#* @get /3goi1
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi1), pracNum), ]
  return(df)
}
