package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class DatabaseConvert extends BaseBean implements Serializable {
	private Integer databaseConvertId;
	private String columnType;
	private String convertType;
	private String databaseType;

	public DatabaseConvert() {
	}

	public DatabaseConvert(String columnType, String convertType, String databaseType) {
		this.columnType = columnType;
		this.convertType = convertType;
		this.databaseType = databaseType;
	}

	public void setDatabaseConvertId(Integer databaseConvertId) {
		this.databaseConvertId = databaseConvertId;
	}

	public Integer getDatabaseConvertId() {
		return this.databaseConvertId;
	}

	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}

	public String getColumnType() {
		return this.columnType;
	}

	public void setConvertType(String convertType) {
		this.convertType = convertType;
	}

	public String getConvertType() {
		return this.convertType;
	}

	public void setDatabaseType(String databaseType) {
		this.databaseType = databaseType;
	}

	public String getDatabaseType() {
		return this.databaseType;
	}

	public String toString() {
		return "DatabaseConvert[ databaseConvertId=" + this.databaseConvertId + ", columnType=" + this.columnType
				+ ", convertType=" + this.convertType + ", databaseType=" + this.databaseType + " ]";
	}
}
