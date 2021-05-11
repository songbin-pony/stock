import pymysql
# 程超系统1，3，13要改为1，4，13
pymysql.version_info = (1, 4, 13, "final", 0)
pymysql.install_as_MySQLdb()