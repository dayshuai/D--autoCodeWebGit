package com.autocode.service;

import com.autocode.bean.Template;
import java.util.List;

public abstract interface TemplateService {
	public abstract Integer insertTemplate(Template paramTemplate);

	public abstract Integer updateTemplate(Template paramTemplate);

	public abstract Integer deleteTemplate(Integer paramInteger, String paramString);

	public abstract void deleteTemplates(String paramString1, String paramString2);

	public abstract Template querySingleTemplate(Integer paramInteger);

	public abstract Integer queryTemplateCount(Template paramTemplate);

	public abstract List<Template> queryTemplateList(Template paramTemplate);

	public abstract List<String> queryTemplateSelect(String paramString);

	public abstract List<Template> queryTemplateListForColumnName(String paramString1, String paramString2);
}

/*
 * Location: C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\ Qualified
 * Name: com.autocode.service.TemplateService JD-Core Version: 0.6.2
 */