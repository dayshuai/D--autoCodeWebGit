package com.autocode.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Project;
import com.autocode.service.ProjectService;
import com.autocode.util.CheckDatabase;

@Controller
@RequestMapping({ "/project" })
public class ProjectController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ProjectController.class);

	@Inject
	private ProjectService projectService;

	@Autowired
	@Qualifier("taskExecutor")
	private TaskExecutor taskExecutor;
	


	@RequestMapping
	public String project(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("project", "focus");
		return "project";
	}

	@ResponseBody
	@RequestMapping({ "insertProject" })
	public Map<String, Object> insertProject(Model model, Project project) {
		try {
			this.projectService.insertProject(project);
		} catch (Exception e) {
			LOG.error("ProjectController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateProject" })
	public Map<String, Object> updateProject(Model model, Project project) {
		try {
			this.projectService.updateProject(project);
		} catch (Exception e) {
			LOG.error("ProjectController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProject" })
	public Map<String, Object> deleteProject(Model model, Integer projectId) {
		try {
			this.projectService.deleteProject(projectId);
		} catch (Exception e) {
			LOG.error("ProjectController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProjects" })
	public Map<String, Object> deleteProjects(Model model, String ids) {
		try {
			this.projectService.deleteProjects(ids);
		} catch (Exception e) {
			LOG.error("ProjectController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryProjectList" })
	public Pagination<Project> queryProjectList(Model model, Project project) {
		try {
			Integer totalCount = this.projectService.queryProjectCount(project);
			List <Project> dataList = this.projectService.queryProjectList(project);
			return new Pagination<Project>(project, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ProjectController[查询列表失败]");
		}
		return new Pagination<Project>("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "chackDatabase" })
	public Map<String, Object> chackDatabase(Model model, Integer projectId) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("请刷新表格后重试!");
			}
			if (project.getIsValidation().equals("YES")) {
				return resultTrue();
			}
			if (!CheckDatabase.checkDatabase(project.getDatabaseName(), project.getDatabaseType(),
					project.getDatabaseIp(), project.getDatabasePort(), project.getDatabaseUser(),
					project.getDatabasePwd())) {
				return resultFalse("验证失败,请确认数据库信息正确性!");
			}
			project.setIsValidation("YES");
			this.projectService.updateProject(project);
		} catch (Exception e) {
			LOG.error("ProjectController[验证数据库信息失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "projectSelect" })
	public Map<String, Object> projectSelect(Model model) {
		try {
			List <String> list = this.projectService.queryProjectListByIsValidation();
			if (list == null) {
				return resultTrue(new ArrayList <String> ());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("ProjectController[查询引用项目列表失败]");
		}
		return resultFalse("查询引用项目列表失败!");
	}

}
