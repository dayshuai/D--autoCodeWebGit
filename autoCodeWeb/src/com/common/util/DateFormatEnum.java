/*    */ package com.common.util;
/*    */ 
/*    */ public enum DateFormatEnum
/*    */ {
/*  5 */   SIMPLE("yyyy-MM-dd HH:mm:ss", "", "", ""), 
/*    */ 
/*  8 */   DT_SIMPLE_CHINESE("yyyy年MM月dd日", "", "", ""), 
/*    */ 
/* 11 */   DT_SIMPLE("yyyy-MM-dd", "", "", ""), 
/*    */ 
/* 14 */   DT_SHORT("yyyyMMdd", "", "", ""), 
/*    */ 
/* 17 */   DT_LONG("yyyyMMddHHmmss", "", "", ""), 
/*    */ 
/* 20 */   HMS("HH:mm:ss", "", "", ""), 
/*    */ 
/* 23 */   SIMPLE_NO_S("yyyy-MM-dd HH:mm", "", "", ""), 
/*    */ 
/* 26 */   DT_LONG_MILL("yyyyMMddHHmmssS", "", "", "");
/*    */ 
/*    */   private final String code;
/*    */   private final String englishName;
/*    */   private final String chineseName;
/*    */   private final String description;
/*    */ 
/*    */   private DateFormatEnum(String code, String englishName, String chineseName, String description)
/*    */   {
/* 55 */     this.code = code;
/* 56 */     this.englishName = englishName;
/* 57 */     this.chineseName = chineseName;
/* 58 */     this.description = description;
/*    */   }
/*    */ 
/*    */   public String getCode() {
/* 62 */     return this.code;
/*    */   }
/*    */ 
/*    */   public String getEnglishName() {
/* 66 */     return this.englishName;
/*    */   }
/*    */ 
/*    */   public String getChineseName() {
/* 70 */     return this.chineseName;
/*    */   }
/*    */ 
/*    */   public String getDescription() {
/* 74 */     return this.description;
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.DateFormatEnum
 * JD-Core Version:    0.6.2
 */