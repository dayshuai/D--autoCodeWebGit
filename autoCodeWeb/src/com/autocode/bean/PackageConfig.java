package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class PackageConfig extends BaseBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer packageConfigId;
	private String applyFrame;
	private String packageName;
	private String packagePath;
	private String memo;

	public PackageConfig() {
	}

	public PackageConfig(String applyFrame, String packageName, String packagePath, String memo) {
		this.applyFrame = applyFrame;
		this.packageName = packageName;
		this.packagePath = packagePath;
		this.memo = memo;
	}

	public void setPackageConfigId(Integer packageConfigId) {
		this.packageConfigId = packageConfigId;
	}

	public Integer getPackageConfigId() {
		return this.packageConfigId;
	}

	public String getApplyFrame() {
		return this.applyFrame;
	}

	public void setApplyFrame(String applyFrame) {
		this.applyFrame = applyFrame;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getPackageName() {
		return this.packageName;
	}

	public void setPackagePath(String packagePath) {
		this.packagePath = packagePath;
	}

	public String getPackagePath() {
		return this.packagePath;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMemo() {
		return this.memo;
	}

	public String toString() {
		return "PackageConfig[ applyFrame=" + this.applyFrame + ", packageConfigId=" + this.packageConfigId
				+ ", packageName=" + this.packageName + ", packagePath=" + this.packagePath + ", memo=" + this.memo
				+ " ]";
	}
}
