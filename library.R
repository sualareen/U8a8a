library(RMeCab)

#编写lib
U8a8a_strsplit <- function(text) { 
  char_vector <- unlist(base::strsplit(text, split = "")) 
  char_vector <- char_vector[char_vector != "" & char_vector != " "] 
  return(char_vector) 
  }

U8a8a_extract_case <- function(text){
  char_vector <- unlist(base::strsplit(text, split = ""))
  char_vector <- char_vector[char_vector == "を" |
                             char_vector == "の" |  
                             char_vector == "と" |
                             char_vector == "に" |
                             char_vector == "へ" |
                             char_vector == "で" |
                             char_vector == "が" |
                             char_vector == "より" |
                             char_vector == "まで" |
                             char_vector == "から"]
  return(char_vector)
}

RMcab_tokenization <- function(text){
  char_vector <- RMeCabC(text)
  return(char_vector)
}

U8a8a_RMcab_attend_case <- function(text) { 
# 使用 RMeCabC 进行分词 
tokenized <- RMeCabC(text) 
# 定义要查找的“case” 
case_particles <- c("を", "の", "と", "に", "へ", "で", "が", "より", "まで", "から") 
# 初始化结果列表 
result <- c() 
position_market <- c() 
# 更正拼写错误 # 遍历分词结果 
for (i in 2:length(tokenized)) { 
  if (tokenized[i] %in% case_particles) { 
    # 将上一个分词与当前分词结合 
    combined <- paste(tokenized[i-1], tokenized[i], sep = "") 
    result <- c(result, combined) 
    position_market <- c(position_market, i)
  }
}
  return(result_df) 
}

U8a8a_RMcab_attend_verb <- function(text) {
  tokenized <- RMeCabC(text)
  verb_particles <- c("助詞", "助動詞")
  # 初始化结果列表 
  result <- c() 
  position_market <- c() 
  # 更正拼写错误 # 遍历分词结果 
  for (i in 1:length(tokenized)) { 
    token <- tokenized[[i]]
    if (!is.null(names(token)) && names(token) == "動詞") {
      if (i < length(tokenized) && !is.null(tokenized[[i + 1]]) && names(tokenized[[i + 1]]) %in% verb_particles) { 
        # 将当前分词与下一个分词结合
        # 将上一个分词与当前分词结合 
        combined <- paste(tokenized[i], tokenized[i+1], sep = "") 
        # 保存动词及其位置 
        result <- c(result, combined)
      } else {
        result <- c(result, token)
      }
      position_market <- c(position_market, i)
    }
  }
  # 创建结果数据框 
  result_df <- data.frame(position_market, result)
  return(result_df) 
}

