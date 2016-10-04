package com.autocode.bean;

import com.autocode.base.BaseBean;
import java.io.Serializable;

public class ProjectPackage extends BaseBean implements Serializable {
	private Integer projectPackageId;
	private Integer projectId;
	private String projectName;
	private String packageName;
	private String packagePath;
	private String memo;

	public ProjectPackage() {
	}

	public ProjectPackage(Integer projectId, String packageName, String packagePath, String memo) {
		this.projectId = projectId;
		this.packageName = packageName;
		this.packagePath = packagePath;
		this.memo = memo;
	}

	public void setProjectPackageId(Integer projectPackageId) {
		this.projectPackageId = projectPackageId;
	}

	public Integer getProjectPackageId() {
		return this.projectPackageId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getProjectId() {
		return this.projectId;
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

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String toString() {
		return "ProjectPackage[ projectPackageId=" + this.projectPackageId + ", projectId=" + this.projectId
				+ ", packageName=" + this.packageName + ", packagePath=" + this.packagePath + ", memo=" + this.memo
				+ " ]";
	}
}
