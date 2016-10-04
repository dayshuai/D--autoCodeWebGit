/*    */ package com.autocode.util;
/*    */ 
/*    */ import java.text.SimpleDateFormat;
/*    */ import java.util.Date;
/*    */ 
/*    */ public class DateTimeUtil
/*    */ {
/*    */   public static String FormatSystemDateSN()
/*    */   {
/* 10 */     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
/* 11 */     return sdf.format(new Date());
/*    */   }
/*    */ 
/*    */   public static String FormatWithTime(Date date)
/*    */   {
/* 16 */     if (date == null)
/* 17 */       return "";
/* 18 */     return Format(date, "yyyy-MM-dd HH:mm:ss");
/*    */   }
/*    */ 
/*    */   public static String FormatNoTime(Date date)
/*    */   {
/* 23 */     if (date == null)
/* 24 */       return "";
/* 25 */     return Format(date, "yyyy-MM-dd");
/*    */   }
/*    */ 
/*    */   public static String Format(Date date, String formatString)
/*    */   {
/* 30 */     if (date == null)
/* 31 */       return "";
/* 32 */     SimpleDateFormat formatter = new SimpleDateFormat(formatString);
/* 33 */     return formatter.format(date);
/*    */   }
/*    */ 
/*    */   public static String FormatCurrentDateTime()
/*    */   {
/* 38 */     Date date = new Date(System.currentTimeMillis());
/* 39 */     return Format(date, "yyyy-MM-dd HH:mm:ss");
/*    */   }
/*    */ 
/*    */   public static String FormatCurrentDate()
/*    */   {
/* 44 */     Date date = new Date(System.currentTimeMillis());
/* 45 */     return Format(date, "yyyy-MM-dd");
/*    */   }
/*    */ 
/*    */   public static Date CurrentDateTime()
/*    */   {
/* 50 */     return new Date(System.currentTimeMillis());
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.DateTimeUtil
 * JD-Core Version:    0.6.2
 */