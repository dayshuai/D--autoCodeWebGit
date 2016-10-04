package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class PackageConvert extends BaseBean implements Serializable {
	private Integer packageConvertId;
	private String className;
	private String packageName;

	public PackageConvert() {
	}

	public PackageConvert(String className, String packageName) {
		this.className = className;
		this.packageName = packageName;
	}

	public void setPackageConvertId(Integer packageConvertId) {
		this.packageConvertId = packageConvertId;
	}

	public Integer getPackageConvertId() {
		return this.packageConvertId;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getClassName() {
		return this.className;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getPackageName() {
		return this.packageName;
	}

	public String toString() {
		return "PackageConvert[ packageConvertId=" + this.packageConvertId + ", className=" + this.className
				+ ", packageName=" + this.packageName + " ]";
	}
}
