/*    */ package com.autocode.util;
/*    */ 
/*    */ public class StringConvertUtil
/*    */ {
/*    */   public static String firstLetterToLower(String str)
/*    */   {
/*  6 */     return String.valueOf(str.charAt(0)).toLowerCase() + str.substring(1, str.length());
/*    */   }
/*    */ 
/*    */   public static String firstLetterToUpper(String str) {
/* 10 */     return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1, str.length());
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.StringConvertUtil
 * JD-Core Version:    0.6.2
 */