package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.Control;
import java.util.List;

public abstract interface ControlMapper extends BaseMapper<Control>
{
  public abstract Integer deleteObjectByProjectId(Integer paramInteger);

  public abstract Integer deleteObjectByTableId(Integer paramInteger);

  public abstract List<Control> queryObjectListByProjectId(Integer paramInteger);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.mapper.ControlMapper
 * JD-Core Version:    0.6.2
 */