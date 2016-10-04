/*    */ package com.autocode.util;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import java.security.MessageDigest;
/*    */ import sun.misc.BASE64Encoder;
/*    */ 
/*    */ public class Md5Util
/*    */ {
/*    */   public static String getMd5(String password)
/*    */   {
/* 10 */     String str = "";
/* 11 */     if ((password != null) && (!password.equals(""))) {
/*    */       try {
/* 13 */         MessageDigest md = MessageDigest.getInstance("MD5");
/* 14 */         BASE64Encoder base = new BASE64Encoder();
/*    */ 
/* 16 */         str = base.encode(md.digest(password.getBytes("utf-8")));
/*    */       } catch (Exception e) {
/* 18 */         e.printStackTrace();
/*    */       }
/*    */     }
/* 21 */     return str;
/*    */   }
/*    */   public static void main(String[] args) {
/* 24 */     System.err.println(getMd5("root"));
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.Md5Util
 * JD-Core Version:    0.6.2
 */