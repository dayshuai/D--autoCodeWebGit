package com.autocode.service;

import java.util.List;

import com.autocode.bean.Project;

public abstract interface ProjectService {
	public abstract Integer insertProject(Project paramProject);

	public abstract Integer updateProject(Project paramProject);

	public abstract Integer deleteProject(Integer paramInteger);

	public abstract void deleteProjects(String paramString);

	public abstract Project querySingleProject(Integer paramInteger);

	public abstract Integer queryProjectCount(Project paramProject);

	public abstract List<Project> queryProjectList(Project paramProject);

	public abstract List<String> queryProjectListByIsValidation();

}
