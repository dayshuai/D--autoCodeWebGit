package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.Project;
import java.util.List;

public abstract interface ProjectMapper extends BaseMapper<Project>
{
  public abstract Integer updateAllDefaultNo();

  public abstract List<Project> queryObjectListByIsValidation();
}
