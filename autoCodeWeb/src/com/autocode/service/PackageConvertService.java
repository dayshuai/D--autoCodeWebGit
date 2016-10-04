package com.autocode.service;

import com.autocode.bean.PackageConvert;
import java.util.List;

public abstract interface PackageConvertService
{
  public abstract Integer insertPackageConvert(PackageConvert paramPackageConvert);

  public abstract Integer updatePackageConvert(PackageConvert paramPackageConvert);

  public abstract Integer deletePackageConvert(Integer paramInteger);

  public abstract void deletePackageConverts(String paramString);

  public abstract PackageConvert querySinglePackageConvert(Integer paramInteger);

  public abstract Integer queryPackageConvertCount(PackageConvert paramPackageConvert);

  public abstract List<PackageConvert> queryPackageConvertList(PackageConvert paramPackageConvert);

  public abstract List<PackageConvert> queryPackageConvertSelect();
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.PackageConvertService
 * JD-Core Version:    0.6.2
 */