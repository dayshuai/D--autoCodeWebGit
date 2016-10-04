#http://www.cnblogs.com/ITtangtang/p/3926665.html   这里有日志说明
#log4j.rootLogger = [ level ] , appenderName, appenderName, ...
log4j.rootLogger = ALL,console,allLevel,infoLevel,warnLevel,errorLevel

#branch logger
log4j.logger.InfoLogger = ALL,infoLevel
log4j.logger.ErrorLogger = ALL,errorLevel

log4j.rootCategory=FileApp, ConApp
log4j.category.com.gzedu = debug
log4j.category.com.ibatis = error
log4j.category.freemarker = error
log4j.category.org.springframework = error
log4j.category.com.opensymphony = info
log4j.category.org.apache = info
log4j.category.java.sql = error

log4j.logger.org.springframework=ALL
log4j.logger.org.springframework.jdbc.core.JdbcTemplate=ALL


#org.apache.log4j.ConsoleAppender（控制台）
#org.apache.log4j.FileAppender（文件）
#org.apache.log4j.DailyRollingFileAppender（每天产生一个日志文件）
#org.apache.log4j.RollingFileAppender（文件大小到达指定尺寸的时候产生一个新的文件）
#org.apache.log4j.WriterAppender（将日志信息以流格式发送到任意指定的地方）

#console 
log4j.appender.console = org.apache.log4j.ConsoleAppender
log4j.appender.console.layout = org.apache.log4j.PatternLayout
log4j.appender.console.Threshold = info
log4j.appender.console.layout.ConversionPattern = %-d{yyyy-MM-dd HH:mm:ss} [%c]-[%p] %m%n
log4j.appender.console.layout.Target=System.err

#infoLevel
log4j.appender.infoLevel = org.apache.log4j.RollingFileAppender
log4j.appender.infoLevel.File =${r"${project.projectName}.root"}/logs/info/infolog.txt
log4j.appender.infoLevel.MaxFileSize = 5MB
log4j.appender.infoLevel.MaxBackupIndex = 1000
log4j.appender.infoLevel.Threshold = INFO
log4j.appender.infoLevel.layout = org.apache.log4j.PatternLayout
log4j.appender.infoLevel.layout.ConversionPattern=%-d{yyyy-MM-dd HH:mm:ss} [%c]-[%p] - %m%n

#warnLevel
log4j.appender.warnLevel = org.apache.log4j.RollingFileAppender
log4j.appender.warnLevel.File =${r"${project.projectName}.root"}/logs/warn/warnlog.txt
log4j.appender.warnLevel.MaxFileSize = 5MB
log4j.appender.warnLevel.MaxBackupIndex = 1000
log4j.appender.warnLevel.Threshold = WARN
log4j.appender.warnLevel.layout = org.apache.log4j.PatternLayout
log4j.appender.warnLevel.layout.ConversionPattern=%-d{yyyy-MM-dd HH:mm:ss} [%c]-[%p] - %m%n

#errorLevel
log4j.appender.errorLevel = org.apache.log4j.RollingFileAppender
log4j.appender.errorLevel.File =${r"${project.projectName}.root"}/logs/error/errorlog.txt
log4j.appender.errorLevel.MaxFileSize = 5MB
log4j.appender.errorLevel.MaxBackupIndex = 1000
log4j.appender.errorLevel.Threshold = ERROR
log4j.appender.errorLevel.layout = org.apache.log4j.PatternLayout
log4j.appender.errorLevel.layout.ConversionPattern=%-d{yyyy-MM-dd HH:mm:ss} [%c]-[%p] - %m%n
log4j.appender.errorLevel.layout.Target=System.err

#allLevel
log4j.appender.allLevel = org.apache.log4j.RollingFileAppender
log4j.appender.allLevel.File =${r"${project.projectName}.root"}/logs/all/alllog.txt
log4j.appender.allLevel.MaxFileSize = 10MB
log4j.appender.allLevel.MaxBackupIndex = 1000
log4j.appender.allLevel.layout = org.apache.log4j.PatternLayout
log4j.appender.allLevel.layout.ConversionPattern=%-d{yyyy-MM-dd HH\:mm\:ss} [%c]-[%p] - %m%n