/*     */ package com.common.util;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ import java.security.Key;
/*     */ import java.security.SecureRandom;
/*     */ import javax.crypto.Cipher;
/*     */ import javax.crypto.SecretKey;
/*     */ import javax.crypto.SecretKeyFactory;
/*     */ import javax.crypto.spec.DESKeySpec;
/*     */ import org.apache.commons.codec.binary.Base64;
/*     */ 
/*     */ public class DesUtil
/*     */ {
/*     */   public static final String KEY_ALGORITHM = "DES";
/*     */   public static final String CIPHER_ALGORITHM = "DES/ECB/NoPadding";
/*     */ 
/*     */   private static SecretKey keyGenerator(String keyStr)
/*     */     throws Exception
/*     */   {
/*  40 */     byte[] input = HexString2Bytes(keyStr);
/*  41 */     DESKeySpec desKey = new DESKeySpec(input);
/*     */ 
/*  43 */     SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
/*  44 */     SecretKey securekey = keyFactory.generateSecret(desKey);
/*  45 */     return securekey;
/*     */   }
/*     */ 
/*     */   private static int parse(char c) {
/*  49 */     if (c >= 'a') return c - 'a' + 10 & 0xF;
/*  50 */     if (c >= 'A') return c - 'A' + 10 & 0xF;
/*  51 */     return c - '0' & 0xF;
/*     */   }
/*     */ 
/*     */   public static byte[] HexString2Bytes(String hexstr)
/*     */   {
/*  56 */     byte[] b = new byte[hexstr.length() / 2];
/*  57 */     int j = 0;
/*  58 */     for (int i = 0; i < b.length; i++) {
/*  59 */       char c0 = hexstr.charAt(j++);
/*  60 */       char c1 = hexstr.charAt(j++);
/*  61 */       b[i] = ((byte)(parse(c0) << 4 | parse(c1)));
/*     */     }
/*  63 */     return b;
/*     */   }
/*     */ 
/*     */   public static String encrypt(String data, String key)
/*     */     throws Exception
/*     */   {
/*  73 */     Key deskey = keyGenerator(key);
/*     */ 
/*  75 */     Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
/*  76 */     SecureRandom random = new SecureRandom();
/*     */ 
/*  78 */     cipher.init(1, deskey, random);
/*  79 */     byte[] results = cipher.doFinal(data.getBytes());
/*     */ 
/*  81 */     return Base64.encodeBase64String(results);
/*     */   }
/*     */ 
/*     */   public static String decrypt(String data, String key)
/*     */     throws Exception
/*     */   {
/*  91 */     Key deskey = keyGenerator(key);
/*  92 */     Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
/*     */ 
/*  94 */     cipher.init(2, deskey);
/*     */ 
/*  96 */     return new String(cipher.doFinal(Base64.decodeBase64(data)));
/*     */   }
/*     */ 
/*     */   public static void main(String[] args) throws Exception {
/* 100 */     String source = "ASDFGHJKLMNBVCXZ";
/* 101 */     System.out.println("原文: " + source);
/* 102 */     String key = "fdafdteqzfvcxv51h56rh8r4";
/* 103 */     String encryptData = encrypt(source, key);
/* 104 */     System.out.println("加密后: " + encryptData);
/* 105 */     String decryptData = decrypt(encryptData, key);
/* 106 */     System.out.println("解密后: " + decryptData);
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.DesUtil
 * JD-Core Version:    0.6.2
 */