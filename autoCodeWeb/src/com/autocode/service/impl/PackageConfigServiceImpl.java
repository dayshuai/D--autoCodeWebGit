package com.autocode.service.impl;

import com.autocode.base.BaseService;
import com.autocode.base.ServiceException;
import com.autocode.bean.Config;
import com.autocode.bean.PackageConfig;
import com.autocode.mapper.PackageConfigMapper;
import com.autocode.service.ConfigService;
import com.autocode.service.PackageConfigService;
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
@Service("packageConfigService")
public class PackageConfigServiceImpl extends BaseService implements PackageConfigService {
	private static final Logger LOG = LoggerFactory.getLogger(PackageConfigServiceImpl.class);

	@Autowired
	private PackageConfigMapper packageConfigMapper;

	@Autowired
	private ConfigService configService;

	private void validation(PackageConfig packageConfig, String operatorState) {
		if (packageConfig == null) {
			throw new ServiceException("表单不能为空");
		}
		if ((operatorState.equals("update")) && (packageConfig.getPackageConfigId() == null)) {
			throw new ServiceException("序号不能为空");
		}

		if (isBlank(packageConfig.getApplyFrame())) {
			throw new ServiceException("适用框架不能为空");
		}
		if (isBlank(packageConfig.getPackageName())) {
			throw new ServiceException("包名称不能为空");
		}
		String fistleter = packageConfig.getPackageName().substring(0, 1).toUpperCase();
		packageConfig.setPackageName(
				fistleter + packageConfig.getPackageName().substring(1, packageConfig.getPackageName().length()));
		if (isBlank(packageConfig.getPackagePath())) {
			throw new ServiceException("包路径不能为空");
		}
		if (!packageConfig.getPackagePath().contains(".")) {
			throw new ServiceException("包路径必须包含点!");
		}
		if (!packageConfig.getPackagePath().contains("[replace]")) {
			throw new ServiceException("包路径必须包含'[replace]',用于替换项目名!");
		}
		packageConfig.setPackagePath(packageConfig.getPackagePath().toLowerCase());
		if (isBlank(packageConfig.getMemo()))
			throw new ServiceException("备注不能为空");
	}

	public Integer insertPackageConfig(PackageConfig packageConfig) {
		validation(packageConfig, "insert");
		try {
			this.packageConfigMapper.insert(packageConfig);
			return packageConfig.getPackageConfigId();
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.insertPackageConfig [ " + packageConfig + " ] 添加失败", e);
		}
		throw new ServiceException("添加失败");
	}

	public Integer updatePackageConfig(PackageConfig packageConfig) {
		validation(packageConfig, "update");
		try {
			return this.packageConfigMapper.update(packageConfig);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.updatePackageConfig [ " + packageConfig + " ] 修改失败", e);
		}
		throw new ServiceException("修改失败");
	}

	public Integer deletePackageConfig(Integer packageConfigId) {
		try {
			return this.packageConfigMapper.delete(packageConfigId);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.deletePackageConfig [ " + packageConfigId + " ] 删除失败", e);
		}
		throw new ServiceException("删除失败");
	}

	public void deletePackageConfigs(String id) {
		try {
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++)
				this.packageConfigMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.deletePackageConfigs [ " + id + " ] 批量删除失败", e);
			throw new ServiceException("批量删除失败");
		}
	}

	public PackageConfig querySinglePackageConfig(Integer packageConfigId) {
		try {
			return (PackageConfig) this.packageConfigMapper.querySingleObject(packageConfigId);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.querySinglePackageConfig [ " + packageConfigId + " ] 查询对象失败", e);
		}
		throw new ServiceException("查询对象失败");
	}

	public Integer queryPackageConfigCount(PackageConfig packageConfig) {
		try {
			return this.packageConfigMapper.queryObjectCount(packageConfig);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.queryPackageConfigCount [ " + packageConfig + " ] 查询条数失败", e);
		}
		throw new ServiceException("查询条数失败");
	}

	public List<PackageConfig> queryPackageConfigList(PackageConfig packageConfig) {
		try {
			return this.packageConfigMapper.queryObjectList(packageConfig);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.queryPackageConfigList [ " + packageConfig + " ] 查询列表失败", e);
		}
		throw new ServiceException("查询列表失败");
	}

	public List<String> queryPackageConfigSelectByApplyFrame(String applyFrame) {
		try {
			List packageConfigList = queryPackageConfigListForColumnName("applyFrame", applyFrame);
			List list = new ArrayList();
			if ((packageConfigList != null) && (packageConfigList.size() > 0)) {
				for (int i = 0; i < packageConfigList.size(); i++) {
					PackageConfig p = (PackageConfig) packageConfigList.get(i);
					String value = "<option value='" + p.getPackageName() + "'>" + p.getPackageName() + ":java"
							+ "</option>";
					list.add(value);
				}
			}
			Config config = null;
			if (applyFrame.equals("SSH"))
				config = this.configService.queryConfigListForColumnName("configName", "SSHTemplateMap");
			else if (applyFrame.equals("SM")) {
				config = this.configService.queryConfigListForColumnName("configName", "SMTemplateMap");
			}
			if (config != null) {
				String[] configValues = config.getConfigValue().split(",");
				for (int i = 0; i < configValues.length; i++) {
					String value = "<option value='" + configValues[i].split(":")[0] + "'>" + configValues[i]
							+ "</option>";
					list.add(value);
				}
			}
			return list;
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.queryPackageConfigSelect 查询下拉框列表失败", e);
		}
		throw new ServiceException("查询下拉框列表失败");
	}

	public List<PackageConfig> queryPackageConfigListForColumnName(String columnName, String columnValue) {
		try {
			Map map = new HashMap();
			map.put("columnName", columnName);
			map.put("columnValue", columnValue);
			return this.packageConfigMapper.queryObjectListForColumnName(map);
		} catch (Exception e) {
			LOG.error("PackageConfigServiceImpl.queryPackageConfigListForColumnName 根据字段查询失败", e);
		}
		throw new ServiceException("根据字段查询失败");
	}
}
