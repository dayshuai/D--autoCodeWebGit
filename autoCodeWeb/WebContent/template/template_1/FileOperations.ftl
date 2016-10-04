package ${utilPackage};

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

public class FileOperations {

	public static String downloadUrlFile(String inputPath, String outPath,
			String fileName) {
		try {
			// 构造URL
			URL url = new URL(inputPath);
			// 打开连接
			URLConnection con = url.openConnection();
			// 设置请求超时为5s
			con.setConnectTimeout(5 * 1000);
			// 输入流
			InputStream is = con.getInputStream();
			// 1K的数据缓冲
			byte[] bs = new byte[1024];
			// 读取到的数据长度
			int len;
			// 输出的文件流
			File sf = new File(outPath);
			if (!sf.exists()) {
				sf.mkdirs();
			}
			OutputStream os = new FileOutputStream(sf.getPath() + "\\"
					+ fileName);
			// 开始读取
			while ((len = is.read(bs)) != -1) {
				os.write(bs, 0, len);
			}
			// 完毕，关闭所有链接
			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return fileName;
	}

	public static String WriteFile(String inputPath,String fileName,String filePostfix,File fileUrl) {
		if (fileUrl == null) {
			return null;
		} else {
			File file = new File(inputPath);
			if (!file.exists()) {
				file.mkdir();
			}
			try {
				BufferedInputStream in = new BufferedInputStream(new FileInputStream(fileUrl));
				if (file != null) {
					file.createNewFile();
				}
				// 指定要写入文件的缓冲输出字节流
				BufferedOutputStream out = new BufferedOutputStream(
						new FileOutputStream(inputPath + "//" + fileName+ filePostfix));
				byte[] bb = new byte[1024];// 用来存储每次读取到的字节数组
				int n;// 每次读取到的字节数组的长度
				while ((n = in.read(bb)) != -1) {
					out.write(bb, 0, n);// 写入到输出流
				}
				out.close();// 关闭流
				in.close();
				Thread.sleep(1000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return fileName + filePostfix;
		}
	}

	public static boolean DeleteFile(String filePath, String fileName,String filePostfix) {
		File file = new File(filePath + "/" + fileName + "." + filePostfix);
		if (!file.exists()) {
			return false;
		} else {
			file.delete();
		}
		return true;
	}

	public static void DownloadFile(String filePath, String fileName,
			HttpServletResponse response) {
		try {
			response.setContentType("unknown");
			response.setHeader("Content-Disposition", "attachment; filename="+ new String(fileName.getBytes("gb2312"), "ISO8859-1"));
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

	public static void DownloadUrlFile(String filePath, String fileName,HttpServletResponse response) {
		try {
			response.setContentType("unknown");
			response.setHeader("Content-Disposition", "attachment; filename="+ new String(fileName.getBytes("gb2312"), "ISO8859-1"));
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

	// 下载网络文件
	public static String downloadNetFile(String fileUrl, String outPath,String filePrefix, String filePostfix) {
		String fileName = DateTimeUtil.FormatSystemDateSN()+ filePostfix;
		try {
			URL url = new URL(fileUrl);
			URLConnection con = url.openConnection();
			con.setConnectTimeout(5 * 1000);
			InputStream is = con.getInputStream();
			byte[] bs = new byte[1024];
			int len;
			OutputStream os = new FileOutputStream(outPath + "\\" + fileName);
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
		List<String> list = new ArrayList<String>();
		list.add("http://musicsong.qiniudn.com/StarImage_20140518031414.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140518134305.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140523114333.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140526130936.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140526131514.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140526134543.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140526134956.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140529154813.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140529155437.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140529160416.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140612125205.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140612130432.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140612131006.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140626170023.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140630152017.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140630152727.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140630153513.png");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709122441.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709123325.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709123456.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709123912.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709124139.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140709124418.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140801131228.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121310.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121504.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121555.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121708.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121756.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815121916.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815122108.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815122641.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815122909.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815123035.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140815123832.jpg");
		list.add("http://musicsong.qiniudn.com/StarImage_20140819122644.jpg");
		for (int i = 0; i < list.size(); i++) {
			try {
				String s = list.get(i);
				URL url = new URL(s);
				int r = s.lastIndexOf("/") + 1;
				File outFile = new File("D:/starImage/"
						+ s.substring(r, s.length()));
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
				System.out.println("成功:" + list.get(i));
			} catch (Exception e) {
				e.printStackTrace();
				break;
			}

		}
	}
}