package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.TemplateConfig;
import com.autocode.mapper.TemplateConfigMapper;
import com.autocode.service.TemplateConfigService;
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
@Service("templateConfigService")
public class TemplateConfigServiceImpl extends BaseService implements TemplateConfigService {
	private static final Logger LOG = LoggerFactory.getLogger(TemplateConfigServiceImpl.class);

	@Autowired
	private TemplateConfigMapper templateConfigMapper;

	private void validation(TemplateConfig templateConfig, String operatorState) {
		if (templateConfig == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (templateConfig.getTemplateConfigId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(templateConfig.getTemplateId())) {
			throw new ServiceException("模板ID不能为空");
		}
		if (isBlank(templateConfig.getConfigName())) {
			throw new ServiceException("配置名称不能为空");
		}
		if (isBlank(templateConfig.getConfigType())) {
			throw new ServiceException("配置类型不能为空");
		}
		if ((templateConfig.getConfigType().equals("COPY")) && (templateConfig.getIsAssignPath().equals("NO"))) {
			throw new ServiceException("直接拷贝必须指定路径");
		}

		if (isBlank(templateConfig.getConfigValue())) {
			throw new ServiceException("配置值不能为空");
		}
		if (isBlank(templateConfig.getIsAssignPath())) {
			throw new ServiceException("是否指定路径不能为空");
		}
		if ((templateConfig.getIsAssignPath().equals("YES")) && (isBlank(templateConfig.getSavePath()))) {
			throw new ServiceException("保存路径不能为空");
		}

		if (!templateConfig.getConfigType().equals("COPY")) {
			if (templateConfig.getConfigValue().indexOf(".ftl") < 0) {
				throw new ServiceException("动态生成或静态生成配置值必须是.ftl文件");
			}
		} else if (templateConfig.getConfigValue().indexOf(".zip") < 0) {
			throw new ServiceException("直接拷贝,配置值必须是.zip文件");
		}

		String fistleter = templateConfig.getConfigValue().substring(0, 1).toUpperCase();
		templateConfig.setConfigValue(
				fistleter + templateConfig.getConfigValue().substring(1, templateConfig.getConfigValue().length()));
		if (!templateConfig.getConfigType().equals("COPY")) {
			if (isBlank(templateConfig.getProduceName())) {
				throw new ServiceException("生成文件不能为空");
			}
			if (!templateConfig.getProduceName().contains(".")) {
				throw new ServiceException("生成文件名必须包含.");
			}
			templateConfig.setProduceName(templateConfig.getProduceName().substring(0,
					templateConfig.getProduceName().lastIndexOf("."))
					+ templateConfig.getProduceName().substring(templateConfig.getProduceName().lastIndexOf("."),
							templateConfig.getProduceName().length()).toLowerCase());
		} else {
			templateConfig.setProduceName("");
		}
	}

	public Integer insertTemplateConfig(TemplateConfig templateConfig) {
		validation(templateConfig, "insert");
		Map map = new HashMap();
		map.put("templateId", templateConfig.getTemplateId());
		map.put("configName", templateConfig.getConfigName());
		map.put("configType", templateConfig.getConfigType());
		map.put("configValue", templateConfig.getConfigValue());
		List templateConfigList = this.templateConfigMapper.queryObjectListForRepeat(map);
		if ((templateConfigList != null) && (templateConfigList.size() > 0))
			throw new ServiceException("配置名称重复,请修改!");
		try {
			this.templateConfigMapper.insert(templateConfig);
			return templateConfig.getTemplateConfigId();
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.insertTemplateConfig [ " + templateConfig + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updateTemplateConfig(TemplateConfig templateConfig) {
		validation(templateConfig, "update");
		Map map = new HashMap();
		map.put("templateId", templateConfig.getTemplateId());
		map.put("configName", templateConfig.getConfigName());
		map.put("configType", templateConfig.getConfigType());
		map.put("configValue", templateConfig.getConfigValue());
		List templateConfigList = this.templateConfigMapper.queryObjectListForRepeat(map);
		if ((templateConfigList != null) && (templateConfigList.size() > 0)) {
			for (int i = 0; i < templateConfigList.size(); i++) {
				TemplateConfig t = (TemplateConfig) templateConfigList.get(i);
				if (t.getTemplateConfigId().equals(templateConfig.getTemplateConfigId())) {
					templateConfigList.remove(i);
					break;
				}
			}
			if (templateConfigList.size() > 0)
				throw new ServiceException("配置名称重复,请修改!");
		}
		try {
			return this.templateConfigMapper.update(templateConfig);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.updateTemplateConfig [ " + templateConfig + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deleteTemplateConfig(Integer templateConfigId) {
		try {
			return this.templateConfigMapper.delete(templateConfigId);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.deleteTemplateConfig [ " + templateConfigId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deleteTemplateConfigs(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.templateConfigMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.deleteTemplateConfigs [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public Integer deleteTemplateConfigByTemplateId(Integer templateId) {
		try {
			return this.templateConfigMapper.deleteObjectByTemplateId(templateId);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.deleteTemplateConfig [ " + templateId + " ] 删除模板配置失败", e);
		}
		throw new ServiceException("删除模板配置失败");
	}

	public TemplateConfig querySingleTemplateConfig(Integer templateConfigId) {
		try {
			return (TemplateConfig) this.templateConfigMapper.querySingleObject(templateConfigId);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.querySingleTemplateConfig [ " + templateConfigId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryTemplateConfigCount(TemplateConfig templateConfig) {
		try {
			return this.templateConfigMapper.queryObjectCount(templateConfig);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.queryTemplateConfigCount [ " + templateConfig + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<TemplateConfig> queryTemplateConfigList(TemplateConfig templateConfig) {
		try {
			return this.templateConfigMapper.queryObjectList(templateConfig);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.queryTemplateConfigList [ " + templateConfig + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<TemplateConfig> queryTemplateConfigSelect() {
		try {
			return this.templateConfigMapper.queryObjectSelect();
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.queryTemplateConfigSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<TemplateConfig> queryTemplateConfigListForColumnName(String columnName, Object columnValue) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.templateConfigMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("TemplateConfigServiceImpl.queryTemplateConfigListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}

	public List<String> templateConfigSelectByTemplateId(Integer templateId) {
		try {
			List configList = this.templateConfigMapper.templateConfigSelectByTemplateId(templateId);
			if ((configList == null) || (configList.size() == 0)) {
				return null;
			}
			List list = new ArrayList();
			for (int i = 0; i < configList.size(); i++) {
				TemplateConfig tc = (TemplateConfig) configList.get(i);
				String value = "<option value='" + tc.getTemplateConfigId() + "'>" + tc.getConfigName() + "</option>";
				list.add(value);
			}
			return list;
		} catch (Exception e) {
			LOG.error("ProjectServiceImpl.queryProjectSelectByIsValidation 查询已经验证通过下拉框列表失败", e);
		}
		throw new ServiceException("查询已经验证通过下拉框列表失败");
	}
}
