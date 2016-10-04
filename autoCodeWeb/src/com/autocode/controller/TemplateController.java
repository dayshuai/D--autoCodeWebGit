package com.autocode.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.autocode.base.BaseController;
import com.autocode.base.Pagination;
import com.autocode.base.ServiceException;
import com.autocode.bean.Project;
import com.autocode.bean.Template;
import com.autocode.bean.TemplateConfig;
import com.autocode.service.ProjectService;
import com.autocode.service.TemplateConfigService;
import com.autocode.service.TemplateService;
import com.autocode.util.DateTimeUtil;

@Controller
@RequestMapping({ "/template" })
public class TemplateController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(TemplateController.class);

	@Inject
	private TemplateService templateService;

	@Autowired
	private TemplateConfigService templateConfigService;

	@Autowired
	private ProjectService projectService;

	@RequestMapping
	public String template(Model model) {
		model.addAttribute("nav_4", "onnav");
		model.addAttribute("template", "focus");
		return "template";
	}

	@ResponseBody
	@RequestMapping({ "uploadTemplateFtl" })
	public Map<String, Object> uploadTemplateFtl(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, Model model, Integer templateId) {
		Template template = this.templateService.querySingleTemplate(templateId);
		if (template == null) {
			return resultFalse("模板ID不能为空");
		}
		if ((file != null) && (file.getSize() > 0L)) {
			List <TemplateConfig> templateConfigList = this.templateConfigService.queryTemplateConfigListForColumnName("templateId",
					template.getTemplateId());
			if ((templateConfigList == null) || (templateConfigList.size() == 0)) {
				return resultFalse("请在模板配置中,配置相应的框架和" + file.getOriginalFilename() + "文件名");
			}
			String fileName = null;
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig templateConfig = (TemplateConfig) templateConfigList.get(i);
				if (templateConfig.getConfigValue().toLowerCase().equals(file.getOriginalFilename().toLowerCase())) {
					fileName = templateConfig.getConfigValue();
					break;
				}
			}
			if (fileName == null) {
				return resultFalse("请在模板配置中,配置相应的框架和" + file.getOriginalFilename() + "文件名");
			}
			String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length()).toLowerCase();
			if ((suffix.equals(".ftl")) || (suffix.equals(".zip"))) {
				String inputPath = request.getSession().getServletContext().getRealPath("template") + "/"
						+ template.getTemplateName();
				File tempFile = new File(inputPath);

				if (!tempFile.exists())
					tempFile.mkdir();
				try {
					BufferedInputStream in = new BufferedInputStream(file.getInputStream());
					BufferedOutputStream out = new BufferedOutputStream(
							new FileOutputStream(inputPath + "//" + fileName));
					byte[] bb = new byte[1024];
					int n;
					while ((n = in.read(bb)) != -1) {
						out.write(bb, 0, n);
					}
					out.close();
					in.close();
					return resultTrue(fileName);
				} catch (Exception e) {
					e.printStackTrace();
					return resultFalse("上传文件异常请,联系管理员");
				}
			}
			return resultFalse("只能上传.ftl和.zip文件");
		}
		return resultFalse("请导入文件后上传");
	}

	@ResponseBody
	@RequestMapping({ "uploadTemplateImage" })
	public Map<String, Object> uploadTemplateImage(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, Model model) {
		if ((file != null) && (file.getSize() > 0L)) {
			String inputPath = request.getSession().getServletContext().getRealPath("uploadFiles");
			File tempFile = new File(inputPath);

			if (!tempFile.exists()) {
				tempFile.mkdir();
			}
			String fileName = file.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length()).toLowerCase();
			if ((suffix.equals(".jpg")) || (suffix.equals(".gif")) || (suffix.equals(".png"))) {
				try {
					String refName = DateTimeUtil.FormatSystemDateSN() + suffix;
					BufferedInputStream in = new BufferedInputStream(file.getInputStream());
					BufferedOutputStream out = new BufferedOutputStream(
							new FileOutputStream(inputPath + "//" + refName));
					byte[] bb = new byte[1024];
					int n;
					while ((n = in.read(bb)) != -1) {
						out.write(bb, 0, n);
					}
					out.close();
					in.close();
					return resultTrue(refName);
				} catch (Exception e) {
					e.printStackTrace();
					return resultFalse("上传文件异常请,联系管理员");
				}
			}
			return resultFalse("只能上传图片");
		}
		return resultFalse("请导入文件后上传");
	}

	@ResponseBody
	@RequestMapping({ "insertTemplate" })
	public Map<String, Object> insertTemplate(Model model, Template template) {
		try {
			this.templateService.insertTemplate(template);
		} catch (Exception e) {
			LOG.error("TemplateController[添加失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateTemplate" })
	public Map<String, Object> updateTemplate(Model model, Template template) {
		try {
			this.templateService.updateTemplate(template);
		} catch (Exception e) {
			LOG.error("TemplateController[修改失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTemplate" })
	public Map<String, Object> deleteTemplate(Model model, Integer templateId, HttpServletRequest request) {
		try {
			String templateUrl = request.getSession().getServletContext().getRealPath("template");
			this.templateService.deleteTemplate(templateId, templateUrl);
		} catch (Exception e) {
			LOG.error("TemplateController[删除失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteTemplates" })
	public Map<String, Object> deleteTemplates(Model model, String ids, HttpServletRequest request) {
		try {
			String templateUrl = request.getSession().getServletContext().getRealPath("template");
			this.templateService.deleteTemplates(ids, templateUrl);
		} catch (Exception e) {
			LOG.error("TemplateController[删除多个失败]");
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryTemplateList" })
	public Pagination queryTemplateList(Model model, Template template) {
		try {
			Integer totalCount = this.templateService.queryTemplateCount(template);
			List dataList = this.templateService.queryTemplateList(template);
			return new Pagination(template, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("TemplateController[查询列表失败]");
		}
		return new Pagination("查询列表异常");
	}

	@ResponseBody
	@RequestMapping({ "templateSelect" })
	public Map<String, Object> templateSelect(Model model) {
		try {
			List list = this.templateService.queryTemplateSelect(null);
			if (list == null) {
				return resultTrue(new ArrayList());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("TemplateController[查询引用模板失败]");
		}
		return resultFalse("查询引用模板失败!");
	}

	@ResponseBody
	@RequestMapping({ "templateSelectByProjectId" })
	public Map<String, Object> templateSelectByProjectId(Model model, Integer projectId) {
		try {
			if (projectId == null) {
				return resultTrue(new ArrayList());
			}
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("项目不存在!");
			}
			List list = this.templateService.queryTemplateSelect(project.getProjectFrame());
			if (list == null) {
				return resultTrue(new ArrayList());
			}
			return resultTrue(list);
		} catch (Exception e) {
			LOG.error("TemplateController[查询引用模板失败]");
		}
		return resultFalse("查询引用模板失败!");
	}
}
