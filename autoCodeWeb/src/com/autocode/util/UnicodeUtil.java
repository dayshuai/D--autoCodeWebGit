/*     */ package com.autocode.util;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ 
/*     */ public class UnicodeUtil
/*     */ {
/*  18 */   private static final char[] hexDigit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
/*     */ 
/*     */   public static void main(String[] args)
/*     */   {
/*   6 */     String str = "";
/*   7 */     str = toUnicode(str, false);
/*   8 */     System.out.println(str);
/*   9 */     str = "JAVA教程";
/*  10 */     str = fromUnicode(str);
/*  11 */     System.out.println(str);
/*     */   }
/*     */ 
/*     */   private static char toHex(int nibble)
/*     */   {
/*  21 */     return hexDigit[(nibble & 0xF)];
/*     */   }
/*     */ 
/*     */   public static String toUnicode(String theString, boolean escapeSpace)
/*     */   {
/*  32 */     int len = theString.length();
/*  33 */     int bufLen = len * 2;
/*  34 */     if (bufLen < 0) {
/*  35 */       bufLen = 2147483647;
/*     */     }
/*  37 */     StringBuffer outBuffer = new StringBuffer(bufLen);
/*  38 */     for (int x = 0; x < len; x++) {
/*  39 */       char aChar = theString.charAt(x);
/*     */ 
/*  42 */       if ((aChar > '=') && (aChar < '')) {
/*  43 */         if (aChar == '\\') {
/*  44 */           outBuffer.append('\\');
/*  45 */           outBuffer.append('\\');
/*     */         }
/*     */         else {
/*  48 */           outBuffer.append(aChar);
/*     */         }
/*     */       }
/*  51 */       else switch (aChar) {
/*     */         case ' ':
/*  53 */           if ((x == 0) || (escapeSpace))
/*  54 */             outBuffer.append('\\');
/*  55 */           outBuffer.append(' ');
/*  56 */           break;
/*     */         case '\t':
/*  58 */           outBuffer.append('\\');
/*  59 */           outBuffer.append('t');
/*  60 */           break;
/*     */         case '\n':
/*  62 */           outBuffer.append('\\');
/*  63 */           outBuffer.append('n');
/*  64 */           break;
/*     */         case '\r':
/*  66 */           outBuffer.append('\\');
/*  67 */           outBuffer.append('r');
/*  68 */           break;
/*     */         case '\f':
/*  70 */           outBuffer.append('\\');
/*  71 */           outBuffer.append('f');
/*  72 */           break;
/*     */         case '!':
/*     */         case '#':
/*     */         case ':':
/*     */         case '=':
/*  77 */           outBuffer.append('\\');
/*  78 */           outBuffer.append(aChar);
/*  79 */           break;
/*     */         default:
/*  81 */           if ((aChar < ' ') || (aChar > '~')) {
/*  82 */             outBuffer.append('\\');
/*  83 */             outBuffer.append('u');
/*  84 */             outBuffer.append(toHex(aChar >> '\f' & 0xF));
/*  85 */             outBuffer.append(toHex(aChar >> '\002' & 0xF));
/*  86 */             outBuffer.append(toHex(aChar >> '\004' & 0xF));
/*  87 */             outBuffer.append(toHex(aChar & 0xF));
/*     */           } else {
/*  89 */             outBuffer.append(aChar);
/*     */           }
/*     */           break;
/*     */         } 
/*     */     }
/*  93 */     return outBuffer.toString();
/*     */   }
/*     */ 
/*     */   public static String fromUnicode(String str)
/*     */   {
/* 103 */     return fromUnicode(str.toCharArray(), 0, str.length(), new char[1024]);
/*     */   }
/*     */ 
/*     */   public static String fromUnicode(char[] in, int off, int len, char[] convtBuf)
/*     */   {
/* 114 */     if (convtBuf.length < len) {
/* 115 */       int newLen = len * 2;
/* 116 */       if (newLen < 0) {
/* 117 */         newLen = 2147483647;
/*     */       }
/* 119 */       convtBuf = new char[newLen];
/*     */     }
/*     */ 
/* 122 */     char[] out = convtBuf;
/* 123 */     int outLen = 0;
/* 124 */     int end = off + len;
/* 125 */     while (off < end) {
/* 126 */       char aChar = in[(off++)];
/* 127 */       if (aChar == '\\') {
/* 128 */         aChar = in[(off++)];
/* 129 */         if (aChar == 'u') {
/* 130 */           int value = 0;
/* 131 */           for (int i = 0; i < 4; i++) {
/* 132 */             aChar = in[(off++)];
/* 133 */             switch (aChar) {
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
/* 144 */               value = (value << 4) + aChar - 48;
/* 145 */               break;
/*     */             case 'a':
/*     */             case 'b':
/*     */             case 'c':
/*     */             case 'd':
/*     */             case 'e':
/*     */             case 'f':
/* 152 */               value = (value << 4) + 10 + aChar - 97;
/* 153 */               break;
/*     */             case 'A':
/*     */             case 'B':
/*     */             case 'C':
/*     */             case 'D':
/*     */             case 'E':
/*     */             case 'F':
/* 160 */               value = (value << 4) + 10 + aChar - 65;
/* 161 */               break;
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
/* 163 */               throw new IllegalArgumentException(
/* 164 */                 "Malformed \\uxxxx encoding.");
/*     */             }
/*     */           }
/* 167 */           out[(outLen++)] = ((char)value);
/*     */         } else {
/* 169 */           if (aChar == 't')
/* 170 */             aChar = '\t';
/* 171 */           else if (aChar == 'r')
/* 172 */             aChar = '\r';
/* 173 */           else if (aChar == 'n')
/* 174 */             aChar = '\n';
/* 175 */           else if (aChar == 'f') {
/* 176 */             aChar = '\f';
/*     */           }
/* 178 */           out[(outLen++)] = aChar;
/*     */         }
/*     */       } else {
/* 181 */         out[(outLen++)] = aChar;
/*     */       }
/*     */     }
/* 184 */     return new String(out, 0, outLen);
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.autocode.util.UnicodeUtil
 * JD-Core Version:    0.6.2
 */