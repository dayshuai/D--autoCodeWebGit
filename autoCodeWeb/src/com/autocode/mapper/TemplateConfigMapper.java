package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.TemplateConfig;
import java.util.List;
import java.util.Map;

public abstract interface TemplateConfigMapper extends BaseMapper<TemplateConfig> {
	public abstract List<TemplateConfig> queryObjectListForRepeat(Map<String, Object> paramMap);

	public abstract Integer deleteObjectByTemplateId(Integer paramInteger);

	public abstract List<TemplateConfig> templateConfigSelectByTemplateId(Integer paramInteger);
}

/*
 * Location: C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\ Qualified
 * Name: com.autocode.mapper.TemplateConfigMapper JD-Core Version: 0.6.2
 */