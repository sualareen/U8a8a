library(plumber)
library(here) 

# 1. 创建一个根路由 (root router)
root <- pr()

# 2. 从 DataController.R 文件中创建一个子路由 (sub-router)
#    plumb() 会正确解析这个文件里的所有 API 注释
dataController <- plumb(here("api", "DataController.R"))
dataServer <- plumb(here("api", "DataServer.R"))
mecabServer <- plumb(here("api", "MecabServer.R"))
# 3. 将子路由挂载到根路由的某个路径下
#    这里我们将 DataController 的所有 API 挂载到 /data 路径下
root$mount("/control", dataController)
root$mount("/server", dataServer)
root$mount("/mecab", mecabServer)
# 4. 运行根路由
root$run(port = 35466)
