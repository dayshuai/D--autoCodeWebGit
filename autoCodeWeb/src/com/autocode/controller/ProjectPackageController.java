package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.ProjectPackage;
import com.autocode.service.ProjectPackageService;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({ "/projectPackage" })
public class ProjectPackageController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ProjectPackageController.class);

	@Inject
	private ProjectPackageService projectPackageService;

	@RequestMapping
	public String projectPackage(Model model) {
		model.addAttribute("nav_2", "onnav");
		model.addAttribute("projectPackage", "focus");
		return "projectPackage";
	}

	@ResponseBody
	@RequestMapping({ "insertProjectPackage" })
	public Map<String, Object> insertProjectPackage(Model model, ProjectPackage projectPackage) {
		try {
			this.projectPackageService.insertProjectPackage(projectPackage);
		} catch (Exception e) {
			LOG.error("ProjectPackageController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateProjectPackage" })
	public Map<String, Object> updateProjectPackage(Model model, ProjectPackage projectPackage) {
		try {
			this.projectPackageService.updateProjectPackage(projectPackage);
		} catch (Exception e) {
			LOG.error("ProjectPackageController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProjectPackage" })
	public Map<String, Object> deleteProjectPackage(Model model, Integer projectPackageId) {
		try {
			this.projectPackageService.deleteProjectPackage(projectPackageId);
		} catch (Exception e) {
			LOG.error("ProjectPackageController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProjectPackages" })
	public Map<String, Object> deleteProjectPackages(Model model, String ids) {
		try {
			this.projectPackageService.deleteProjectPackages(ids);
		} catch (Exception e) {
			LOG.error("ProjectPackageController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryProjectPackageList" })
	public Pagination<ProjectPackage> queryProjectPackageList(Model model, ProjectPackage projectPackage) {
		try {
			Integer totalCount = this.projectPackageService.queryProjectPackageCount(projectPackage);
			List <ProjectPackage> dataList = this.projectPackageService.queryProjectPackageList(projectPackage);
			return new Pagination<ProjectPackage>(projectPackage, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ProjectPackageController[查询列表失败]");
		}
		return new Pagination<ProjectPackage>("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "replaceProjectPackage" })
	public Map<String, Object> replaceProjectPackage(Model model, Integer projectId, String sourceName,
			String replaceName) {
		try {
			this.projectPackageService.replaceProjectPackage(projectId, sourceName, replaceName);
		} catch (Exception e) {
			LOG.error("ProjectPackageController[一键替换失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}
}
