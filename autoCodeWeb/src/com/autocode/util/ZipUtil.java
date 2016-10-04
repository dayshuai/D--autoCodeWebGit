package com.autocode.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Enumeration;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

public class ZipUtil
{
  public static void main(String[] args)
  {
	  String outputPath;
    try
    {
       outputPath = zip("", "D:\\Workspaces\\aaaaaa\\WebRoot\\css");
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public static String zip(String outputPath, String directory)
    throws FileNotFoundException, IOException
  {
    if ((outputPath == null) || (outputPath.trim().equals(""))) {
      File temp = new File(directory);
      if (temp.isDirectory()) {
        outputPath = directory + ".zip";
      }
      else if (directory.indexOf(".") > 0)
        outputPath = directory.substring(0, directory.lastIndexOf(".")) + "zip";
      else {
        outputPath = directory + ".zip";
      }
    }

    ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(outputPath));
    try {
      startZip(zos, "", directory);
    } catch (IOException ex) {
      throw ex;
    } finally {
      if (zos != null) {
        zos.close();
      }
    }
    return outputPath;
  }

  private static void startZip(ZipOutputStream zos, String relativePath, String absolutPath)
    throws IOException
  {
    File file = new File(absolutPath);
    if (file.isDirectory()) {
      File[] files = file.listFiles();
      for (int i = 0; i < files.length; i++) {
        File tempFile = files[i];
        if (tempFile.isDirectory()) {
          String newRelativePath = relativePath + tempFile.getName() + File.separator;
          createZipNode(zos, newRelativePath);
          startZip(zos, newRelativePath, tempFile.getPath());
        } else {
          zipFile(zos, tempFile, relativePath);
        }
      }
    } else {
      zipFile(zos, file, relativePath);
    }
  }

  private static void zipFile(ZipOutputStream zos, File file, String relativePath)
    throws IOException
  {
    ZipEntry entry = new ZipEntry(relativePath + file.getName());
    zos.putNextEntry(entry);
    InputStream is = null;
    try {
      is = new FileInputStream(file);
      int BUFFERSIZE = 2048;
      int length = 0;
      byte[] buffer = new byte[BUFFERSIZE];
      while ((length = is.read(buffer, 0, BUFFERSIZE)) >= 0) {
        zos.write(buffer, 0, length);
      }
      zos.flush();
      zos.closeEntry();
    } catch (IOException ex) {
      throw ex;
    } finally {
      if (is != null)
        is.close();
    }
  }

  private static void createZipNode(ZipOutputStream zos, String relativePath)
    throws IOException
  {
    ZipEntry zipEntry = new ZipEntry(relativePath);
    zos.putNextEntry(zipEntry);
    zos.closeEntry();
  }

  public static boolean unZip(String zipFilePath, String targetPath)
  {
    try
    {
      OutputStream os = null;
      InputStream is = null;
      ZipFile zipFile = null;
      try {
        zipFile = new ZipFile(zipFilePath);
        String directoryPath = "";
        if ((targetPath == null) || ("".equals(targetPath)))
          directoryPath = zipFilePath.substring(0, zipFilePath.lastIndexOf("."));
        else {
          directoryPath = targetPath;
        }
        Enumeration entryEnum = zipFile.getEntries();
        if (entryEnum != null) {
          ZipEntry zipEntry = null;
          while (entryEnum.hasMoreElements()) {
            zipEntry = (ZipEntry)entryEnum.nextElement();
            if (zipEntry.isDirectory()) {
              directoryPath = directoryPath + File.separator + zipEntry.getName();
              System.out.println(directoryPath);
            }
            else if (!zipEntry.isDirectory())
            {
              File targetFile = buildFile(directoryPath + File.separator + zipEntry.getName(), false);
              os = new BufferedOutputStream(new FileOutputStream(targetFile));
              is = zipFile.getInputStream(zipEntry);
              byte[] buffer = new byte[4096];
              int readLen = 0;
              while ((readLen = is.read(buffer, 0, 4096)) >= 0) {
                os.write(buffer, 0, readLen);
              }
              os.flush();
              os.close();
            }
            else {
              buildFile(directoryPath + File.separator + zipEntry.getName(), true);
            }
          }
        }
      } catch (IOException ex) {
        throw ex;
      } finally {
        if (zipFile != null) {
          zipFile = null;
        }
        if (is != null) {
          is.close();
        }
        if (os != null) {
          os.close();
        }
      }
      return true;
    } catch (IOException e) {
      e.printStackTrace();
    }
    return false;
  }

  public static File buildFile(String fileName, boolean isDirectory) {
    File target = new File(fileName);
    if (isDirectory) {
      target.mkdirs();
    }
    else if (!target.getParentFile().exists()) {
      target.getParentFile().mkdirs();
      target = new File(target.getAbsolutePath());
    }

    return target;
  }
}

