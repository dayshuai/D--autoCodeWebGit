package com.autocode.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.RejectedExecutionException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import com.autocode.bean.Column;
import com.autocode.bean.Config;
import com.autocode.bean.Control;
import com.autocode.bean.PackageConvert;
import com.autocode.bean.Produce;
import com.autocode.bean.Project;
import com.autocode.bean.ProjectPackage;
import com.autocode.bean.Table;
import com.autocode.bean.TemplateConfig;
import com.autocode.produce.ProduceFileUtil;
import com.autocode.produce.ProduceRun;
import com.autocode.service.ColumnService;
import com.autocode.service.ConfigService;
import com.autocode.service.ControlService;
import com.autocode.service.PackageConvertService;
import com.autocode.service.ProduceService;
import com.autocode.service.ProjectPackageService;
import com.autocode.service.ProjectService;
import com.autocode.service.TableService;
import com.autocode.service.TemplateConfigService;
import com.autocode.service.TemplateService;
import com.autocode.util.DateTimeUtil;
import com.autocode.util.FileOperations;
import com.autocode.util.ZipUtil;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;

@Controller
@RequestMapping({ "/produce" })
public class ProduceController extends BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(ProduceController.class);

	@Inject
	private ProduceService produceService;

	@Autowired
	private ProjectService projectService;

	@Autowired
	private ProjectPackageService projectPackageService;

	@Autowired
	private TableService tableService;

	@Autowired
	private ControlService controlService;

	@Autowired
	private ColumnService columnService;

	@Autowired
	private PackageConvertService packageConvertService;

	@Autowired
	private TemplateService templateService;

	@Autowired
	private TemplateConfigService templateConfigService;

	@Autowired
	private ConfigService configService;

	@Autowired
	@Qualifier("taskExecutor")
	private TaskExecutor taskExecutor;

	@RequestMapping
	public String index(Model model) {
		model.addAttribute("nav_5", "onnav");
		model.addAttribute("produce", "focus");
		return "produce";
	}

	@RequestMapping({ "projectProduce" })
	public String projectProduce(Model model) {
		model.addAttribute("nav_5", "onnav");
		model.addAttribute("oneKeyProduce", "focus");
		return "projectProduce";
	}

	@RequestMapping({ "classProduce" })
	public String classProduce(Model model) {
		model.addAttribute("nav_5", "onnav");
		model.addAttribute("classProduce", "focus");
		return "classProduce";
	}

	@RequestMapping({ "tableProduce" })
	public String tableProduce(Model model) {
		model.addAttribute("nav_5", "onnav");
		model.addAttribute("tableProduce", "focus");
		return "tableProduce";
	}

	@ResponseBody
	@RequestMapping({ "queryProjectInfo" })
	public Map<String, Object> queryProjectInfo(Model model, HttpServletRequest request, Integer projectId,
			Integer templateId) {
		try {
			/*String error = "Error:0";
			List tableList = this.tableService.queryTableListForConvertError(projectId, error);
			List columnList = this.columnService.queryColumnListForConvertError(projectId, error);
			if ((isNotBlank(tableList)) || (isNotBlank(columnList))) {
				return resultFalse("请先解决项目中没有修改的 Error:0 信息");
			}*/
			List <Table> tableList = new ArrayList<Table>();
			List <Column> columnList = new ArrayList<Column>();
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("请先选择项目");
			}
			com.autocode.bean.Template template = this.templateService.querySingleTemplate(templateId);
			if (template == null) {
				return resultFalse("请先选择模板,如果没有模板请在后台添加");
			}
			if (!project.getProjectFrame().equals(template.getApplyFrame())) {
				return resultFalse("项目框架不匹配该模板,不能用在该项目上");
			}
			List <TemplateConfig> templateConfigList = this.templateConfigService.queryTemplateConfigListForColumnName("templateId",
					templateId);
			if ((templateConfigList == null) || (templateConfigList.size() == 0)) {
				return resultFalse(template.getTemplateName() + "模板下没有配置信息,请配置。");
			}
			tableList = this.tableService.queryTableListByProjectId(projectId);
			if ((tableList == null) || (tableList.size() == 0)) {
				return resultFalse(project.getProjectName() + "项目下没有表,不能生成。");
			}
			List <Control> controlList = this.controlService.queryControlListByProjectId(projectId);
			if ((controlList == null) || (controlList.size() == 0)) {
				return resultFalse(project.getProjectName() + "项目下没有控制器类,不能生成。");
			}
			Map <String, Object> map = new HashMap <String, Object> ();

			for (int i = 0; i < tableList.size(); i++) {
				Table t = (Table) tableList.get(0);
				columnList = this.columnService.queryColumnListByTableId(t.getTableId());
				if ((columnList == null) || (columnList.size() == 0)) {
					return resultFalse(t.getTableName() + "表没有字段,请修改后在生成!");
				}
				boolean bool = true;
				for (int j = 0; j < columnList.size(); j++) {
					Column c = (Column) columnList.get(j);
					if (c.getIsPrimary().equals("YES")) {
						bool = false;
						break;
					}
				}
				if (bool) {
					return resultFalse(t.getTableName() + "表没有主键,请修改后在生成!");
				}
			}

			Config config = this.configService.queryConfigListForColumnName("configName", "LocalhostRun");
			if ((config == null) || (config.getConfigValue().equals("NO")))
				map.put("openFile", Boolean.valueOf(false));
			else {
				map.put("openFile", Boolean.valueOf(true));
			}
			map.put("projectUrl", request.getSession().getServletContext().getRealPath("produceFiles/projectProduce")
					+ "\\" + project.getProjectName());
			int beanAmount = tableList.size();
			int controllerAmount = controlList.size();
			int dynamicCount = 0;
			String columnsZh = "";
			String columnsValue = "";
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) templateConfigList.get(i);
				if (tc.getConfigType().equals("DYNAMIC")) {
					columnsZh = columnsZh + tc.getConfigName() + "数量,";
					if ((tc.getConfigName().equals("Controller")) || (tc.getConfigName().equals("Action"))
							|| (tc.getConfigName().equals("Page"))) {
						dynamicCount += controllerAmount;
						columnsValue = columnsValue + controllerAmount + ",";
					} else {
						dynamicCount += beanAmount;
						columnsValue = columnsValue + beanAmount + ",";
					}
				}
			}
			int produceCount = 0;
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) templateConfigList.get(i);
				if ((tc.getConfigType().equals("STATIC")) || (tc.getConfigType().equals("COPY"))) {
					produceCount++;
				} else if ((tc.getConfigName().equals("Controller")) || (tc.getConfigName().equals("Action"))
						|| (tc.getConfigName().equals("Page")))
					produceCount += controllerAmount;
				else {
					produceCount += beanAmount;
				}
			}

			columnsZh = columnsZh + "其它文件数量,合计数量";
			columnsValue = columnsValue + (produceCount - dynamicCount) + "," + produceCount;
			map.put("columnsZh", columnsZh);
			map.put("columnsValue", columnsValue);
			map.put("produceCount", Integer.valueOf(produceCount));
			return resultTrue(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFalse("系统异常");
	}

	@ResponseBody
	@RequestMapping({ "openFile" })
	public Map<String, Object> openFile(Model model, HttpServletRequest request, String fileName) {
		try {
			String filePath = request.getSession().getServletContext().getRealPath("produceFiles/" + fileName);
			String cmd = "cmd /c start " + filePath;
			Runtime.getRuntime().exec(cmd);
			return resultTrue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFalse("打开文件夹异常。");
	}

	@ResponseBody
	@RequestMapping({ "startProjectProduce" })
	public Map<String, Object> startProjectProduce(Model model, HttpServletRequest request, Integer projectId,
			Integer templateId) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("请先选择项目");
			}
			com.autocode.bean.Template template = this.templateService.querySingleTemplate(templateId);
			if (template == null) {
				return resultFalse("请先选择模板,如果没有模板请在后台添加");
			}
			if (!project.getProjectFrame().equals(template.getApplyFrame())) {
				return resultFalse("项目框架不匹配该模板,不能用在该项目上");
			}
			boolean isOpenFile = false;
			Config config = this.configService.queryConfigListForColumnName("ConfigName", "LocalhostRun");
			if ((config != null) && (StringUtils.equals("YES", config.getConfigValue()))) {
				isOpenFile = true;
			}
			List <TemplateConfig> templateConfigList = this.templateConfigService.queryTemplateConfigListForColumnName("templateId",
					templateId);
			if ((templateConfigList == null) || (templateConfigList.size() == 0)) {
				return resultFalse(template.getTemplateName() + "模板下没有配置信息,请配置。");
			}

			String templatePath = request.getSession().getServletContext()
					.getRealPath("template/" + template.getTemplateName());
			File file = new File(templatePath);

			if (file.exists()) {
				String[] files = file.list();
				for (int i = 0; i < templateConfigList.size(); i++) {
					boolean configBool = true;
					TemplateConfig templateConfig = (TemplateConfig) templateConfigList.get(i);
					for (int j = 0; j < files.length; j++) {
						if (templateConfig.getConfigValue().equals(files[j])) {
							configBool = false;
							break;
						}
					}
					if (configBool)
						return resultFalse("生成失败，" + templateConfig.getConfigValue() + "模板文件没有上传。");
				}
			} else {
				return resultFalse(template.getTemplateName() + "模板,没有导入模板文件。");
			}
			List <Table> tableList = this.tableService.queryTableListByProjectId(projectId);
			if ((tableList == null) || (tableList.size() == 0)) {
				return resultFalse(project.getProjectName() + "项目下没有表,不能生成。");
			}
			List <Control> controlList = this.controlService.queryControlListByProjectId(projectId);
			if ((controlList == null) || (controlList.size() == 0)) {
				return resultFalse(project.getProjectName() + "项目下没有控制器类,不能生成。");
			}
			int beanAmount = tableList.size();
			int controllerAmount = controlList.size();
			int produceCount = 0;
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) templateConfigList.get(i);
				if ((tc.getConfigType().equals("STATIC")) || (tc.getConfigType().equals("COPY"))) {
					produceCount++;
				} else if ((tc.getConfigName().equals("Controller")) || (tc.getConfigName().equals("Action"))
						|| (tc.getConfigName().equals("Page")))
					produceCount += controllerAmount;
				else {
					produceCount += beanAmount;
				}
			}

			List <PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
			Map <String, String> packageMap = new HashMap <String, String> ();
			if ((packageConvertList != null) && (packageConvertList.size() > 0)) {
				for (int i = 0; i < packageConvertList.size(); i++) {
					PackageConvert pc = (PackageConvert) packageConvertList.get(i);
					packageMap.put(pc.getClassName(), pc.getPackageName());
				}
			}
			for (int i = 0; i < tableList.size(); i++) {
				Table table = tableList.get(i);
				List <Column> columnList = this.columnService.queryColumnListByTableId(table.getTableId());
				for (int j = 0; j < columnList.size(); j++) {
					Column column = columnList.get(j);
					if ((column.getIsImportPackage().equals("YES")) && (packageMap.size() > 0)) {
						String importPackageName = (String) packageMap.get(column.getColumnType());
						if (importPackageName == null)
							column.setImportPackageName("请在类包转换中配置" + column.getColumnType() + "类型");
						else {
							column.setImportPackageName(importPackageName);
						}
					}
				}
				table.setColumnList(columnList);
			}
			String writePath = request.getSession().getServletContext().getRealPath("produceFiles/projectProduce");
			ProduceFileUtil.deleteFile(writePath, project.getProjectName());
			List <ProjectPackage> projectPackageList = this.projectPackageService.queryProjectPackageListByProjectId(projectId);
			try {
				this.taskExecutor.execute(new ProduceRun(project, this.produceService, projectPackageList, tableList,
						controlList, packageConvertList, templateConfigList, isOpenFile, produceCount,
						templatePath, writePath, "projectProduce"));
			} catch (RejectedExecutionException e) {
				e.printStackTrace();
				return resultFalse("线程异常，请联系管理员。");
			}
			return resultTrue(project.getProjectName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFalse("系统异常。");
	}

	@ResponseBody
	@RequestMapping({ "startClassProduce" })
	public Map<String, Object> startClassProduce(Model model, HttpServletRequest request, Integer projectId,
			Integer templateId, Integer templateConfigId, boolean isOpenFile) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("请先选择项目");
			}
			com.autocode.bean.Template template = this.templateService.querySingleTemplate(templateId);
			if (template == null) {
				return resultFalse("请先选择模板,如果没有模板请在后台添加");
			}
			if (!project.getProjectFrame().equals(template.getApplyFrame())) {
				return resultFalse("项目框架不匹配该模板,不能用在该项目上");
			}
			TemplateConfig templateConfig = this.templateConfigService.querySingleTemplateConfig(templateConfigId);
			if (templateConfig == null) {
				return resultFalse("没有找到动态模板信息,请刷新页面。");
			}

			String templatePath = request.getSession().getServletContext()
					.getRealPath("template/" + template.getTemplateName());
			File file = new File(templatePath);
			List<TemplateConfig> templateConfigList = new ArrayList<TemplateConfig>();
			templateConfigList.add(templateConfig);

			if (file.exists()) {
				String[] files = file.list();
				boolean configBool = true;
				for (int j = 0; j < files.length; j++) {
					if (templateConfig.getConfigValue().equals(files[j])) {
						configBool = false;
						break;
					}
				}
				if (configBool)
					return resultFalse("生成失败，" + templateConfig.getConfigValue() + "模板文件没有上传。");
			} else {
				return resultFalse(template.getTemplateName() + "模板,没有导入模板文件。");
			}
			List<Table> tableList = this.tableService.queryTableListByProjectId(projectId);
			if ((tableList == null) || (tableList.size() == 0)) {
				return resultFalse(project.getProjectName() + "项目下没有表,不能生成。");
			}
			List<Control> controlList = this.controlService.queryControlListByProjectId(projectId);
			if (controlList == null) {
				controlList = new ArrayList<Control>();
			}
			int beanAmount = tableList.size();
			int controllerAmount = controlList.size();
			int produceCount = 0;
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) templateConfigList.get(i);
				if ((tc.getConfigType().equals("STATIC")) || (tc.getConfigType().equals("COPY"))) {
					produceCount++;
				} else if ((tc.getConfigName().equals("Controller")) || (tc.getConfigName().equals("Action"))
						|| (tc.getConfigName().equals("Page")))
					produceCount += controllerAmount;
				else {
					produceCount += beanAmount;
				}
			}

			List<PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
			Map<String, String> packageMap = new HashMap<String, String>();
			if ((packageConvertList != null) && (packageConvertList.size() > 0)) {
				for (int i = 0; i < packageConvertList.size(); i++) {
					PackageConvert pc = (PackageConvert) packageConvertList.get(i);
					packageMap.put(pc.getClassName(), pc.getPackageName());
				}
			}
			for (int i = 0; i < tableList.size(); i++) {
				Table table = (Table) tableList.get(i);
				List<Column> columnList = this.columnService.queryColumnListByTableId(table.getTableId());
				for (int j = 0; j < columnList.size(); j++) {
					Column column = (Column) columnList.get(j);
					if ((column.getIsImportPackage().equals("YES")) && (packageMap.size() > 0)) {
						String importPackageName = (String) packageMap.get(column.getColumnType());
						if (importPackageName == null)
							column.setImportPackageName("请在类包转换中配置" + column.getColumnType() + "类型");
						else {
							column.setImportPackageName(importPackageName);
						}
					}
				}
				table.setColumnList(columnList);
			}
			String writePath = request.getSession().getServletContext().getRealPath("produceFiles/classProduce");
			ProduceFileUtil.deleteFile(writePath, project.getProjectName());
			List<ProjectPackage> projectPackageList = this.projectPackageService.queryProjectPackageListByProjectId(projectId);
			try {
				this.taskExecutor.execute(new ProduceRun(project, this.produceService, projectPackageList, tableList,
						controlList, packageConvertList, templateConfigList, isOpenFile, produceCount,
						templatePath, writePath, "classProduce"));
			} catch (RejectedExecutionException e) {
				e.printStackTrace();
				return resultFalse("线程异常，请联系管理员。");
			}
			HashMap<String, Object> map = new HashMap<String, Object>();

			Config config = this.configService.queryConfigListForColumnName("configName", "LocalhostRun");
			if ((config == null) || (config.getConfigValue().equals("NO")))
				map.put("openFile", Boolean.valueOf(false));
			else {
				map.put("openFile", Boolean.valueOf(true));
			}
			map.put("data", project.getProjectName());
			map.put("result", Boolean.valueOf(true));
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFalse("系统异常!");
	}

	@ResponseBody
	@RequestMapping({ "startTableProduce" })
	public Map<String, Object> startTableProduce(Model model, HttpServletRequest request, Integer projectId,
			Integer templateId, Integer tableId, boolean isOpenFile) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				return resultFalse("请先选择项目");
			}
			com.autocode.bean.Template template = this.templateService.querySingleTemplate(templateId);
			if (template == null) {
				return resultFalse("请先选择模板,如果没有模板请在后台添加");
			}
			if (!project.getProjectFrame().equals(template.getApplyFrame())) {
				return resultFalse("项目框架不匹配该模板,不能用在该项目上");
			}
			Table table = this.tableService.querySingleTable(tableId);
			if (table == null) {
				return resultFalse("表不存在。");
			}

			List<TemplateConfig> templateConfigList = this.templateConfigService.queryTemplateConfigListForColumnName("templateId",
					templateId);
			if ((templateConfigList == null) || (templateConfigList.size() == 0)) {
				return resultFalse(template.getTemplateName() + "模板下没有配置信息,请配置。");
			}

			String templatePath = request.getSession().getServletContext()
					.getRealPath("template/" + template.getTemplateName());
			File file = new File(templatePath);

			if (file.exists()) {
				String[] files = file.list();
				for (int i = 0; i < templateConfigList.size(); i++) {
					boolean configBool = true;
					TemplateConfig templateConfig = (TemplateConfig) templateConfigList.get(i);
					if (!templateConfig.getConfigType().equals("DYNAMIC")) {
						templateConfigList.remove(i);
						i--;
					} else {
						for (int j = 0; j < files.length; j++) {
							if (templateConfig.getConfigValue().equals(files[j])) {
								configBool = false;
								break;
							}
						}
						if (configBool)
							return resultFalse("生成失败，" + templateConfig.getConfigValue() + "模板文件没有上传。");
					}
				}
			} else {
				return resultFalse(template.getTemplateName() + "模板,没有导入模板文件。");
			}
			List<Table> tableList = new ArrayList<Table>();
			tableList.add(table);
			List<Control> controlList = new ArrayList<Control>();
			Control control = this.controlService.querySingleControlByColumnName("tableId", table.getTableId());
			if (control != null) {
				controlList.add(control);
			}
			int beanAmount = tableList.size();
			int controllerAmount = controlList.size();
			int produceCount = 0;
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) templateConfigList.get(i);
				if ((tc.getConfigType().equals("STATIC")) || (tc.getConfigType().equals("COPY"))) {
					produceCount++;
				} else if ((tc.getConfigName().equals("Controller")) || (tc.getConfigName().equals("Action"))
						|| (tc.getConfigName().equals("Page")))
					produceCount += controllerAmount;
				else {
					produceCount += beanAmount;
				}
			}

			List<PackageConvert> packageConvertList = this.packageConvertService.queryPackageConvertSelect();
			Map<String, String> packageMap = new HashMap<String, String>();
			if ((packageConvertList != null) && (packageConvertList.size() > 0)) {
				for (int i = 0; i < packageConvertList.size(); i++) {
					PackageConvert pc = (PackageConvert) packageConvertList.get(i);
					packageMap.put(pc.getClassName(), pc.getPackageName());
				}
			}
			List<Column> columnList = this.columnService.queryColumnListByTableId(table.getTableId());
			for (int j = 0; j < columnList.size(); j++) {
				Column column = (Column) columnList.get(j);
				if ((column.getIsImportPackage().equals("YES")) && (packageMap.size() > 0)) {
					String importPackageName = (String) packageMap.get(column.getColumnType());
					if (importPackageName == null)
						column.setImportPackageName("请在类包转换中配置" + column.getColumnType() + "类型");
					else {
						column.setImportPackageName(importPackageName);
					}
				}
			}
			table.setColumnList(columnList);
			String writePath = request.getSession().getServletContext().getRealPath("produceFiles/tableProduce");
			ProduceFileUtil.deleteFile(writePath, project.getProjectName());
			List<ProjectPackage> projectPackageList = this.projectPackageService.queryProjectPackageListByProjectId(projectId);
			try {
				this.taskExecutor.execute(new ProduceRun(project, this.produceService, projectPackageList, tableList,
						controlList, packageConvertList, templateConfigList, isOpenFile, produceCount, templatePath,
						writePath, "tableProduce"));
			} catch (RejectedExecutionException e) {
				e.printStackTrace();
				return resultFalse("线程异常，请联系管理员。");
			}
			HashMap<String, Object> map = new HashMap<String, Object>();

			Config config = this.configService.queryConfigListForColumnName("configName", "LocalhostRun");
			if ((config == null) || (config.getConfigValue().equals("NO")))
				map.put("openFile", Boolean.valueOf(false));
			else {
				map.put("openFile", Boolean.valueOf(true));
			}
			map.put("data", project.getProjectName());
			map.put("result", Boolean.valueOf(true));
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultFalse("系统异常。");
	}

	@RequestMapping({ "produceSql" })
	public void produceSql(Model model, HttpServletRequest request, HttpServletResponse response, Integer projectId) {
		try {
			Project project = this.projectService.querySingleProject(projectId);
			if (project == null) {
				writeInfo(response, "项目不能为空!");
				return;
			}
			List<?> tableList = this.tableService.queryTableListByProjectId(projectId);
			if ((tableList == null) || (tableList.size() == 0)) {
				writeInfo(response, project.getProjectName() + "项目下没有表,不能生成。");
				return;
			}
			for (int i = 0; i < tableList.size(); i++) {
				Table table = (Table) tableList.get(i);
				List<Column> columnList = this.columnService.queryColumnListByTableId(table.getTableId());
				if ((columnList == null) || (columnList.size() == 0)) {
					writeInfo(response, table.getMappingName() + "表下没有字段!");
					return;
				}
				table.setColumnList(columnList);
			}
			if (project.getDatabaseType().equals("MySql")) {
				Map<String, Object> contentMap = new HashMap<String, Object>();
				contentMap.put("project", project);
				contentMap.put("tableList", tableList);
				contentMap.put("date", DateTimeUtil.FormatCurrentDateTime());
				String templatePath = request.getSession().getServletContext().getRealPath("baseFile");
				String encoding = "utf-8";
				Configuration config = new Configuration();
				File file = new File(templatePath);
				config.setDirectoryForTemplateLoading(file);
				config.setObjectWrapper(new DefaultObjectWrapper());
				freemarker.template.Template template = config.getTemplate("mySql.ftl", encoding);
				response.setContentType("unknown");
				response.setHeader("Content-Disposition", "attachment; filename=" + project.getProjectName() + ".sql");
				Writer out = new OutputStreamWriter(response.getOutputStream(), encoding);
				template.process(contentMap, out);
				out.flush();
				out.close();
			} else if (project.getDatabaseType().equals("SqlServer")) {
				writeInfo(response, "不支持SqlServer导出!");
			} else if (project.getDatabaseType().equals("Oracle")) {
				writeInfo(response, "不支持Oracle导出!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void writeInfo(HttpServletResponse response, String message) throws IOException {
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(message);
	}

	@RequestMapping({ "downloadProject" })
	public void downloadProject(Model model, HttpServletRequest request, HttpServletResponse response,
			Integer projectId) {
		String fileUrl = request.getSession().getServletContext().getRealPath("produceFiles/projectProduce");
		try {
			Project project = this.projectService.querySingleProject(projectId);
			File file = new File(fileUrl + "/" + project.getProjectName() + ".zip");
			if (file.exists()) {
				file.delete();
			}
			String outputPath = ZipUtil.zip("", fileUrl + "/" + project.getProjectName());
			FileOperations.DownloadFile(outputPath, project.getProjectName() + ".zip", response);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.setCharacterEncoding("GB2312");
				response.getWriter().write("下载异常...");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

	@ResponseBody
	@RequestMapping({ "readProjectProduceState" })
	public Map<String, Object> readProjectProduceState(Model model, HttpServletRequest request, String projectName) {
		String readPath = request.getSession().getServletContext().getRealPath("produceFiles/projectProduce");
		return ProduceFileUtil.ReadState(readPath, projectName);
	}

	@ResponseBody
	@RequestMapping({ "readClassProduceState" })
	public Map<String, Object> readClassProduceState(Model model, HttpServletRequest request, String projectName) {
		String readPath = request.getSession().getServletContext().getRealPath("produceFiles/classProduce");
		return ProduceFileUtil.ReadState(readPath, projectName);
	}

	@ResponseBody
	@RequestMapping({ "readTableProduceState" })
	public Map<String, Object> readTableProduceState(Model model, HttpServletRequest request, String projectName) {
		String readPath = request.getSession().getServletContext().getRealPath("produceFiles/tableProduce");
		return ProduceFileUtil.ReadState(readPath, projectName);
	}

	public static void main(String[] args) {
		File file = new File("C:\\Users\\wb-yuansong.f\\Desktop\\催收预警系统表\\css");
		if (file.exists()) {
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++)
				System.out.println(files[i]);
		}
	}

	@ResponseBody
	@RequestMapping({ "insertProduce" })
	public Map<String, Object> insertProduce(Model model, Produce produce) {
		try {
			this.produceService.insertProduce(produce);
		} catch (Exception e) {
			LOG.error("ProduceController[添加失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "updateProduce" })
	public Map<String, Object> updateProduce(Model model, Produce produce) {
		try {
			this.produceService.updateProduce(produce);
		} catch (Exception e) {
			LOG.error("ProduceController[修改失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProduce" })
	public Map<String, Object> deleteProduce(Model model, Integer produceId) {
		try {
			this.produceService.deleteProduce(produceId);
		} catch (Exception e) {
			LOG.error("ProduceController[删除失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "deleteProduces" })
	public Map<String, Object> deleteProduces(Model model, String ids) {
		try {
			this.produceService.deleteProduces(ids);
		} catch (Exception e) {
			LOG.error("ProduceController[删除多个失败]", e);
			return resultFalse(e.getMessage());
		}
		return resultTrue();
	}

	@ResponseBody
	@RequestMapping({ "queryProduceList" })
	public Pagination <Produce> queryProduceList(Model model, Produce produce) {
		try {
			Integer totalCount = this.produceService.queryProduceCount(produce);
			List <Produce> dataList = this.produceService.queryProduceList(produce);
			return new Pagination<Produce>(produce, totalCount, dataList);
		} catch (ServiceException e) {
			LOG.error("ProduceController[查询列表失败]", e);
		}
		return new Pagination<Produce>("查询列表异常");
	}
}
