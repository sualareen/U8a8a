# 返回hifi音频id
#* @param pracNum 练习数目
#* @get /hifi
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_hifi[sample(nrow(df_hifi), pracNum), ]
  return(df)
}

# 随机返回JLPTN3的词汇题目
#* @param pracNum 练习数目
#* @get /3goi1
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi1), pracNum), ]
  return(df)
}

#* @param pracNum 练习数目
#* @get /3goi2
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi2), pracNum), ]
  return(df)
}

#* @param pracNum 练习数目
#* @get /3goi3
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi3), pracNum), ]
  return(df)
}

#* @param pracNum 练习数目
#* @get /3goi4
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi4), pracNum), ]
  return(df)
}

#* @param pracNum 练习数目
#* @get /3goi5
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_jlpt3_goi1[sample(nrow(df_jlpt3_goi5), pracNum), ]
  return(df)
}

