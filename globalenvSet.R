#引入包
library(R6)
#写入lib
source()
#定义脚本目录
env <- R6Class("env",
               dir <- dirname(rstudioapi::getActiveDocumentContext()$path),
               public = list(
                 env_name = "",
                 import_dir = "",
                 import_file_format = "",
                 outport_dir = "",
                 outport_file_format = "",
                 lib_df = data.frame(),
                 initialize = function(name){
                   self$env_name <- name
                   self$import_dir<- file.path(dir, ".", "io", "import")
                   self$import_file_format <- "xlsx"
                   self$outport_dir <- file.path(dir, ".", "io", "outport")
                   self$outport_file_format <- "txt"
                 }
               )
)

#