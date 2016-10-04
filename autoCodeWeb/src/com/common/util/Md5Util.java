/*    */ package com.common.util;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.security.MessageDigest;
/*    */ import sun.misc.BASE64Encoder;
/*    */ 
/*    */ public class Md5Util
/*    */ {
/*    */   public static String getMd5(String str)
/*    */   {
/* 16 */     String md5 = "";
/* 17 */     if ((str == null) || (str.equals("")))
/* 18 */       return null;
/*    */     try
/*    */     {
/* 21 */       MessageDigest md = MessageDigest.getInstance("MD5");
/* 22 */       BASE64Encoder base = new BASE64Encoder();
/* 23 */       md5 = base.encode(md.digest(str.getBytes("utf-8")));
/*    */     } catch (Exception e) {
/* 25 */       e.printStackTrace();
/*    */     }
/* 27 */     return md5;
/*    */   }
/*    */ 
/*    */   public static void main(String[] args) {
/* 31 */     System.err.println(getMd5("root"));
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.Md5Util
 * JD-Core Version:    0.6.2
 */