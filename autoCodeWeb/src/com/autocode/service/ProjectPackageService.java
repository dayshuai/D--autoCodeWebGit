package com.autocode.service;

import com.autocode.bean.ProjectPackage;
import java.util.List;

public abstract interface ProjectPackageService {
	public abstract Integer insertProjectPackage(ProjectPackage paramProjectPackage);

	public abstract Integer updateProjectPackage(ProjectPackage paramProjectPackage);

	public abstract Integer deleteProjectPackage(Integer paramInteger);

	public abstract void deleteProjectPackages(String paramString);

	public abstract ProjectPackage querySingleProjectPackage(Integer paramInteger);

	public abstract Integer queryProjectPackageCount(ProjectPackage paramProjectPackage);

	public abstract List<ProjectPackage> queryProjectPackageList(ProjectPackage paramProjectPackage);

	public abstract List<ProjectPackage> queryProjectPackageSelect();

	public abstract Integer replaceProjectPackage(Integer paramInteger, String paramString1, String paramString2);

	public abstract Integer deleteProjectPackageByProjectId(Integer paramInteger);

	public abstract List<ProjectPackage> queryProjectPackageListByProjectId(Integer paramInteger);
}

/*
 * Location: C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\ Qualified
 * Name: com.autocode.service.ProjectPackageService JD-Core Version: 0.6.2
 */