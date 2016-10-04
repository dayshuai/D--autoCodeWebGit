/*     */ package com.autocode.service.impl;
/*     */ 
/*     */ import com.autocode.base.BaseService;
/*     */ import com.autocode.base.ServiceException;
/*     */ import com.autocode.bean.Config;
/*     */ import com.autocode.mapper.ConfigMapper;
/*     */ import com.autocode.service.ConfigService;
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
/*     */ @Service("configService")
/*     */ public class ConfigServiceImpl extends BaseService
/*     */   implements ConfigService
/*     */ {
/*  22 */   private static final Logger LOG = LoggerFactory.getLogger(ConfigServiceImpl.class);
/*     */ 
/*     */   @Autowired
/*     */   private ConfigMapper configMapper;
/*     */ 
/*  27 */   private void validation(Config config, String operatorState) { if (config == null) {
/*  28 */       throw new ServiceException("表单不能为空");
/*     */     }
/*  30 */     if ((operatorState.equals("update")) && 
/*  31 */       (config.getConfigId() == null)) {
/*  32 */       throw new ServiceException("序号不能为空");
/*     */     }
/*     */ 
/*  35 */     if (isBlank(config.getConfigName())) {
/*  36 */       throw new ServiceException("配置名称不能为空");
/*     */     }
/*  38 */     if (isBlank(config.getConfigValue())) {
/*  39 */       throw new ServiceException("配置Value不能为空");
/*     */     }
/*  41 */     if (isBlank(config.getMemo()))
/*  42 */       throw new ServiceException("备注不能为空");
/*     */   }
/*     */ 
/*     */   public Integer insertConfig(Config config)
/*     */   {
/*  48 */     validation(config, "insert");
/*     */     try {
/*  50 */       this.configMapper.insert(config);
/*  51 */       return config.getConfigId();
/*     */     } catch (Exception e) {
/*  53 */       LOG.error("ConfigServiceImpl.insertConfig [ " + config + " ] 添加失败", e);
/*  54 */     }throw new ServiceException("添加失败");
/*     */   }
/*     */ 
/*     */   public Integer updateConfig(Config config)
/*     */   {
/*  60 */     validation(config, "update");
/*     */     try {
/*  62 */       return this.configMapper.update(config);
/*     */     } catch (Exception e) {
/*  64 */       LOG.error("ConfigServiceImpl.updateConfig [ " + config + " ] 修改失败", e);
/*  65 */     }throw new ServiceException("修改失败");
/*     */   }
/*     */ 
/*     */   public Integer deleteConfig(Integer configId)
/*     */   {
/*     */     try
/*     */     {
/*  72 */       return this.configMapper.delete(configId);
/*     */     } catch (Exception e) {
/*  74 */       LOG.error("ConfigServiceImpl.deleteConfig [ " + configId + " ] 删除失败", e);
/*  75 */     }throw new ServiceException("删除失败");
/*     */   }
/*     */ 
/*     */   public void deleteConfigs(String id)
/*     */   {
/*     */     try
/*     */     {
/*  82 */       String[] ids = id.split(",");
/*  83 */       for (int i = 0; i < ids.length; i++)
/*  84 */         this.configMapper.delete(Integer.valueOf(Integer.parseInt(ids[i])));
/*     */     }
/*     */     catch (Exception e) {
/*  87 */       LOG.error("ConfigServiceImpl.deleteConfigs [ " + id + " ] 批量删除失败", e);
/*  88 */       throw new ServiceException("批量删除失败");
/*     */     }
/*     */   }
/*     */ 
/*     */   public Config querySingleConfig(Integer configId)
/*     */   {
/*     */     try {
/*  95 */       return (Config)this.configMapper.querySingleObject(configId);
/*     */     } catch (Exception e) {
/*  97 */       LOG.error("ConfigServiceImpl.querySingleConfig [ " + configId + " ] 查询对象失败", e);
/*  98 */     }throw new ServiceException("查询对象失败");
/*     */   }
/*     */ 
/*     */   public Integer queryConfigCount(Config config)
/*     */   {
/*     */     try
/*     */     {
/* 105 */       return this.configMapper.queryObjectCount(config);
/*     */     } catch (Exception e) {
/* 107 */       LOG.error("ConfigServiceImpl.queryConfigCount [ " + config + " ] 查询条数失败", e);
/* 108 */     }throw new ServiceException("查询条数失败");
/*     */   }
/*     */ 
/*     */   public List<Config> queryConfigList(Config config)
/*     */   {
/*     */     try
/*     */     {
/* 115 */       return this.configMapper.queryObjectList(config);
/*     */     } catch (Exception e) {
/* 117 */       LOG.error("ConfigServiceImpl.queryConfigList [ " + config + " ] 查询列表失败", e);
/* 118 */     }throw new ServiceException("查询列表失败");
/*     */   }
/*     */ 
/*     */   public List<Config> queryConfigSelect()
/*     */   {
/*     */     try
/*     */     {
/* 125 */       return this.configMapper.queryObjectSelect();
/*     */     } catch (Exception e) {
/* 127 */       LOG.error("ConfigServiceImpl.queryConfigSelect 查询下拉框列表失败", e);
/* 128 */     }throw new ServiceException("查询下拉框列表失败");
/*     */   }
/*     */ 
/*     */   public Config queryConfigListForColumnName(String columnName, String columnValue)
/*     */   {
/*     */     try
/*     */     {
/* 135 */       Map map = new HashMap();
/* 136 */       map.put("columnName", columnName);
/* 137 */       map.put("columnValue", columnValue);
/* 138 */       List configList = this.configMapper.queryObjectListForColumnName(map);
/* 139 */       if ((configList != null) && (configList.size() > 0)) {
/* 140 */         return (Config)configList.get(0);
/*     */       }
/* 142 */       return null;
/*     */     } catch (Exception e) {
/* 144 */       LOG.error("ConfigServiceImpl.queryConfigListForColumnName 根据字段查询失败", e);
/* 145 */     }throw new ServiceException("根据字段查询失败");
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.service.impl.ConfigServiceImpl
 * JD-Core Version:    0.6.2
 */