/*    */ package com.common.util;
/*    */ 
/*    */ import java.text.SimpleDateFormat;
/*    */ import java.util.Date;
/*    */ import org.springframework.beans.propertyeditors.CustomDateEditor;
/*    */ import org.springframework.web.bind.WebDataBinder;
/*    */ import org.springframework.web.bind.support.WebBindingInitializer;
/*    */ import org.springframework.web.context.request.WebRequest;
/*    */ 
/*    */ public class MvcDateConverter
/*    */   implements WebBindingInitializer
/*    */ {
/*    */   public void initBinder(WebDataBinder binder, WebRequest request)
/*    */   {
/*    */     try
/*    */     {
/* 15 */       SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
/* 16 */       binder.registerCustomEditor(Date.class, new CustomDateEditor(df, 
/* 17 */         true));
/*    */     } catch (Exception e) {
/* 19 */       SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
/* 20 */       binder.registerCustomEditor(Date.class, new CustomDateEditor(df, 
/* 21 */         true));
/*    */     }
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.MvcDateConverter
 * JD-Core Version:    0.6.2
 */