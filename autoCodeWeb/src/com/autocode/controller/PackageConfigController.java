package com.autocode.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.PackageConfig;
import com.autocode.bean.Template;
import com.autocode.service.PackageConfigService;
import com.autocode.service.TemplateService;

@Controller
@RequestMapping({ "/packageConfig" })
public class PackageConfigController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(PackageConfigController.class);

	@Inject
	private PackageConfigService packageConfigService;

	@Autowired
	private TemplateService templateService;

	@RequestMapping
	public String index(Model model) {
		model.addAttribute("nav_3", "onnav");
		model.addAttribute("packageConfig", "focus");
		return "packageConfig";
	}

	@ResponseBody
	@RequestMapping({ "insertPackageConfig" })
	public Map<String, Object> insertPackageConfig(Model model, PackageConfig packageConfig) {
		try {
			this.packageConfigService.insertPackageConfig(packageConfig);
		} catch (Exception e) {
			LOG.error("PackageConfigController[添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updatePackageConfig" })
	public Map<String, Object> updatePackageConfig(Model model, PackageConfig packageConfig) {
		try {
			this.packageConfigService.updatePackageConfig(packageConfig);
		} catch (Exception e) {
			LOG.error("PackageConfigController[修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deletePackageConfig" })
	public Map<String, Object> deletePackageConfig(Model model, Integer packageConfigId) {
		try {
			this.packageConfigService.deletePackageConfig(packageConfigId);
		} catch (Exception e) {
			LOG.error("PackageConfigController[删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deletePackageConfigs" })
	public Map<String, Object> deletePackageConfigs(Model model, String ids) {
		try {
			this.packageConfigService.deletePackageConfigs(ids);
		} catch (Exception e) {
			LOG.error("PackageConfigController[删除多个失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryPackageConfigList" })
	public Pagination<PackageConfig> queryPackageConfigList(Model model, PackageConfig packageConfig) {
		try {
			Integer totalCount = this.packageConfigService.queryPackageConfigCount(packageConfig);
			List <PackageConfig> dataList = this.packageConfigService.queryPackageConfigList(packageConfig);
			return new Pagination<PackageConfig>(packageConfig, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("PackageConfigController[查询列表失败]", e);
		}
		return new Pagination<PackageConfig>("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "packageConfigSelect" })
	public Map<String, Object> packageConfigSelect(Model model, Integer templateId) {
		try {
			Template template = this.templateService.querySingleTemplate(templateId);
			List <String> list = this.packageConfigService.queryPackageConfigSelectByApplyFrame(template.getApplyFrame());
			if (list == null) {
				return resultTrue(new ArrayList<String>());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("ProjectController[查询引用包列表失败]");
		}
		return resultFalse("查询引用包列表失败!");
	}
}
