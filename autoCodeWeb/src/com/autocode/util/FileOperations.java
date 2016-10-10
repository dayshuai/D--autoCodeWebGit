package com.autocode.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

public class FileOperations {
	public static List<String> readTextContentReturenList(String path) {
		List <String> linkStrList = new ArrayList <String> ();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(path))));
			String str = "";
			while ((str = br.readLine()) != null) {
				if (!str.equals("")) {
					linkStrList.add(str);
				}
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return linkStrList;
	}

	public static String readTextContentReturenString(String path) {
		String context = "";
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(path))));
			String str = "";
			while ((str = br.readLine()) != null) {
				context = context + str;
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return context;
	}

	public static boolean writeContent(String path, String content) {
		try {
			File file = new File(path);
			if (!file.exists()) {
				file.createNewFile();
			}
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, true), "UTF-8"));
			bw.write(content);
			bw.flush();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public static String downloadUrlFile(String inputPath, String outPath, String fileName) {
		try {
			URL url = new URL(inputPath);

			URLConnection con = url.openConnection();

			con.setConnectTimeout(5000);

			InputStream is = con.getInputStream();

			byte[] bs = new byte[1024];

			File sf = new File(outPath);
			if (!sf.exists()) {
				sf.mkdirs();
			}
			OutputStream os = new FileOutputStream(sf.getPath() + "\\" + fileName);
			int len;
			while ((len = is.read(bs)) != -1) {
				os.write(bs, 0, len);
			}

			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return fileName;
	}

	public static String WriteFile(String inputPath, String fileName, String filePostfix, File fileUrl) {
		if (fileUrl == null) {
			return null;
		}
		File file = new File(inputPath);
		if (!file.exists())
			file.mkdir();
		try {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(fileUrl));
			if (file != null) {
				file.createNewFile();
			}

			BufferedOutputStream out = new BufferedOutputStream(
					new FileOutputStream(inputPath + "//" + fileName + filePostfix));
			byte[] bb = new byte[1024];
			int n;
			while ((n = in.read(bb)) != -1) {
				out.write(bb, 0, n);
			}
			out.close();
			in.close();
			Thread.sleep(1000L);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName + filePostfix;
	}

	public static boolean DeleteFile(String filePath, String fileName, String filePostfix) {
		File file = new File(filePath + "/" + fileName + "." + filePostfix);
		if (!file.exists()) {
			return false;
		}
		file.delete();

		return true;
	}

	public static void DownloadFile(String filePath, String fileName, HttpServletResponse response) {
		try {
			response.setContentType("unknown");
			response.setHeader("Content-Disposition",
					"attachment; filename=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
			OutputStream os = response.getOutputStream();
			FileInputStream fis = new FileInputStream(new File(filePath));
			byte[] b = new byte[2048];
			int i = 0;
			while ((i = fis.read(b)) > 0) {
				os.write(b, 0, i);
			}
			fis.close();
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void DownloadUrlFile(String filePath, String fileName, HttpServletResponse response) {
		try {
			response.setContentType("unknown");
			response.setHeader("Content-Disposition",
					"attachment; filename=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
			OutputStream os = response.getOutputStream();
			URL url = new URL(filePath);
			InputStream is = url.openStream();
			byte[] b = new byte[2048];
			int i = 0;
			while ((i = is.read(b)) > 0) {
				os.write(b, 0, i);
			}
			is.close();
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String downloadNetFile(String fileUrl, String outPath, String filePrefix, String filePostfix) {
		String fileName = DateTimeUtil.FormatSystemDateSN() + filePostfix;
		try {
			URL url = new URL(fileUrl);
			URLConnection con = url.openConnection();
			con.setConnectTimeout(5000);
			InputStream is = con.getInputStream();
			byte[] bs = new byte[1024];

			OutputStream os = new FileOutputStream(outPath + "\\" + fileName);
			int len;
			while ((len = is.read(bs)) != -1) {
				os.write(bs, 0, len);
			}
			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return fileName;
	}

	public static void main(String[] args) {
		List <String> list = new ArrayList <String> ();
		list.add("ACTIVITY_20160229221726580_1128_686_1101.png");
		list.add("ACTIVITY_20160229221726581_1127_684_833.png");
		list.add("ACTIVITY_20160229221726582_4272_2848_635.jpg");
		list.add("ACTIVITY_20160229221726583_4256_2832_802.jpg");
		list.add("ACTIVITY_20160229221726584_5344_3606_567.jpg");
		list.add("ACTIVITY_20160229221726585_5760_3840_771.jpg");
		for (int i = 0; i < list.size(); i++)
			try {
				String s = (String) list.get(i);
				URL url = new URL("http://img.weride.com.cn/" + s);
				File outFile = new File("D:/starImage/" + s);
				OutputStream os = new FileOutputStream(outFile);
				InputStream is = url.openStream();
				byte[] buff = new byte[1024];
				while (true) {
					int readed = is.read(buff);
					if (readed == -1) {
						break;
					}
					byte[] temp = new byte[readed];
					System.arraycopy(buff, 0, temp, 0, readed);
					os.write(temp);
				}
				is.close();
				os.close();
				System.out.println("成功:" + (String) list.get(i));
			} catch (Exception e) {
				e.printStackTrace();
				break;
			}
	}
}
