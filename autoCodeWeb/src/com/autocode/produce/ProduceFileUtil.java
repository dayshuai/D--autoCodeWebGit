package com.autocode.produce;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

public class ProduceFileUtil {
	public static boolean deleteFile(String writePath, String projectName) {
		try {
			File file = new File(writePath + "\\" + projectName);
			if (file.exists()) {
				deleteDir(file);
			}
			file = new File(writePath + "\\" + projectName + "State.txt");
			if (file.exists())
				file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	private static void deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			for (int i = 0; i < children.length; i++) {
				deleteDir(new File(dir, children[i]));
			}
		}
		dir.delete();
	}

	public static void WriteState(String writePath, String projectName, String fileName, String fileType,
			Integer produceCount, Integer writeCount, boolean fileState, String reason) {
		try {
			new Thread();
			Thread.sleep(20L);
			DecimalFormat fnum = new DecimalFormat("###.##");
			String progress = fnum.format(writeCount.intValue() / produceCount.intValue() * 100.0F);
			File outFile = new File(writePath);
			if (!outFile.exists()) {
				outFile.mkdirs();
			}
			String writeContent = "fileName=" + fileName + ",fileType=" + fileType + ",writeCount=" + writeCount
					+ ",produceCount=" + produceCount + ",progress=" + progress + "%,fileState=" + fileState
					+ ",reason=" + reason;
			OutputStream os = new FileOutputStream(new File(writePath + "/" + projectName + "State.txt"));
			os.write(writeContent.getBytes());
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
	}

	public static Map<String, Object> ReadState(String readUrl, String projectName) {
		Map map = new HashMap();
		map.put("fileName", "");
		map.put("fileType", "");
		map.put("writeCount", "0");
		map.put("produceCount", "0");
		map.put("fileState", "true");
		map.put("reason", "");
		map.put("progress", "0%");
		BufferedReader br = null;
		File file = new File(readUrl + "\\" + projectName + "State.txt");
		try {
			int timeCount = 1;

			while (!file.exists()) {
				new Thread();
				Thread.sleep(300L);
				if (timeCount * 300 > 10000) {
					map.put("result", "false");
					map.put("reason", "读取进度异常");
					Map localMap1 = map;
					return localMap1;
				}
				timeCount++;
			}
			br = new BufferedReader(new FileReader(file));
			String[] values = br.readLine().split(",");
			for (int i = 0; i < values.length; i++) {
				String[] strs = values[i].split("=");
				if (strs.length == 2)
					map.put(strs[0], strs[1]);
				else {
					map.put(strs[0], "");
				}
			}
			map.put("result", "true");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "false");

			if (br != null)
				try {
					br.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		if ((map.get("writeCount") != null) && (map.get("writeCount").equals(map.get("produceCount")))) {
			file.delete();
		}

		return map;
	}
}
