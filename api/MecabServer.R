
mecabEcho <- function(text) {
  text <- shQuote(text)
  command <- paste("echo -e", text, "| mecab")
  result <- system(command, intern = TRUE)
  result <- result[-length(result)]
  return(result)
}

mecabTodf <- function(result) {
  result <- gsub("\t", ",", result)
  list <- strsplit(result, split = ",")
  df <- as.data.frame(do.call(rbind, list))
  colnames(df) <- c("表層形", "品詞", "品詞細分1", "品詞細分2", "品詞細分3", "活用型", "活用形", "原型", "読み", "発音")
  return(df)
}

# 底层的mecab，默认词典
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  decoded_msg <- URLdecode(msg)
  df <- mecabTodf(mecabEcho(decoded_msg))
  
  return(df)
}