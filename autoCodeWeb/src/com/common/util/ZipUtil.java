/*     */ package com.common.util;
/*     */ 
/*     */ import java.io.BufferedOutputStream;
/*     */ import java.io.File;
/*     */ import java.io.FileInputStream;
/*     */ import java.io.FileNotFoundException;
/*     */ import java.io.FileOutputStream;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.OutputStream;
/*     */ import java.io.PrintStream;
/*     */ import java.util.Enumeration;
/*     */ import org.apache.tools.zip.ZipEntry;
/*     */ import org.apache.tools.zip.ZipFile;
/*     */ import org.apache.tools.zip.ZipOutputStream;
/*     */ 
/*     */ public class ZipUtil
/*     */ {
/*     */   public static void main(String[] args)
/*     */   {
/*     */     try
/*     */     {
/*  21 */       String outputPath = zip("", "D:\\Workspaces\\autocode\\WebRoot\\js");
/*  22 */       System.out.println(outputPath);
/*     */     } catch (Exception e) {
/*  24 */       e.printStackTrace();
/*     */     }
/*     */   }
/*     */ 
/*     */   public static String zip(String outputPath, String directory)
/*     */     throws FileNotFoundException, IOException
/*     */   {
/*  36 */     if ((outputPath == null) || (outputPath.trim().equals(""))) {
/*  37 */       File temp = new File(directory);
/*  38 */       if (temp.isDirectory()) {
/*  39 */         outputPath = directory + ".zip";
/*     */       }
/*  41 */       else if (directory.indexOf(".") > 0)
/*  42 */         outputPath = directory.substring(0, directory.lastIndexOf(".")) + "zip";
/*     */       else {
/*  44 */         outputPath = directory + ".zip";
/*     */       }
/*     */     }
/*     */ 
/*  48 */     ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(outputPath));
/*     */     try {
/*  50 */       startZip(zos, "", directory);
/*     */     } catch (IOException ex) {
/*  52 */       throw ex;
/*     */     } finally {
/*  54 */       if (zos != null) {
/*  55 */         zos.close();
/*     */       }
/*     */     }
/*  58 */     return outputPath;
/*     */   }
/*     */ 
/*     */   private static void startZip(ZipOutputStream zos, String relativePath, String absolutPath)
/*     */     throws IOException
/*     */   {
/*  70 */     File file = new File(absolutPath);
/*  71 */     if (file.isDirectory()) {
/*  72 */       File[] files = file.listFiles();
/*  73 */       for (int i = 0; i < files.length; i++) {
/*  74 */         File tempFile = files[i];
/*  75 */         if (tempFile.isDirectory()) {
/*  76 */           String newRelativePath = relativePath + tempFile.getName() + File.separator;
/*  77 */           createZipNode(zos, newRelativePath);
/*  78 */           startZip(zos, newRelativePath, tempFile.getPath());
/*     */         } else {
/*  80 */           zipFile(zos, tempFile, relativePath);
/*     */         }
/*     */       }
/*     */     } else {
/*  84 */       zipFile(zos, file, relativePath);
/*     */     }
/*     */   }
/*     */ 
/*     */   private static void zipFile(ZipOutputStream zos, File file, String relativePath)
/*     */     throws IOException
/*     */   {
/*  96 */     ZipEntry entry = new ZipEntry(relativePath + file.getName());
/*  97 */     zos.putNextEntry(entry);
/*  98 */     InputStream is = null;
/*     */     try {
/* 100 */       is = new FileInputStream(file);
/* 101 */       int BUFFERSIZE = 2048;
/* 102 */       int length = 0;
/* 103 */       byte[] buffer = new byte[BUFFERSIZE];
/* 104 */       while ((length = is.read(buffer, 0, BUFFERSIZE)) >= 0) {
/* 105 */         zos.write(buffer, 0, length);
/*     */       }
/* 107 */       zos.flush();
/* 108 */       zos.closeEntry();
/*     */     } catch (IOException ex) {
/* 110 */       throw ex;
/*     */     } finally {
/* 112 */       if (is != null)
/* 113 */         is.close();
/*     */     }
/*     */   }
/*     */ 
/*     */   private static void createZipNode(ZipOutputStream zos, String relativePath)
/*     */     throws IOException
/*     */   {
/* 125 */     ZipEntry zipEntry = new ZipEntry(relativePath);
/* 126 */     zos.putNextEntry(zipEntry);
/* 127 */     zos.closeEntry();
/*     */   }
/*     */ 
/*     */   public static boolean unZip(String zipFilePath, String targetPath)
/*     */   {
/*     */     try
/*     */     {
/* 138 */       OutputStream os = null;
/* 139 */       InputStream is = null;
/* 140 */       ZipFile zipFile = null;
/*     */       try {
/* 142 */         zipFile = new ZipFile(zipFilePath);
/* 143 */         String directoryPath = "";
/* 144 */         if ((targetPath == null) || ("".equals(targetPath)))
/* 145 */           directoryPath = zipFilePath.substring(0, zipFilePath.lastIndexOf("."));
/*     */         else {
/* 147 */           directoryPath = targetPath;
/*     */         }
/* 149 */         Enumeration entryEnum = zipFile.getEntries();
/* 150 */         if (entryEnum != null) {
/* 151 */           ZipEntry zipEntry = null;
/* 152 */           while (entryEnum.hasMoreElements()) {
/* 153 */             zipEntry = (ZipEntry)entryEnum.nextElement();
/* 154 */             if (zipEntry.isDirectory()) {
/* 155 */               directoryPath = directoryPath + File.separator + zipEntry.getName();
/* 156 */               System.out.println(directoryPath);
/*     */             }
/* 159 */             else if (!zipEntry.isDirectory())
/*     */             {
/* 161 */               File targetFile = buildFile(directoryPath + File.separator + zipEntry.getName(), false);
/* 162 */               os = new BufferedOutputStream(new FileOutputStream(targetFile));
/* 163 */               is = zipFile.getInputStream(zipEntry);
/* 164 */               byte[] buffer = new byte[4096];
/* 165 */               int readLen = 0;
/* 166 */               while ((readLen = is.read(buffer, 0, 4096)) >= 0) {
/* 167 */                 os.write(buffer, 0, readLen);
/*     */               }
/* 169 */               os.flush();
/* 170 */               os.close();
/*     */             }
/*     */             else {
/* 173 */               buildFile(directoryPath + File.separator + zipEntry.getName(), true);
/*     */             }
/*     */           }
/*     */         }
/*     */       } catch (IOException ex) {
/* 178 */         throw ex;
/*     */       } finally {
/* 180 */         if (zipFile != null) {
/* 181 */           zipFile = null;
/*     */         }
/* 183 */         if (is != null) {
/* 184 */           is.close();
/*     */         }
/* 186 */         if (os != null) {
/* 187 */           os.close();
/*     */         }
/*     */       }
/* 190 */       return true;
/*     */     } catch (IOException e) {
/* 192 */       e.printStackTrace();
/*     */     }
/* 194 */     return false;
/*     */   }
/*     */ 
/*     */   public static File buildFile(String fileName, boolean isDirectory) {
/* 198 */     File target = new File(fileName);
/* 199 */     if (isDirectory) {
/* 200 */       target.mkdirs();
/*     */     }
/* 202 */     else if (!target.getParentFile().exists()) {
/* 203 */       target.getParentFile().mkdirs();
/* 204 */       target = new File(target.getAbsolutePath());
/*     */     }
/*     */ 
/* 207 */     return target;
/*     */   }
/*     */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.ZipUtil
 * JD-Core Version:    0.6.2
 */