package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class Column extends BaseBean implements Serializable {
	private Integer columnId;
	private Integer projectId;
	private Integer tableId;
	private String mappingName;
	private String columnName;
	private String columnZhName;
	private String mappingType;
	private String columnType;
	private String showType;
	private String isPrimary;
	private String isUpdate;
	private String isDefault;
	private String isRepeat;
	private String isShow;
	private String isQuery;
	private String isImportPackage;
	private String isCheck;
	private Integer showOrder;
	private String tableName;
	private String projectName;
	private String importPackageName;
	private String isForeign = "NO";
	private String foreignTableName;

	public Column() {
	}

	public Column(Integer projectId, Integer tableId, String mappingName, String columnName, String columnZhName,
			String mappingType, String columnType, String showType, String isPrimary, String isUpdate, String isDefault,
			String isRepeat, String isShow, String isQuery, String isImportPackage, String isCheck, Integer showOrder) {
		this.projectId = projectId;
		this.tableId = tableId;
		this.mappingName = mappingName;
		this.columnName = columnName;
		this.columnZhName = columnZhName;
		this.mappingType = mappingType;
		this.columnType = columnType;
		this.showType = showType;
		this.isPrimary = isPrimary;
		this.isUpdate = isUpdate;
		this.isDefault = isDefault;
		this.isRepeat = isRepeat;
		this.isShow = isShow;
		this.isQuery = isQuery;
		this.isImportPackage = isImportPackage;
		this.isCheck = isCheck;
		this.showOrder = showOrder;
	}

	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	public Integer getColumnId() {
		return this.columnId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Integer getTableId() {
		return this.tableId;
	}

	public void setMappingName(String mappingName) {
		this.mappingName = mappingName;
	}

	public String getMappingName() {
		return this.mappingName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnName() {
		return this.columnName;
	}

	public void setColumnZhName(String columnZhName) {
		this.columnZhName = columnZhName;
	}

	public String getColumnZhName() {
		return this.columnZhName;
	}

	public String getMappingType() {
		return this.mappingType;
	}

	public void setMappingType(String mappingType) {
		this.mappingType = mappingType;
	}

	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}

	public String getColumnType() {
		return this.columnType;
	}

	public void setShowType(String showType) {
		this.showType = showType;
	}

	public String getShowType() {
		return this.showType;
	}

	public void setIsPrimary(String isPrimary) {
		this.isPrimary = isPrimary;
	}

	public String getIsPrimary() {
		return this.isPrimary;
	}

	public void setIsUpdate(String isUpdate) {
		this.isUpdate = isUpdate;
	}

	public String getIsUpdate() {
		return this.isUpdate;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getIsDefault() {
		return this.isDefault;
	}

	public void setIsRepeat(String isRepeat) {
		this.isRepeat = isRepeat;
	}

	public String getIsRepeat() {
		return this.isRepeat;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsShow() {
		return this.isShow;
	}

	public void setIsQuery(String isQuery) {
		this.isQuery = isQuery;
	}

	public String getIsQuery() {
		return this.isQuery;
	}

	public void setIsImportPackage(String isImportPackage) {
		this.isImportPackage = isImportPackage;
	}

	public String getIsImportPackage() {
		return this.isImportPackage;
	}

	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}

	public String getIsCheck() {
		return this.isCheck;
	}

	public void setShowOrder(Integer showOrder) {
		this.showOrder = showOrder;
	}

	public Integer getShowOrder() {
		return this.showOrder;
	}

	public Integer getProjectId() {
		return this.projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getImportPackageName() {
		return this.importPackageName;
	}

	public void setImportPackageName(String importPackageName) {
		this.importPackageName = importPackageName;
	}

	public String getIsForeign() {
		return this.isForeign;
	}

	public void setIsForeign(String isForeign) {
		this.isForeign = isForeign;
	}

	public String getForeignTableName() {
		return this.foreignTableName;
	}

	public void setForeignTableName(String foreignTableName) {
		this.foreignTableName = foreignTableName;
	}

	public String toString() {
		return "Column[ columnId=" + this.columnId + ",projectId=" + this.projectId + ", tableId=" + this.tableId
				+ ", mappingName=" + this.mappingName + ", columnName=" + this.columnName + ", columnZhName="
				+ this.columnZhName + ", columnType=" + this.columnType + ", showType=" + this.showType + ", isPrimary="
				+ this.isPrimary + ", isUpdate=" + this.isUpdate + ", isDefault=" + this.isDefault + ", isRepeat="
				+ this.isRepeat + ", isShow=" + this.isShow + ", isQuery=" + this.isQuery + ", isImportPackage="
				+ this.isImportPackage + ", isCheck=" + this.isCheck + ", showOrder=" + this.showOrder + " ]";
	}
}
