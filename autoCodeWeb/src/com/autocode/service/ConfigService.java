package com.autocode.service;

import com.autocode.bean.Config;
import java.util.List;

public abstract interface ConfigService
{
  public abstract Integer insertConfig(Config paramConfig);

  public abstract Integer updateConfig(Config paramConfig);

  public abstract Integer deleteConfig(Integer paramInteger);

  public abstract void deleteConfigs(String paramString);

  public abstract Config querySingleConfig(Integer paramInteger);

  public abstract Integer queryConfigCount(Config paramConfig);

  public abstract List<Config> queryConfigList(Config paramConfig);

  public abstract List<Config> queryConfigSelect();

  public abstract Config queryConfigListForColumnName(String paramString1, String paramString2);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.ConfigService
 * JD-Core Version:    0.6.2
 */