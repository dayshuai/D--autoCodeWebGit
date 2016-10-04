package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.Table;
import java.util.List;
import java.util.Map;

public abstract interface TableMapper extends BaseMapper<Table>
{
  public abstract List<Table> queryObjectListByColumns(Table paramTable);

  public abstract List<Table> queryObjectListByProjectId(Integer paramInteger);

  public abstract List<Table> queryObjectListByModuleId(Integer paramInteger);

  public abstract List<Integer> queryObjectListIdsByProjectId(Integer paramInteger);

  public abstract List<Table> queryTableSelectByProjectId(Integer paramInteger);

  public abstract Integer deleteObjectByProjectId(Integer paramInteger);

  public abstract List<Table> queryObjectListForConvertError(Map<String, Object> paramMap);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.mapper.TableMapper
 * JD-Core Version:    0.6.2
 */