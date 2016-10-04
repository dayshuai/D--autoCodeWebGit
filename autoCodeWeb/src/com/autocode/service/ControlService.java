package com.autocode.service;

import com.autocode.bean.Control;
import java.util.List;

public abstract interface ControlService
{
  public abstract Integer insertControl(Control paramControl);

  public abstract Integer updateControl(Control paramControl);

  public abstract Integer deleteControl(Integer paramInteger);

  public abstract void deleteControls(String paramString);

  public abstract Control querySingleControl(Integer paramInteger);

  public abstract Integer queryControlCount(Control paramControl);

  public abstract List<Control> queryControlList(Control paramControl);

  public abstract List<Control> queryControlSelect();

  public abstract Integer deleteControlByProjectId(Integer paramInteger);

  public abstract Integer deleteControlByTableId(Integer paramInteger);

  public abstract List<Control> queryControlListByProjectId(Integer paramInteger);

  public abstract Control querySingleControlByColumnName(String paramString, Integer paramInteger);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.ControlService
 * JD-Core Version:    0.6.2
 */