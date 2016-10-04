package com.autocode.service;

import com.autocode.bean.PackageConfig;
import java.util.List;

public abstract interface PackageConfigService {
	public abstract Integer insertPackageConfig(PackageConfig paramPackageConfig);

	public abstract Integer updatePackageConfig(PackageConfig paramPackageConfig);

	public abstract Integer deletePackageConfig(Integer paramInteger);

	public abstract void deletePackageConfigs(String paramString);

	public abstract PackageConfig querySinglePackageConfig(Integer paramInteger);

	public abstract Integer queryPackageConfigCount(PackageConfig paramPackageConfig);

	public abstract List<PackageConfig> queryPackageConfigList(PackageConfig paramPackageConfig);

	public abstract List<String> queryPackageConfigSelectByApplyFrame(String paramString);

	public abstract List<PackageConfig> queryPackageConfigListForColumnName(String paramString1, String paramString2);
}

/*
 * Location: C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\ Qualified
 * Name: com.autocode.service.PackageConfigService JD-Core Version: 0.6.2
 */