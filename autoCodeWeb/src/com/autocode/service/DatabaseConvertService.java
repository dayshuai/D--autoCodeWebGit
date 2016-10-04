package com.autocode.service;

import com.autocode.bean.DatabaseConvert;
import java.util.List;

public abstract interface DatabaseConvertService
{
  public abstract Integer insertDatabaseConvert(DatabaseConvert paramDatabaseConvert);

  public abstract Integer updateDatabaseConvert(DatabaseConvert paramDatabaseConvert);

  public abstract Integer deleteDatabaseConvert(Integer paramInteger);

  public abstract void deleteDatabaseConverts(String paramString);

  public abstract DatabaseConvert querySingleDatabaseConvert(Integer paramInteger);

  public abstract Integer queryDatabaseConvertCount(DatabaseConvert paramDatabaseConvert);

  public abstract List<DatabaseConvert> queryDatabaseConvertList(DatabaseConvert paramDatabaseConvert);

  public abstract List<DatabaseConvert> queryDatabaseConvertSelect();

  public abstract List<DatabaseConvert> queryDatabaseConvertListByDatabaseType(String paramString);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.DatabaseConvertService
 * JD-Core Version:    0.6.2
 */