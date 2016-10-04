package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class Control extends BaseBean implements Serializable {
	private Integer controlId;
	private Integer projectId;
	private Integer tableId;
	private String isInsertMethod;
	private String isUpdateMethod;
	private String isDeleteMethod;
	private String isQueryMethod;
	private String isSelectMethod;
	private String projectName;
	private String tableName;

	public Control() {
	}

	public Control(Integer projectId, Integer tableId, String isInsertMethod, String isUpdateMethod,
			String isDeleteMethod, String isQueryMethod, String isSelectMethod) {
		this.projectId = projectId;
		this.tableId = tableId;
		this.isInsertMethod = isInsertMethod;
		this.isUpdateMethod = isUpdateMethod;
		this.isDeleteMethod = isDeleteMethod;
		this.isQueryMethod = isQueryMethod;
		this.isSelectMethod = isSelectMethod;
	}

	public Integer getProjectId() {
		return this.projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public void setControlId(Integer controlId) {
		this.controlId = controlId;
	}

	public Integer getControlId() {
		return this.controlId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Integer getTableId() {
		return this.tableId;
	}

	public void setIsInsertMethod(String isInsertMethod) {
		this.isInsertMethod = isInsertMethod;
	}

	public String getIsInsertMethod() {
		return this.isInsertMethod;
	}

	public void setIsUpdateMethod(String isUpdateMethod) {
		this.isUpdateMethod = isUpdateMethod;
	}

	public String getIsUpdateMethod() {
		return this.isUpdateMethod;
	}

	public void setIsDeleteMethod(String isDeleteMethod) {
		this.isDeleteMethod = isDeleteMethod;
	}

	public String getIsDeleteMethod() {
		return this.isDeleteMethod;
	}

	public void setIsQueryMethod(String isQueryMethod) {
		this.isQueryMethod = isQueryMethod;
	}

	public String getIsQueryMethod() {
		return this.isQueryMethod;
	}

	public void setIsSelectMethod(String isSelectMethod) {
		this.isSelectMethod = isSelectMethod;
	}

	public String getIsSelectMethod() {
		return this.isSelectMethod;
	}

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String toString() {
		return "Control[ controlId=" + this.controlId + ",projectId=" + this.projectId + ", tableId=" + this.tableId
				+ ", isInsertMethod=" + this.isInsertMethod + ", isUpdateMethod=" + this.isUpdateMethod
				+ ", isDeleteMethod=" + this.isDeleteMethod + ", isQueryMethod=" + this.isQueryMethod
				+ ", isSelectMethod=" + this.isSelectMethod + " ]";
	}
}
