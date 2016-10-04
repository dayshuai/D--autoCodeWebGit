package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class ColumnConvert extends BaseBean implements Serializable {
	private Integer columnConvertId;
	private String mappingName;
	private String columnName;
	private String columnZhName;

	public ColumnConvert() {
	}

	public ColumnConvert(String mappingName, String columnName, String columnZhName) {
		this.mappingName = mappingName;
		this.columnName = columnName;
		this.columnZhName = columnZhName;
	}

	public void setColumnConvertId(Integer columnConvertId) {
		this.columnConvertId = columnConvertId;
	}

	public Integer getColumnConvertId() {
		return this.columnConvertId;
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

	public String toString() {
		return "ColumnConvert[ columnConvertId=" + this.columnConvertId + ", mappingName=" + this.mappingName
				+ ", columnName=" + this.columnName + ", columnZhName=" + this.columnZhName + " ]";
	}
}
