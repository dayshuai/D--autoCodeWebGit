package com.autocode.controller;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Template;
import com.autocode.bean.TemplateConfig;
import com.autocode.service.TemplateConfigService;
import com.autocode.service.TemplateService;
import com.autocode.util.FileOperations;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({ "/templateConfig" })
public class TemplateConfigController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(TemplateConfigController.class);

	@Inject
	private TemplateConfigService templateConfigService;

	@Autowired
	private TemplateService templateService;

	@RequestMapping
	public String index(Model model) {
		model.addAttribute("nav_4", "onnav");
		model.addAttribute("templateConfig", "focus");
		return "templateConfig";
	}

	@ResponseBody
	@RequestMapping({ "insertTemplateConfig" })
	public Map<String, Object> insertTemplateConfig(Model model, TemplateConfig templateConfig) {
		try {
			this.templateConfigService.insertTemplateConfig(templateConfig);
		} catch (Exception e) {
			LOG.error("TemplateConfigController[添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryTemplateContent" })
	public Map<String, Object> queryTemplateContent(Model model, HttpServletRequest request, Integer templateConfigId) {
		TemplateConfig templateConfig = this.templateConfigService.querySingleTemplateConfig(templateConfigId);
		if (templateConfig == null) {
			return resultFalse("没有查询到模板信息");
		}
		Template template = this.templateService.querySingleTemplate(templateConfig.getTemplateId());
		String inputPath = request.getSession().getServletContext().getRealPath("template") + "/"
				+ template.getTemplateName() + "/" + templateConfig.getConfigValue();
		String value = FileOperations.readTextContentReturenString(inputPath);
		return resultTrue(value);
	}

	@ResponseBody
	@RequestMapping({ "saveTemplateContent" })
	public Map<String, Object> saveTemplateContent(Model model, HttpServletRequest request, Integer templateConfigId,
			String content) {
		TemplateConfig templateConfig = this.templateConfigService.querySingleTemplateConfig(templateConfigId);
		if (templateConfig == null) {
			return resultFalse("没有查询到模板信息");
		}
		Template template = this.templateService.querySingleTemplate(templateConfig.getTemplateId());
		String inputPath = request.getSession().getServletContext().getRealPath("template") + "/"
				+ template.getTemplateName() + "/" + templateConfig.getConfigValue();
		FileOperations.writeContent(inputPath, content);
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateTemplateConfig" })
	public Map<String, Object> updateTemplateConfig(Model model, TemplateConfig templateConfig) {
		try {
			this.templateConfigService.updateTemplateConfig(templateConfig);
		} catch (Exception e) {
			LOG.error("TemplateConfigController[修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTemplateConfig" })
	public Map<String, Object> deleteTemplateConfig(Model model, Integer templateConfigId) {
		try {
			this.templateConfigService.deleteTemplateConfig(templateConfigId);
		} catch (Exception e) {
			LOG.error("TemplateConfigController[删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTemplateConfigs" })
	public Map<String, Object> deleteTemplateConfigs(Model model, String ids) {
		try {
			this.templateConfigService.deleteTemplateConfigs(ids);
		} catch (Exception e) {
			LOG.error("TemplateConfigController[删除多个失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryTemplateConfigList" })
	public Pagination queryTemplateConfigList(Model model, TemplateConfig templateConfig) {
		try {
			Integer totalCount = this.templateConfigService.queryTemplateConfigCount(templateConfig);
			List dataList = this.templateConfigService.queryTemplateConfigList(templateConfig);
			return new Pagination(templateConfig, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("TemplateConfigController[查询列表失败]", e);
		}
		return new Pagination("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "templateConfigSelectByTemplateId" })
	public Map<String, Object> templateConfigSelectByTemplateId(Model model, Integer templateId) {
		try {
			List list = this.templateConfigService.templateConfigSelectByTemplateId(templateId);
			if (list == null) {
				return resultTrue(new ArrayList());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("TemplateConfigController[查询引用模板配置失败]");
		}
		return resultFalse("查询引用模板配置失败!");
	}
}
