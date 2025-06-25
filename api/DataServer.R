# 返回hifi音频id
#* @param pracNum 练习数目
#* @get /hifi
function(pracNum = "") {
  pracNum <- as.integer(URLdecode(pracNum))
  df <- df_hifi[sample(nrow(df_hifi), pracNum), ]
  return(df)
}

#* 随机返回指定题库的几行数据
#* @param pracNum 练习数目 
#* @param dfName 题库数据框名 
#* @get /rdm
function(pracNum = "", dfName = "") {
  # --- 1. 定义允许访问的数据框白名单 (核心安全措施) ---
  allowed_dfs <- c(
    # Goi (語彙) 题库
    "df_jlpt3_goi1", 
    "df_jlpt3_goi2", 
    "df_jlpt3_goi3", 
    "df_jlpt3_goi4", 
    "df_jlpt3_goi5",
    
    # Bun (文法) 题库
    "df_jlpt3_bun1",
    "df_jlpt3_bun2",
    "df_jlpt3_bun3",
    
    # Dok (読解) 题库
    "df_jlpt3_dok1",
    "df_jlpt3_dok2",
    "df_jlpt3_dok3",
    "df_jlpt3_dok4",
    
    # 新增: Tyo (聴解) 题库
    "df_jlpt3_tyo1",
    "df_jlpt3_tyo2",
    "df_jlpt3_tyo3",
    "df_jlpt3_tyo4",
    "df_jlpt3_tyo5"
  )
  
  # --- 2. 参数校验 ---
  pracNum <- URLdecode(pracNum)
  dfName <- URLdecode(dfName)
  
  if (pracNum == "" || dfName == "") {
    return(list(error = "错误：必须提供 'pracNum' 和 'dfName' 两个参数。"))
  }
  
  # --- 3. 安全校验：检查 dfName 是否在白名单内 ---
  if (!dfName %in% allowed_dfs) {
    return(list(error = paste("错误：无效或不允许的数据框名 '", dfName, "'。", sep = "")))
  }
  
  # --- 4. 核心逻辑 ---
  # 此处 get() 是安全的，因为 dfName 已经被白名单验证过
  target_df <- get(dfName)
  pracNum <- as.integer(pracNum)
  
  # 确保抽样数目不超过数据框的总行数
  if (pracNum > nrow(target_df)) {
    pracNum <- nrow(target_df)
  }
  
  # 执行抽样
  result_df <- target_df[sample(nrow(target_df), pracNum), ]
  
  return(result_df)
}
