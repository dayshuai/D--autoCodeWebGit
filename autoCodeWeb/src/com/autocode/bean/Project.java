package com.autocode.bean;

import com.autocode.base.BaseBean;
import com.autocode.util.DateTimeSerializer;
import java.io.Serializable;
import java.util.Date;
import org.codehaus.jackson.map.annotate.JsonSerialize;

public class Project extends BaseBean implements Serializable {
	private Integer projectId;
	private String projectTitle;
	private String projectName;
	private String projectFrame;
	private String requestPostfix;
	private String databaseName;
	private String databaseType;
	private String databaseIp;
	private Integer databasePort;
	private String databaseUser;
	private String databasePwd;
	private Date createDate;
	private String isDefault;
	private String isValidation;

	public Project() {
	}

	public Project(String projectTitle, String projectName, String projectFrame, String requestPostfix,
			String databaseName, String databaseType, String databaseIp, Integer databasePort, String databaseUser,
			String databasePwd, Date createDate, String isDefault, String isValidation) {
		this.projectTitle = projectTitle;
		this.projectName = projectName;
		this.projectFrame = projectFrame;
		this.isValidation = isValidation;
		this.requestPostfix = requestPostfix;
		this.databaseName = databaseName;
		this.databaseType = databaseType;
		this.databaseIp = databaseIp;
		this.databasePort = databasePort;
		this.databaseUser = databaseUser;
		this.databasePwd = databasePwd;
		this.createDate = createDate;
		this.isDefault = isDefault;
	}

	public Integer getProjectId() {
		return this.projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public String getProjectTitle() {
		return this.projectTitle;
	}

	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectFrame() {
		return this.projectFrame;
	}

	public void setProjectFrame(String projectFrame) {
		this.projectFrame = projectFrame;
	}

	public String getRequestPostfix() {
		return this.requestPostfix;
	}

	public void setRequestPostfix(String requestPostfix) {
		this.requestPostfix = requestPostfix;
	}

	public String getDatabaseName() {
		return this.databaseName;
	}

	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}

	public String getDatabaseType() {
		return this.databaseType;
	}

	public void setDatabaseType(String databaseType) {
		this.databaseType = databaseType;
	}

	public String getDatabaseIp() {
		return this.databaseIp;
	}

	public void setDatabaseIp(String databaseIp) {
		this.databaseIp = databaseIp;
	}

	public Integer getDatabasePort() {
		return this.databasePort;
	}

	public void setDatabasePort(Integer databasePort) {
		this.databasePort = databasePort;
	}

	public String getDatabaseUser() {
		return this.databaseUser;
	}

	public void setDatabaseUser(String databaseUser) {
		this.databaseUser = databaseUser;
	}

	public String getDatabasePwd() {
		return this.databasePwd;
	}

	public void setDatabasePwd(String databasePwd) {
		this.databasePwd = databasePwd;
	}

	public String getIsValidation() {
		return this.isValidation;
	}

	public void setIsValidation(String isValidation) {
		this.isValidation = isValidation;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonSerialize(using = DateTimeSerializer.class)
	public Date getCreateDate() {
		return this.createDate;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getIsDefault() {
		return this.isDefault;
	}

	public String toString() {
		return "Project[ projectId=" + this.projectId + ", projectTitle=" + this.projectTitle + ", projectName="
				+ this.projectName + ", projectFrame=" + this.projectFrame + ", requestPostfix=" + this.requestPostfix
				+ ", databaseName=" + this.databaseName + ", databaseType=" + this.databaseType + ", databaseIP="
				+ this.databaseIp + ", databasePort=" + this.databasePort + ", databaseUser=" + this.databaseUser
				+ ", databasePwd=" + this.databasePwd + ", createDate=" + this.createDate + ", isDefault="
				+ this.isDefault + ", isValidation=" + this.isValidation + " ]";
	}
}
