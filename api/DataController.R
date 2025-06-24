source(here::here("lib", "DataLib.R"), echo = FALSE)

#* @param dfName The name of df, if null return all the dfName, or return the df.
#* @get /getdf
function(res, dfName) {
  if (missing(dfName)) {
    all_dfs <- names(which(sapply(ls(.GlobalEnv), function(x) is.data.frame(get(x)))))
    return(list(available_data_frames = all_dfs))
  }
  
  if (!exists(dfName, envir = .GlobalEnv)) {
    res$status <- 404 # Not Found
    return(list(error = paste("错误: 找不到名为 '", dfName, "' 的对象。", sep = "")))
  }
  
  target_object <- get(dfName, envir = .GlobalEnv)
  
  if (is.data.frame(target_object)) {
    return(target_object)
  } else {
    res$status <- 400 # Bad Request
    return(list(error = paste("错误: 对象 '", dfName, "' 已找到, 但它不是一个数据框。", sep = "")))
  }
}

#* @get /refresh
function() {
  source(here::here("lib", "DataLib.R"), echo = FALSE)
  return(list(status = "success", message = "Data source reloaded."))
}
