package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Config;
import com.autocode.bean.PackageConfig;
import com.autocode.bean.Template;
import com.autocode.bean.TemplateConfig;
import com.autocode.mapper.TemplateMapper;
import com.autocode.service.ConfigService;
import com.autocode.service.PackageConfigService;
import com.autocode.service.TemplateConfigService;
import com.autocode.service.TemplateService;
import com.autocode.util.PinyinUtil;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("templateService")
public class TemplateServiceImpl extends BaseService implements TemplateService {
	private static final Logger LOG = LoggerFactory.getLogger(TemplateServiceImpl.class);

	@Autowired
	private TemplateMapper templateMapper;

	@Autowired
	private TemplateConfigService templateConfigService;

	@Autowired
	private PackageConfigService packageConfigService;

	@Autowired
	private ConfigService configService;

	private void validation(Template template, String operatorState) {
		if (template == null) {
			throw new ServiceException("表单不能为空");
		}
		if (operatorState.equals("update")) {
			if (template.getTemplateId() == null)
				throw new ServiceException("序号不能为空");
		} else {
			template.setIsValidation("NO");
		}
		if (isBlank(template.getTemplateTitle())) {
			throw new ServiceException("模板标题不能为空");
		}
		if (isBlank(template.getTemplateName())) {
			throw new ServiceException("模板名称不能为空");
		}
		if (PinyinUtil.isPinyin(template.getTemplateName())) {
			throw new ServiceException("模板名称不能有中文");
		}
		if (isBlank(template.getApplyFrame())) {
			throw new ServiceException("适用框架不能为空");
		}
		if (isBlank(template.getIsValidation())) {
			throw new ServiceException("是否验证不能为空");
		}
		if (isBlank(template.getMemo()))
			throw new ServiceException("备注不能为空");
	}

	public Integer insertTemplate(Template template) {
		validation(template, "insert");
		List templateList = queryTemplateListForColumnName("templateName", template.getTemplateName());
		if ((templateList != null) && (templateList.size() > 0))
			throw new ServiceException("模板名称重复,请修改!");
		try {
			this.templateMapper.insert(template);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.insertTemplate [ " + template + " ] 添加失败", e);
			throw new ServiceException("添加失败");
		}
		List packageConfigList = this.packageConfigService.queryPackageConfigListForColumnName("applyFrame",
				template.getApplyFrame());

		Config tempConfig = this.configService.queryConfigListForColumnName("configName", "ConfigTypeMap");
		Map map = new HashMap();
		if (tempConfig != null) {
			String[] configValues = tempConfig.getConfigValue().split(",");
			for (int i = 0; i < configValues.length; i++) {
				map.put(configValues[i], Boolean.valueOf(true));
			}
		}
		if ((packageConfigList != null) && (packageConfigList.size() > 0)) {
			for (int i = 0; i < packageConfigList.size(); i++) {
				PackageConfig p = (PackageConfig) packageConfigList.get(i);
				String configType = "DYNAMIC";
				String fistleter = p.getPackageName().substring(0, 1).toUpperCase();
				String produceName = "[replace]" + fistleter
						+ p.getPackageName().substring(1, p.getPackageName().length()) + ".java";
				if ((map.get(p.getPackageName()) != null) && (((Boolean) map.get(p.getPackageName())).booleanValue())) {
					configType = "STATIC";
					produceName = fistleter + p.getPackageName().substring(1, p.getPackageName().length()) + ".java";
				}
				TemplateConfig templateConfig = new TemplateConfig(template.getTemplateId(), configType,
						p.getPackageName(), p.getPackageName() + ".ftl", "NO", "", produceName);
				this.templateConfigService.insertTemplateConfig(templateConfig);
			}
		}
		Config config = null;
		if (template.getApplyFrame().equals("SSH"))
			config = this.configService.queryConfigListForColumnName("configName", "SSHTemplateMap");
		else if (template.getApplyFrame().equals("SM")) {
			config = this.configService.queryConfigListForColumnName("configName", "SMTemplateMap");
		}
		if (config != null) {
			String[] configValues = config.getConfigValue().split(",");
			for (int i = 0; i < configValues.length; i++) {
				String configName = configValues[i].split(":")[0];
				String produceName = configValues[i].split(":")[1];
				String configType = "DYNAMIC";
				String isAssignPath = "NO";
				String savePath = "";
				if ((map.get(configName) != null) && (((Boolean) map.get(configName)).booleanValue())) {
					configType = "STATIC";
					produceName = configName.toLowerCase() + "." + produceName;
					isAssignPath = "YES";
					savePath = "修改为指定目录  src webRoot 等...";
				} else {
					produceName = "[replace]" + configName + "." + produceName;
				}
				TemplateConfig templateConfig = new TemplateConfig(template.getTemplateId(), configType, configName,
						configName + ".ftl", isAssignPath, savePath, produceName);
				this.templateConfigService.insertTemplateConfig(templateConfig);
			}
		}
		return template.getTemplateId();
	}

	public Integer updateTemplate(Template template) {
		validation(template, "update");
		List templateList = queryTemplateListForColumnName("templateName", template.getTemplateName());
		if ((templateList != null) && (templateList.size() > 0)) {
			for (int i = 0; i < templateList.size(); i++) {
				Template t = (Template) templateList.get(i);
				if (t.getTemplateId().equals(template.getTemplateId())) {
					templateList.remove(i);
					break;
				}
			}
			if ((templateList != null) && (templateList.size() > 0)) {
				throw new ServiceException("模板名称重复,请修改!");
			}
		}
		Template tl = querySingleTemplate(template.getTemplateId());

		if (!tl.getApplyFrame().equals(template.getApplyFrame())) {
			this.templateConfigService.deleteTemplateConfigByTemplateId(template.getTemplateId());
			List packageConfigList = this.packageConfigService.queryPackageConfigListForColumnName("applyFrame",
					template.getApplyFrame());

			Config tempConfig = this.configService.queryConfigListForColumnName("configName", "ConfigTypeMap");
			Map map = new HashMap();
			if (tempConfig != null) {
				String[] configValues = tempConfig.getConfigValue().split(",");
				for (int i = 0; i < configValues.length; i++) {
					map.put(configValues[i], Boolean.valueOf(true));
				}
			}
			if ((packageConfigList != null) && (packageConfigList.size() > 0)) {
				for (int i = 0; i < packageConfigList.size(); i++) {
					PackageConfig p = (PackageConfig) packageConfigList.get(i);
					String configType = "DYNAMIC";
					String fistleter = p.getPackageName().substring(0, 1).toUpperCase();
					String produceName = "[replace]" + fistleter
							+ p.getPackageName().substring(1, p.getPackageName().length()) + ".java";
					if ((map.get(p.getPackageName()) != null)
							&& (((Boolean) map.get(p.getPackageName())).booleanValue())) {
						configType = "STATIC";
						produceName = fistleter + p.getPackageName().substring(1, p.getPackageName().length())
								+ ".java";
					}
					TemplateConfig templateConfig = new TemplateConfig(template.getTemplateId(), configType,
							p.getPackageName(), p.getPackageName() + ".ftl", "NO", "", produceName);
					this.templateConfigService.insertTemplateConfig(templateConfig);
				}
			}
			Config config = null;
			if (template.getApplyFrame().equals("SSH"))
				config = this.configService.queryConfigListForColumnName("configName", "SSHTemplateMap");
			else if (template.getApplyFrame().equals("SM")) {
				config = this.configService.queryConfigListForColumnName("configName", "SMTemplateMap");
			}
			if (config != null) {
				String[] configValues = config.getConfigValue().split(",");
				for (int i = 0; i < configValues.length; i++) {
					String configName = configValues[i].split(":")[0];
					String produceName = configValues[i].split(":")[1];
					String configType = "DYNAMIC";
					String isAssignPath = "NO";
					String savePath = "";
					if ((map.get(configName) != null) && (((Boolean) map.get(configName)).booleanValue())) {
						configType = "STATIC";
						produceName = configName.toLowerCase() + "." + produceName;
						isAssignPath = "YES";
						savePath = "修改为指定目录  src webRoot 等...";
					} else {
						produceName = "[replace]" + configName + "." + produceName;
					}
					TemplateConfig templateConfig = new TemplateConfig(template.getTemplateId(), configType, configName,
							configName + ".ftl", isAssignPath, savePath, produceName);
					this.templateConfigService.insertTemplateConfig(templateConfig);
				}
			}
		}
		try {
			return this.templateMapper.update(template);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.updateTemplate [ " + template + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteTemplate(Integer templateId, String templateUrl) {
		try {
			Template template = querySingleTemplate(templateId);
			File tempFile = new File(templateUrl + "/" + template.getTemplateName());

			if (tempFile.exists()) {
				tempFile.delete();
			}

			templateUrl = templateUrl.replace("template", "uploadFiles");
			tempFile = new File(templateUrl + "/" + template.getImageUrl());
			if (tempFile.exists()) {
				tempFile.delete();
			}
			this.templateConfigService.deleteTemplateConfigByTemplateId(template.getTemplateId());
			return this.templateMapper.delete(templateId);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.deleteTemplate [ " + templateId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteTemplates(String id, String templateUrl) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				deleteTemplate(Integer.valueOf(Integer.parseInt(ids[i])), templateUrl);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.deleteTemplates [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Template querySingleTemplate(Integer templateId) {
		try {
			return (Template) this.templateMapper.querySingleObject(templateId);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.querySingleTemplate [ " + templateId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryTemplateCount(Template template) {
		try {
			return this.templateMapper.queryObjectCount(template);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.queryTemplateCount [ " + template + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<Template> queryTemplateList(Template template) {
		try {
			return this.templateMapper.queryObjectList(template);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.queryTemplateList [ " + template + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<String> queryTemplateSelect(String projectFrame) {
		try {
			List templateList = this.templateMapper.queryObjectSelect();
			if ((templateList == null) || (templateList.size() == 0)) {
				return null;
			}
			List list = new ArrayList();
			for (int i = 0; i < templateList.size(); i++) {
				Template t = (Template) templateList.get(i);

				if (projectFrame != null) {
					if ((t.getApplyFrame().equals(projectFrame)) && (t.getIsValidation().equals("YES"))) {
						String value = "<option value='" + t.getTemplateId() + "'>" + t.getTemplateName() + "</option>";
						list.add(value);
					}
				} else {
					String value = "<option value='" + t.getTemplateId() + "'>" + t.getTemplateName() + "</option>";
					list.add(value);
				}
			}
			return list;
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.queryTemplateSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<Template> queryTemplateListForColumnName(String columnName, String columnValue) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.templateMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("TemplateServiceImpl.queryTemplateListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}
}
