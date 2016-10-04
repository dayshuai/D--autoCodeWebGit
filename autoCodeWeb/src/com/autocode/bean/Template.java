package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class Template extends BaseBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer templateId;
	private String templateTitle;
	private String templateName;
	private String applyFrame;
	private String isValidation;
	private String imageUrl;
	private String memo;

	public Template() {
	}

	public Template(String templateTitle, String templateName, String applyFrame, String isValidation, String imageUrl,
			String memo) {
		this.templateTitle = templateTitle;
		this.templateName = templateName;
		this.applyFrame = applyFrame;
		this.isValidation = isValidation;
		this.imageUrl = imageUrl;
		this.memo = memo;
	}

	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}

	public Integer getTemplateId() {
		return this.templateId;
	}

	public void setTemplateTitle(String templateTitle) {
		this.templateTitle = templateTitle;
	}

	public String getTemplateTitle() {
		return this.templateTitle;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getTemplateName() {
		return this.templateName;
	}

	public void setApplyFrame(String applyFrame) {
		this.applyFrame = applyFrame;
	}

	public String getApplyFrame() {
		return this.applyFrame;
	}

	public void setIsValidation(String isValidation) {
		this.isValidation = isValidation;
	}

	public String getIsValidation() {
		return this.isValidation;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getImageUrl() {
		return this.imageUrl;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMemo() {
		return this.memo;
	}

	public String toString() {
		return "Template[ templateId=" + this.templateId + ", templateTitle=" + this.templateTitle + ", templateName="
				+ this.templateName + ", applyFrame=" + this.applyFrame + ", isValidation=" + this.isValidation
				+ ", imageUrl=" + this.imageUrl + ", memo=" + this.memo + " ]";
	}
}
