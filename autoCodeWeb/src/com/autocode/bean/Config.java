package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class Config extends BaseBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer configId;
	private String configName;
	private String configValue;
	private String memo;

	public Config() {
	}

	public Config(String configName, String configValue, String memo) {
		this.configName = configName;
		this.configValue = configValue;
		this.memo = memo;
	}

	public void setConfigId(Integer configId) {
		this.configId = configId;
	}

	public Integer getConfigId() {
		return this.configId;
	}

	public void setConfigName(String configName) {
		this.configName = configName;
	}

	public String getConfigName() {
		return this.configName;
	}

	public void setConfigValue(String configValue) {
		this.configValue = configValue;
	}

	public String getConfigValue() {
		return this.configValue;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMemo() {
		return this.memo;
	}

	public String toString() {
		return "Config[ configId=" + this.configId + ", configName=" + this.configName + ", configValue="
				+ this.configValue + ", memo=" + this.memo + " ]";
	}
}
