package com.autocode.service;

import com.autocode.bean.TemplateConfig;
import java.util.List;

public abstract interface TemplateConfigService {
	public abstract Integer insertTemplateConfig(TemplateConfig paramTemplateConfig);

	public abstract Integer updateTemplateConfig(TemplateConfig paramTemplateConfig);

	public abstract Integer deleteTemplateConfig(Integer paramInteger);

	public abstract void deleteTemplateConfigs(String paramString);

	public abstract TemplateConfig querySingleTemplateConfig(Integer paramInteger);

	public abstract Integer queryTemplateConfigCount(TemplateConfig paramTemplateConfig);

	public abstract List<TemplateConfig> queryTemplateConfigList(TemplateConfig paramTemplateConfig);

	public abstract List<TemplateConfig> queryTemplateConfigSelect();

	public abstract List<TemplateConfig> queryTemplateConfigListForColumnName(String paramString, Object paramObject);

	public abstract Integer deleteTemplateConfigByTemplateId(Integer paramInteger);

	public abstract List<String> templateConfigSelectByTemplateId(Integer paramInteger);
}

/*
 * Location: C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\ Qualified
 * Name: com.autocode.service.TemplateConfigService JD-Core Version: 0.6.2
 */