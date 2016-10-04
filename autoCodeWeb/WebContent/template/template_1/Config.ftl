#本地数据库配置
url=jdbc\:mysql\://${project.databaseIp}\:${project.databasePort?c}/${project.databaseName}?zeroDateTimeBehavior\=convertToNull
username=${project.databaseUser}
password=${project.databasePwd}