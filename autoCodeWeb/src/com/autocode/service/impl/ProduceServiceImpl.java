/*     */ package com.autocode.service.impl;
/*     */ 
/*     */ import com.autocode.base.BaseService;
/*     */ import com.autocode.base.ServiceException;
/*     */ import com.autocode.bean.Produce;
/*     */ import com.autocode.mapper.ProduceMapper;
/*     */ import com.autocode.service.ProduceService;
/*     */ import java.util.HashMap;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.stereotype.Service;
/*     */ import org.springframework.transaction.annotation.Transactional;
/*     */ 
/*     */ @Transactional
/*     */ @Service("produceService")
/*     */ public class ProduceServiceImpl extends BaseService
/*     */   implements ProduceService
/*     */ {
/*  22 */   private static final Logger LOG = LoggerFactory.getLogger(ProduceServiceImpl.class);
/*     */ 
/*     */   @Autowired
/*     */   private ProduceMapper produceMapper;
/*     */ 
/*  27 */   private void validation(Produce produce, String operatorState) { if (produce == null) {
/*  28 */       throw new ServiceException("表单不能为空");
/*     */     }
/*  30 */     if ((operatorState.equals("update")) && 
/*  31 */       (produce.getProduceId() == null)) {
/*  32 */       throw new ServiceException("序号不能为空");
/*     */     }
/*     */ 
/*  35 */     if (isBlank(produce.getProduceTitle())) {
/*  36 */       throw new ServiceException("标题不能为空");
/*     */     }
/*  38 */     if (isBlank(produce.getProduceName())) {
/*  39 */       throw new ServiceException("生成文件不能为空");
/*     */     }
/*  41 */     if (isBlank(produce.getTableAmount())) {
/*  42 */       throw new ServiceException("表数量不能为空");
/*     */     }
/*  44 */     if (isBlank(produce.getFileAmount())) {
/*  45 */       throw new ServiceException("文件数量不能为空");
/*     */     }
/*  47 */     if (isBlank(produce.getWasteTime())) {
/*  48 */       throw new ServiceException("消耗时间不能为空");
/*     */     }
/*  50 */     if (isBlank(produce.getCreateDate()))
/*  51 */       throw new ServiceException("创建时间不能为空");
/*     */   }
/*     */ 
/*     */   public Integer insertProduce(Produce produce)
/*     */   {
/*  57 */     validation(produce, "insert");
/*     */     try {
/*  59 */       this.produceMapper.insert(produce);
/*  60 */       return produce.getProduceId();
/*     */     } catch (Exception e) {
/*  62 */       LOG.error("ProduceServiceImpl.insertProduce [ " + produce + " ] 添加失败", e);
/*  63 */     }throw new ServiceException("添加失败");
/*     */   }
/*     */ 
/*     */   public Integer updateProduce(Produce produce)
/*     */   {
/*  69 */     validation(produce, "update");
/*     */     try {
/*  71 */       return this.produceMapper.update(produce);
/*     */     } catch (Exception e) {
/*  73 */       LOG.error("ProduceServiceImpl.updateProduce [ " + produce + " ] 修改失败", e);
/*  74 */     }throw new ServiceException("修改失败");
/*     */   }
/*     */ 
/*     */   public Integer deleteProduce(Integer produceId)
/*     */   {
/*     */     try
/*     */     {
/*  81 */       return this.produceMapper.delete(produceId);
/*     */     } catch (Exception e) {
/*  83 */       LOG.error("ProduceServiceImpl.deleteProduce [ " + produceId + " ] 删除失败", e);
/*  84 */     }throw new ServiceException("删除失败");
/*     */   }
/*     */ 
/*     */   public void deleteProduces(String id)
/*     */   {
/*     */     try
/*     */     {
/*  91 */       String[] ids = id.split(",");
/*  92 */       for (int i = 0; i < ids.length; i++)
/*  93 */         this.produceMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
/*     */     }
/*     */     catch (Exception e) {
/*  96 */       LOG.error("ProduceServiceImpl.deleteProduces [ " + id + " ] 批量删除失败", e);
/*  97 */       throw new ServiceException("批量删除失败");
/*     */     }
/*     */   }
/*     */ 
/*     */   public Produce querySingleProduce(Integer produceId)
/*     */   {
/*     */     try {
/* 104 */       return (Produce)this.produceMapper.querySingleObject(produceId);
/*     */     } catch (Exception e) {
/* 106 */       LOG.error("ProduceServiceImpl.querySingleProduce [ " + produceId + " ] 查询对象失败", e);
/* 107 */     }throw new ServiceException("查询对象失败");
/*     */   }
/*     */ 
/*     */   public Integer queryProduceCount(Produce produce)
/*     */   {
/*     */     try
/*     */     {
/* 114 */       return this.produceMapper.queryObjectCount(produce);
/*     */     } catch (Exception e) {
/* 116 */       LOG.error("ProduceServiceImpl.queryProduceCount [ " + produce + " ] 查询条数失败", e);
/* 117 */     }throw new ServiceException("查询条数失败");
/*     */   }
/*     */ 
/*     */   public List<Produce> queryProduceList(Produce produce)
/*     */   {
/*     */     try
/*     */     {
/* 124 */       return this.produceMapper.queryObjectList(produce);
/*     */     } catch (Exception e) {
/* 126 */       LOG.error("ProduceServiceImpl.queryProduceList [ " + produce + " ] 查询列表失败", e);
/* 127 */     }throw new ServiceException("查询列表失败");
/*     */   }
/*     */ 
/*     */   public List<Produce> queryProduceSelect()
/*     */   {
/*     */     try
/*     */     {
/* 134 */       return this.produceMapper.queryObjectSelect();
/*     */     } catch (Exception e) {
/* 136 */       LOG.error("ProduceServiceImpl.queryProduceSelect 查询下拉框列表失败", e);
/* 137 */     }throw new ServiceException("查询下拉框列表失败");
/*     */   }
/*     */ 
/*     */   public List<Produce> queryProduceListForColumnName(String columnName, String columnValue)
/*     */   {
/*     */     try
/*     */     {
/* 144 */       Map map = new HashMap();
/* 145 */       map.put("columnName", columnName);
/* 146 */       map.put("columnValue", columnValue);
/* 147 */       return this.produceMapper.queryObjectListForColumnName(map);
/*     */     } catch (Exception e) {
/* 149 */       LOG.error("ProduceServiceImpl.queryProduceListForColumnName 根据字段查询失败", e);
/* 150 */     }throw new ServiceException("根据字段查询失败");
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.impl.ProduceServiceImpl
 * JD-Core Version:    0.6.2
 */