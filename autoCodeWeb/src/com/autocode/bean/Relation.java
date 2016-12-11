package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class Relation extends BaseBean implements Serializable {
	private Integer relationId;
	private Integer projectId;
	private Integer tableId;
	private Integer columnId;
	private String relation;
	private Integer relationTableId;
	private Integer relationColumnId;
	private Integer relationShowColumnId;
	private String cascadeDelete;
	private String projectName;
	private String tableName;
	private String tableMappingName;
	private String columnName;
	private String columnMappingName;
	private String relationTableName;
	private String relationTableMappingName;
	private String relationColumnType;
	private String relationColumnName;
	private String relationColumnMappingName;
	private String relationShowColumnName;
	private String relationShowMappingName;
	private String relationShowColumnZhName;

	public Relation() {
	}

	public Relation(Integer projectId, Integer tableId, Integer columnId, String relation, Integer relationTableId,
			Integer relationColumnId, Integer relationShowColumnId, String cascadeDelete) {
		this.projectId = projectId;
		this.tableId = tableId;
		this.columnId = columnId;
		this.relation = relation;
		this.relationTableId = relationTableId;
		this.relationColumnId = relationColumnId;
		this.relationShowColumnId = relationShowColumnId;
		this.cascadeDelete = cascadeDelete;
	}

	public void setRelationId(Integer relationId) {
		this.relationId = relationId;
	}

	public Integer getRelationId() {
		return this.relationId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getProjectId() {
		return this.projectId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Integer getTableId() {
		return this.tableId;
	}

	public Integer getColumnId() {
		return this.columnId;
	}

	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public String getRelation() {
		return this.relation;
	}

	public Integer getRelationTableId() {
		return this.relationTableId;
	}

	public void setRelationTableId(Integer relationTableId) {
		this.relationTableId = relationTableId;
	}

	public Integer getRelationColumnId() {
		return this.relationColumnId;
	}

	public void setRelationColumnId(Integer relationColumnId) {
		this.relationColumnId = relationColumnId;
	}

	public Integer getRelationShowColumnId() {
		return this.relationShowColumnId;
	}

	public void setRelationShowColumnId(Integer relationShowColumnId) {
		this.relationShowColumnId = relationShowColumnId;
	}

	public void setCascadeDelete(String cascadeDelete) {
		this.cascadeDelete = cascadeDelete;
	}

	public String getCascadeDelete() {
		return this.cascadeDelete;
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

	public String getColumnName() {
		return this.columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getRelationTableName() {
		return this.relationTableName;
	}

	public void setRelationTableName(String relationTableName) {
		this.relationTableName = relationTableName;
	}

	public String getRelationColumnName() {
		return this.relationColumnName;
	}

	public void setRelationColumnName(String relationColumnName) {
		this.relationColumnName = relationColumnName;
	}

	public String getRelationColumnType() {
		return this.relationColumnType;
	}

	public void setRelationColumnType(String relationColumnType) {
		this.relationColumnType = relationColumnType;
	}

	public String getRelationShowColumnName() {
		return this.relationShowColumnName;
	}

	public void setRelationShowColumnName(String relationShowColumnName) {
		this.relationShowColumnName = relationShowColumnName;
	}

	public String getTableMappingName() {
		return this.tableMappingName;
	}

	public void setTableMappingName(String tableMappingName) {
		this.tableMappingName = tableMappingName;
	}

	public String getColumnMappingName() {
		return this.columnMappingName;
	}

	public void setColumnMappingName(String columnMappingName) {
		this.columnMappingName = columnMappingName;
	}

	public String getRelationTableMappingName() {
		return this.relationTableMappingName;
	}

	public void setRelationTableMappingName(String relationTableMappingName) {
		this.relationTableMappingName = relationTableMappingName;
	}

	public String getRelationShowMappingName() {
		return this.relationShowMappingName;
	}

	public void setRelationShowMappingName(String relationShowMappingName) {
		this.relationShowMappingName = relationShowMappingName;
	}

	public String getRelationColumnMappingName() {
		return this.relationColumnMappingName;
	}

	public void setRelationColumnMappingName(String relationColumnMappingName) {
		this.relationColumnMappingName = relationColumnMappingName;
	}

	public String getRelationShowColumnZhName() {
		return this.relationShowColumnZhName;
	}

	public void setRelationShowColumnZhName(String relationShowColumnZhName) {
		this.relationShowColumnZhName = relationShowColumnZhName;
	}

	public String toString() {
		return "Relation[ relationId=" + this.relationId + ", projectId=" + this.projectId + ", tableId=" + this.tableId
				+ ", relation=" + this.relation + ", relationTableId=" + this.relationTableId + ", relationColumnId="
				+ this.relationColumnId + ", relationShowColumnId=" + this.relationShowColumnId + ", cascadeDelete="
				+ this.cascadeDelete + " ]";
	}
}
