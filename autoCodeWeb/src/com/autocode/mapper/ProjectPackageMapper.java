package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.ProjectPackage;

public abstract interface ProjectPackageMapper extends BaseMapper<ProjectPackage> {
	public abstract ProjectPackage querySingleObjectByPackageName(String paramString);
	public abstract Integer deleteObjectByProjectId(Integer paramInteger);
}
