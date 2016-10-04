package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.Column;
import java.util.List;
import java.util.Map;

public abstract interface ColumnMapper extends BaseMapper<Column>
{
  public abstract Integer deleteObjectByTableId(Integer paramInteger);

  public abstract Integer queryObjectCountByTableId(Integer paramInteger);

  public abstract List<Column> queryObjectListByTableIds(List<Integer> paramList);

  public abstract Integer deleteObjectByProjectId(Integer paramInteger);

  public abstract List<Column> queryObjectListForConvertError(Map<String, Object> paramMap);

  public abstract List<Column> queryObjectListByTableId(Integer paramInteger);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.mapper.ColumnMapper
 * JD-Core Version:    0.6.2
 */