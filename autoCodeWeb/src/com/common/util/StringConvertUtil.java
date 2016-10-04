/*    */ package com.common.util;
/*    */ 
/*    */ public class StringConvertUtil
/*    */ {
/*    */   public static String firstLetterToLower(String str)
/*    */   {
/* 16 */     if (str == null) {
/* 17 */       return null;
/*    */     }
/* 19 */     return String.valueOf(str.charAt(0)).toLowerCase() + str.substring(1, str.length());
/*    */   }
/*    */ 
/*    */   public static String firstLetterToUpper(String str)
/*    */   {
/* 29 */     if (str == null) {
/* 30 */       return null;
/*    */     }
/* 32 */     return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1, str.length());
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.StringConvertUtil
 * JD-Core Version:    0.6.2
 */