/*     */ package com.common.util;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ 
/*     */ public class UnicodeUtil
/*     */ {
/*  14 */   private static final char[] hexDigit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
/*     */ 
/*     */   public static void main(String[] args)
/*     */   {
/*   6 */     String str = "JAVA教程";
/*   7 */     str = zhConvertUnicode(str, false);
/*   8 */     System.out.println(str);
/*   9 */     str = "JAVA教程";
/*  10 */     str = unicodeConvertZh(str);
/*  11 */     System.out.println(str);
/*     */   }
/*     */ 
/*     */   private static char toHex(int nibble)
/*     */   {
/*  17 */     return hexDigit[(nibble & 0xF)];
/*     */   }
/*     */ 
/*     */   public static String zhConvertUnicode(String theString, boolean escapeSpace)
/*     */   {
/*  28 */     int len = theString.length();
/*  29 */     int bufLen = len * 2;
/*  30 */     if (bufLen < 0) {
/*  31 */       bufLen = 2147483647;
/*     */     }
/*  33 */     StringBuffer outBuffer = new StringBuffer(bufLen);
/*  34 */     for (int x = 0; x < len; x++) {
/*  35 */       char aChar = theString.charAt(x);
/*  36 */       if ((aChar > '=') && (aChar < '')) {
/*  37 */         if (aChar == '\\') {
/*  38 */           outBuffer.append('\\');
/*  39 */           outBuffer.append('\\');
/*     */         }
/*     */         else {
/*  42 */           outBuffer.append(aChar);
/*     */         }
/*     */       }
/*  45 */       else switch (aChar) {
/*     */         case ' ':
/*  47 */           if ((x == 0) || (escapeSpace))
/*  48 */             outBuffer.append('\\');
/*  49 */           outBuffer.append(' ');
/*  50 */           break;
/*     */         case '\t':
/*  52 */           outBuffer.append('\\');
/*  53 */           outBuffer.append('t');
/*  54 */           break;
/*     */         case '\n':
/*  56 */           outBuffer.append('\\');
/*  57 */           outBuffer.append('n');
/*  58 */           break;
/*     */         case '\r':
/*  60 */           outBuffer.append('\\');
/*  61 */           outBuffer.append('r');
/*  62 */           break;
/*     */         case '\f':
/*  64 */           outBuffer.append('\\');
/*  65 */           outBuffer.append('f');
/*  66 */           break;
/*     */         case '!':
/*     */         case '#':
/*     */         case ':':
/*     */         case '=':
/*  71 */           outBuffer.append('\\');
/*  72 */           outBuffer.append(aChar);
/*  73 */           break;
/*     */         default:
/*  75 */           if ((aChar < ' ') || (aChar > '~')) {
/*  76 */             outBuffer.append('\\');
/*  77 */             outBuffer.append('u');
/*  78 */             outBuffer.append(toHex(aChar >> '\f' & 0xF));
/*  79 */             outBuffer.append(toHex(aChar >> '\002' & 0xF));
/*  80 */             outBuffer.append(toHex(aChar >> '\004' & 0xF));
/*  81 */             outBuffer.append(toHex(aChar & 0xF));
/*     */           } else {
/*  83 */             outBuffer.append(aChar);
/*     */           }
/*     */           break;
/*     */         } 
/*     */     }
/*  87 */     return outBuffer.toString();
/*     */   }
/*     */ 
/*     */   public static String unicodeConvertZh(String str)
/*     */   {
/*  97 */     char[] in = str.toCharArray();
/*  98 */     int off = 0;
/*  99 */     int len = str.length();
/* 100 */     char[] convtBuf = new char[1024];
/*     */ 
/* 102 */     if (convtBuf.length < len) {
/* 103 */       int newLen = len * 2;
/* 104 */       if (newLen < 0) {
/* 105 */         newLen = 2147483647;
/*     */       }
/* 107 */       convtBuf = new char[newLen];
/*     */     }
/*     */ 
/* 110 */     char[] out = convtBuf;
/* 111 */     int outLen = 0;
/* 112 */     int end = off + len;
/* 113 */     while (off < end) {
/* 114 */       char aChar = in[(off++)];
/* 115 */       if (aChar == '\\') {
/* 116 */         aChar = in[(off++)];
/* 117 */         if (aChar == 'u') {
/* 118 */           int value = 0;
/* 119 */           for (int i = 0; i < 4; i++) {
/* 120 */             aChar = in[(off++)];
/* 121 */             switch (aChar) {
/*     */             case '0':
/*     */             case '1':
/*     */             case '2':
/*     */             case '3':
/*     */             case '4':
/*     */             case '5':
/*     */             case '6':
/*     */             case '7':
/*     */             case '8':
/*     */             case '9':
/* 132 */               value = (value << 4) + aChar - 48;
/* 133 */               break;
/*     */             case 'a':
/*     */             case 'b':
/*     */             case 'c':
/*     */             case 'd':
/*     */             case 'e':
/*     */             case 'f':
/* 140 */               value = (value << 4) + 10 + aChar - 97;
/* 141 */               break;
/*     */             case 'A':
/*     */             case 'B':
/*     */             case 'C':
/*     */             case 'D':
/*     */             case 'E':
/*     */             case 'F':
/* 148 */               value = (value << 4) + 10 + aChar - 65;
/* 149 */               break;
/*     */             case ':':
/*     */             case ';':
/*     */             case '<':
/*     */             case '=':
/*     */             case '>':
/*     */             case '?':
/*     */             case '@':
/*     */             case 'G':
/*     */             case 'H':
/*     */             case 'I':
/*     */             case 'J':
/*     */             case 'K':
/*     */             case 'L':
/*     */             case 'M':
/*     */             case 'N':
/*     */             case 'O':
/*     */             case 'P':
/*     */             case 'Q':
/*     */             case 'R':
/*     */             case 'S':
/*     */             case 'T':
/*     */             case 'U':
/*     */             case 'V':
/*     */             case 'W':
/*     */             case 'X':
/*     */             case 'Y':
/*     */             case 'Z':
/*     */             case '[':
/*     */             case '\\':
/*     */             case ']':
/*     */             case '^':
/*     */             case '_':
/*     */             case '`':
/*     */             default:
/* 151 */               throw new IllegalArgumentException(
/* 152 */                 "Malformed \\uxxxx encoding.");
/*     */             }
/*     */           }
/* 155 */           out[(outLen++)] = ((char)value);
/*     */         } else {
/* 157 */           if (aChar == 't')
/* 158 */             aChar = '\t';
/* 159 */           else if (aChar == 'r')
/* 160 */             aChar = '\r';
/* 161 */           else if (aChar == 'n')
/* 162 */             aChar = '\n';
/* 163 */           else if (aChar == 'f') {
/* 164 */             aChar = '\f';
/*     */           }
/* 166 */           out[(outLen++)] = aChar;
/*     */         }
/*     */       } else {
/* 169 */         out[(outLen++)] = aChar;
/*     */       }
/*     */     }
/* 172 */     return new String(out, 0, outLen);
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.UnicodeUtil
 * JD-Core Version:    0.6.2
 */