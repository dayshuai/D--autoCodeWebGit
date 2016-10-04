/*    */ package com.common.util;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.FileNotFoundException;
/*    */ import java.io.FileOutputStream;
/*    */ import java.io.IOException;
/*    */ import java.io.InputStream;
/*    */ import java.io.OutputStream;
/*    */ import java.io.PrintStream;
/*    */ import java.net.URL;
/*    */ import java.util.Properties;
/*    */ import org.springframework.core.io.ClassPathResource;
/*    */ 
/*    */ public class PropertiesUtil
/*    */ {
/* 21 */   private static Properties prop = new Properties();
/*    */ 
/* 23 */   private static PropertiesUtil instance = null;
/*    */   private static final String fileName = "/config.properties";
/* 27 */   private static String filePath = "";
/*    */ 
/*    */   public PropertiesUtil()
/*    */   {
/*    */     try
/*    */     {
/* 34 */       InputStream is = getClass().getResourceAsStream("/config.properties");
/* 35 */       ClassPathResource resource = new ClassPathResource("/config.properties");
/* 36 */       filePath = resource.getURL().getPath().replace("20%", "");
/* 37 */       prop.load(is);
/* 38 */       if (is != null)
/* 39 */         is.close();
/*    */     }
/*    */     catch (IOException e) {
/* 42 */       e.printStackTrace();
/*    */     }
/*    */   }
/*    */ 
/*    */   public static String getValue(String key) {
/* 47 */     if (instance == null) {
/* 48 */       instance = new PropertiesUtil();
/*    */     }
/* 50 */     return prop.getProperty(key);
/*    */   }
/*    */ 
/*    */   public static void setValue(String key, String value) {
/*    */     try {
/* 55 */       ClassPathResource resource = new ClassPathResource("/config.properties");
/* 56 */       filePath = resource.getURL().getPath().replace("20%", "");
/* 57 */       OutputStream fos = null;
/*    */       try {
/* 59 */         fos = new FileOutputStream(new File(filePath));
/* 60 */         prop.setProperty(key, value);
/* 61 */         prop.store(fos, "");
/*    */       } catch (FileNotFoundException e) {
/* 63 */         e.printStackTrace();
/*    */       } catch (IOException e) {
/* 65 */         e.printStackTrace();
/*    */       } finally {
/* 67 */         if (fos != null)
/* 68 */           fos.close();
/*    */       }
/*    */     } catch (IOException e) {
/* 71 */       e.printStackTrace();
/*    */     }
/*    */   }
/*    */ 
/*    */   public static void main(String[] args) {
/* 76 */     setValue("wamPwd", "sPUMxMjAxNTIw\n");
/* 77 */     System.out.println(getValue("wamPwd"));
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.PropertiesUtil
 * JD-Core Version:    0.6.2
 */