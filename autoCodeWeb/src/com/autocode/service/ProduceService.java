package com.autocode.service;

import com.autocode.bean.Produce;
import java.util.List;

public abstract interface ProduceService
{
  public abstract Integer insertProduce(Produce paramProduce);

  public abstract Integer updateProduce(Produce paramProduce);

  public abstract Integer deleteProduce(Integer paramInteger);

  public abstract void deleteProduces(String paramString);

  public abstract Produce querySingleProduce(Integer paramInteger);

  public abstract Integer queryProduceCount(Produce paramProduce);

  public abstract List<Produce> queryProduceList(Produce paramProduce);

  public abstract List<Produce> queryProduceSelect();

  public abstract List<Produce> queryProduceListForColumnName(String paramString1, String paramString2);
}

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.ProduceService
 * JD-Core Version:    0.6.2
 */