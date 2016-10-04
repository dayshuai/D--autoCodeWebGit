package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class TemplateConfig extends BaseBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer templateConfigId;
	private Integer templateId;
	private String templateName;
	private String configType;
	private String configName;
	private String configValue;
	private String isAssignPath;
	private String savePath;
	private String produceName;

	public TemplateConfig() {
	}

	public TemplateConfig(Integer templateId, String configType, String configName, String configValue,
			String isAssignPath, String savePath, String produceName) {
		this.configType = configType;
		this.templateId = templateId;
		this.configName = configName;
		this.configValue = configValue;
		this.isAssignPath = isAssignPath;
		this.savePath = savePath;
		this.produceName = produceName;
	}

	public void setTemplateConfigId(Integer templateConfigId) {
		this.templateConfigId = templateConfigId;
	}

	public Integer getTemplateConfigId() {
		return this.templateConfigId;
	}

	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}

	public Integer getTemplateId() {
		return this.templateId;
	}

	public String getConfigType() {
		return this.configType;
	}

	public void setConfigType(String configType) {
		this.configType = configType;
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

	public void setProduceName(String produceName) {
		this.produceName = produceName;
	}

	public String getProduceName() {
		return this.produceName;
	}

	public String getTemplateName() {
		return this.templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getIsAssignPath() {
		return this.isAssignPath;
	}

	public void setIsAssignPath(String isAssignPath) {
		this.isAssignPath = isAssignPath;
	}

	public String getSavePath() {
		return this.savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String toString() {
		return "TemplateConfig[ templateConfigId=" + this.templateConfigId + ", templateId=" + this.templateId
				+ ", configName=" + this.configName + ", configValue=" + this.configValue + ", produceName="
				+ this.produceName + " ]";
	}
}
