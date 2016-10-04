package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.DatabaseConvert;
import java.util.List;

public abstract interface DatabaseConvertMapper extends BaseMapper<DatabaseConvert>
{
  public abstract List<DatabaseConvert> queryObjectListByColumns(DatabaseConvert paramDatabaseConvert);

  public abstract List<DatabaseConvert> queryObjectListByDatabaseType(String paramString);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.mapper.DatabaseConvertMapper
 * JD-Core Version:    0.6.2
 */