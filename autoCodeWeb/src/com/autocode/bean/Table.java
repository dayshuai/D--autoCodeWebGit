package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;
import java.util.List;

public class Table extends BaseBean implements Serializable {
	private Integer tableId;
	private Integer projectId;
	private String tableTitle;
	private String mappingName;
	private String tableName;
	private String validationDelete;
	private String tableMemo;
	private Integer countColumn;
	private String projectName;
	private List<Column> columnList;
	private String relactionName;

	public Table() {
	}

	public Table(Integer projectId, String tableTitle, String mappingName, String tableName, String validationDelete,
			String tableMemo) {
		this.projectId = projectId;
		this.tableTitle = tableTitle;
		this.mappingName = mappingName;
		this.tableName = firstToUpper(tableName);
		this.validationDelete = validationDelete;
		this.tableMemo = tableMemo;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Integer getTableId() {
		return this.tableId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getProjectId() {
		return this.projectId;
	}

	public void setTableTitle(String tableTitle) {
		this.tableTitle = tableTitle;
	}

	public String getTableTitle() {
		return this.tableTitle;
	}

	public void setMappingName(String mappingName) {
		this.mappingName = mappingName;
	}

	public String getMappingName() {
		return this.mappingName;
	}

	public void setTableName(String tableName) {
		this.tableName = firstToUpper(tableName);
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setValidationDelete(String validationDelete) {
		this.validationDelete = validationDelete;
	}

	public String getValidationDelete() {
		return this.validationDelete;
	}

	public void setTableMemo(String tableMemo) {
		this.tableMemo = tableMemo;
	}

	public String getTableMemo() {
		return this.tableMemo;
	}

	public Integer getCountColumn() {
		return this.countColumn;
	}

	public void setCountColumn(Integer countColumn) {
		this.countColumn = countColumn;
	}

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public List<Column> getColumnList() {
		return this.columnList;
	}

	public void setColumnList(List<Column> columnList) {
		this.columnList = columnList;
	}

	public String getRelactionName() {
		return this.relactionName;
	}

	public void setRelactionName(String relactionName) {
		this.relactionName = relactionName;
	}

	public String toString() {
		return "Table[ tableId=" + this.tableId + ", projectId=" + this.projectId + ", tableTitle=" + this.tableTitle
				+ ", mappingName=" + this.mappingName + ", tableName=" + this.tableName + ", validationDelete="
				+ this.validationDelete + ", tableMemo=" + this.tableMemo + " ]";
	}

	public String firstToUpper(String str) {
		if ((str == null) || (str.equals(""))) {
			return "";
		}
		return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1, str.length());
	}
}
