package com.autocode.service;

import com.autocode.bean.ColumnConvert;
import java.util.List;

public abstract interface ColumnConvertService
{
  public abstract Integer insertColumnConvert(ColumnConvert paramColumnConvert);

  public abstract Integer updateColumnConvert(ColumnConvert paramColumnConvert);

  public abstract Integer deleteColumnConvert(Integer paramInteger);

  public abstract void deleteColumnConverts(String paramString);

  public abstract ColumnConvert querySingleColumnConvert(Integer paramInteger);

  public abstract Integer queryColumnConvertCount(ColumnConvert paramColumnConvert);

  public abstract List<ColumnConvert> queryColumnConvertList(ColumnConvert paramColumnConvert);

  public abstract List<ColumnConvert> queryColumnConvertSelect();

  public abstract List<ColumnConvert> queryColumnConvertListForColumnName(String paramString1, String paramString2);

  public abstract List<ColumnConvert> queryColumnConvertListForRepeat();
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.ColumnConvertService
 * JD-Core Version:    0.6.2
 */