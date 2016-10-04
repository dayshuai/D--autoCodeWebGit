package com.autocode.mapper;

import com.autocode.base.BaseMapper;
import com.autocode.bean.PackageConvert;
import java.util.List;

public abstract interface PackageConvertMapper extends BaseMapper<PackageConvert>
{
  public abstract List<PackageConvert> queryObjectListByColumns(PackageConvert paramPackageConvert);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.mapper.PackageConvertMapper
 * JD-Core Version:    0.6.2
 */