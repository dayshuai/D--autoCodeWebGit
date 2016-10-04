/*    */ package com.autocode.controller;
/*    */ 
/*    */ import com.autocode.base.BaseController;
/*    */ import com.autocode.base.Pagination;
/*    */ import com.autocode.base.ServiceException;
/*    */ import com.autocode.bean.Config;
/*    */ import com.autocode.service.ConfigService;
/*    */ import java.util.List;
/*    */ import java.util.Map;
/*    */ import javax.inject.Inject;
/*    */ import org.slf4j.Logger;
/*    */ import org.slf4j.LoggerFactory;
/*    */ import org.springframework.stereotype.Controller;
/*    */ import org.springframework.ui.Model;
/*    */ import org.springframework.web.bind.annotation.RequestMapping;
/*    */ import org.springframework.web.bind.annotation.ResponseBody;
/*    */ 
/*    */ @Controller
/*    */ @RequestMapping({"/config"})
/*    */ public class ConfigController extends BaseController
/*    */ {
/* 24 */   private static final Logger LOG = LoggerFactory.getLogger(ConfigController.class);
/*    */ 
/*    */   @Inject
/*    */   private ConfigService configService;
/*    */ 
/* 30 */   @RequestMapping
/*    */   public String index(Model model) { model.addAttribute("nav_3", "onnav");
/* 31 */     model.addAttribute("config", "focus");
/* 32 */     return "config"; }
/*    */ 
/*    */   @ResponseBody
/*    */   @RequestMapping({"insertConfig"})
/*    */   public Map<String, Object> insertConfig(Model model, Config config) {
/*    */     try {
/* 39 */       this.configService.insertConfig(config);
/*    */     } catch (Exception e) {
/* 41 */       LOG.error("ConfigController[添加失败]", e);
/* 42 */       return resultFalse(e.getMessage());
/*    */     }
/* 44 */     return resultTrue();
/*    */   }
/*    */   @ResponseBody
/*    */   @RequestMapping({"updateConfig"})
/*    */   public Map<String, Object> updateConfig(Model model, Config config) {
/*    */     try {
/* 51 */       this.configService.updateConfig(config);
/*    */     } catch (Exception e) {
/* 53 */       LOG.error("ConfigController[修改失败]", e);
/* 54 */       return resultFalse(e.getMessage());
/*    */     }
/* 56 */     return resultTrue();
/*    */   }
/*    */   @ResponseBody
/*    */   @RequestMapping({"deleteConfig"})
/*    */   public Map<String, Object> deleteConfig(Model model, Integer configId) {
/*    */     try {
/* 63 */       this.configService.deleteConfig(configId);
/*    */     } catch (Exception e) {
/* 65 */       LOG.error("ConfigController[删除失败]", e);
/* 66 */       return resultFalse(e.getMessage());
/*    */     }
/* 68 */     return resultTrue();
/*    */   }
/*    */   @ResponseBody
/*    */   @RequestMapping({"deleteConfigs"})
/*    */   public Map<String, Object> deleteConfigs(Model model, String ids) {
/*    */     try {
/* 75 */       this.configService.deleteConfigs(ids);
/*    */     } catch (Exception e) {
/* 77 */       LOG.error("ConfigController[删除多个失败]", e);
/* 78 */       return resultFalse(e.getMessage());
/*    */     }
/* 80 */     return resultTrue();
/*    */   }
/*    */   @ResponseBody
/*    */   @RequestMapping({"queryConfigList"})
/*    */   public Pagination queryConfigList(Model model, Config config) {
/*    */     try {
/* 87 */       Integer totalCount = this.configService.queryConfigCount(config);
/* 88 */       List dataList = this.configService.queryConfigList(config);
/* 89 */       return new Pagination(config, totalCount, dataList);
/*    */     } catch (ServiceException e) {
/* 91 */       LOG.error("ConfigController[查询列表失败]", e);
/*    */     }
/* 93 */     return new Pagination("查询列表异常");
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.controller.ConfigController
 * JD-Core Version:    0.6.2
 */