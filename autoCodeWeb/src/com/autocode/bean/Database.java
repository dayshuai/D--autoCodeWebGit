package com.autocode.bean;

public class Database {

	/** 数据库库IP地址 */
	private String databaseIp;
	/** 数据库库端口 */
	private Integer databasePort;
	/** 数据库库名称 */
	private String databaseName;
	/** 数据库库用户名 */
	private String databaseUser;
	/** 数据库库密码 */
	private String databasePwd;
	
	public Database(){
		
	}
	
	public Database(String databaseIp,Integer databasePort,String databaseName,String databaseUser,String databasePwd){
		this.databaseIp=databaseIp;
		this.databasePort=databasePort;
		this.databaseName=databaseName;
		this.databaseUser=databaseUser;
		this.databasePwd=databasePwd;
	}
	
	public String getDatabaseIp() {
		return databaseIp;
	}
	public void setDatabaseIp(String databaseIp) {
		this.databaseIp = databaseIp;
	}
	public Integer getDatabasePort() {
		return databasePort;
	}
	public void setDatabasePort(Integer databasePort) {
		this.databasePort = databasePort;
	}
	public String getDatabaseName() {
		return databaseName;
	}
	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}
	public String getDatabaseUser() {
		return databaseUser;
	}
	public void setDatabaseUser(String databaseUser) {
		this.databaseUser = databaseUser;
	}
	public String getDatabasePwd() {
		return databasePwd;
	}
	public void setDatabasePwd(String databasePwd) {
		this.databasePwd = databasePwd;
	}
}
