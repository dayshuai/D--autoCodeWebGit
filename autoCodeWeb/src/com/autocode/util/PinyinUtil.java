/*    */ package com.autocode.util;
/*    */ 
/*    */ import java.io.PrintStream;
/*    */ import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
/*    */ import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
/*    */ import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
/*    */ import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
/*    */ import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
/*    */ 
/*    */ public class PinyinUtil
/*    */ {
/* 11 */   private static final HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
/*    */ 
/* 13 */   static { format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
/* 14 */     format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
/* 15 */     format.setVCharType(HanyuPinyinVCharType.WITH_V); }
/*    */ 
/*    */   public static void main(String[] args) {
/* 18 */     System.out.println(getFirstLetterCapital("尼玛比"));
/*    */   }
/*    */ 
/*    */   public static String getFirstLetterCapital(String str) {
/*    */     try {
/* 23 */       StringBuffer sb = new StringBuffer();
/* 24 */       char c = str.charAt(0);
/*    */ 
/* 26 */       if ((c >= '一') && (c <= 40869)) {
/* 27 */         sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0].charAt(0));
/* 28 */         return sb.toString().toUpperCase();
/*    */       }
/* 30 */       String value = str.substring(0, 1);
/* 31 */       if ((value.equals(" ")) || (value.equals(""))) {
/* 32 */         return null;
/*    */       }
/* 34 */       return value.toUpperCase();
/*    */     }
/*    */     catch (BadHanyuPinyinOutputFormatCombination e) {
/* 37 */       e.printStackTrace();
/*    */     }
/* 39 */     return null;
/*    */   }
/*    */ 
/*    */   public static boolean isPinyin(String str) {
/*    */     try {
/* 44 */       if ((str == null) || (str.equals(""))) {
/* 45 */         return false;
/*    */       }
/* 47 */       for (int i = 0; i < str.length(); i++) {
/* 48 */         char c = str.charAt(i);
/*    */ 
/* 50 */         if ((c >= '一') && (c <= 40869))
/* 51 */           return true;
/*    */       }
/*    */     }
/*    */     catch (Exception e) {
/* 55 */       e.printStackTrace();
/*    */     }
/* 57 */     return false;
/*    */   }
/*    */ 
/*    */   public static String getPinyin(String str)
/*    */   {
/*    */     try {
/* 63 */       StringBuffer sb = new StringBuffer();
/* 64 */       for (int i = 0; i < str.length(); i++) {
/* 65 */         char c = str.charAt(i);
/*    */ 
/* 67 */         if ((c >= '一') && (c <= 40869)) {
/* 68 */           sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0]);
/*    */         }
/* 71 */         else if (((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'))) {
/* 72 */           sb.append(c);
/*    */         }
/*    */       }
/*    */ 
/* 76 */       return sb.toString();
/*    */     } catch (BadHanyuPinyinOutputFormatCombination e) {
/* 78 */       e.printStackTrace();
/*    */     }
/* 80 */     return null;
/*    */   }
/*    */ 
/*    */   public static String getTextFirstLetter(String str) {
/*    */     try {
/* 85 */       StringBuffer sb = new StringBuffer();
/* 86 */       for (int i = 0; i < str.length(); i++) {
/* 87 */         char c = str.charAt(i);
/*    */ 
/* 89 */         if ((c >= '一') && (c <= 40869))
/* 90 */           sb.append(net.sourceforge.pinyin4j.PinyinHelper.toHanyuPinyinStringArray(c, format)[0].charAt(0));
/*    */         else {
/* 92 */           return null;
/*    */         }
/*    */       }
/* 95 */       return sb.toString();
/*    */     } catch (BadHanyuPinyinOutputFormatCombination e) {
/* 97 */       e.printStackTrace();
/*    */     }
/* 99 */     return str;
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.PinyinUtil
 * JD-Core Version:    0.6.2
 */