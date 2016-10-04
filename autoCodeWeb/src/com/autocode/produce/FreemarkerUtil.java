package com.autocode.produce;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import com.autocode.base.ServiceException;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

public class FreemarkerUtil {
	public static void WriteFile(String writePath, String fileName, String templatePath, String templateName,
			Map<String, Object> contentMap) {
		try {
			File f = new File(writePath);
			if (!f.exists()) {
				f.mkdirs();
			}
			if ((fileName.contains(".")) && (fileName.split("\\.").length > 1)) {
				if (fileName.split("\\.")[1].equals("java")) {
					fileName = firstToUpper(fileName);
				}
				if (fileName.split("\\.")[1].equals("jsp")) {
					fileName = firstLetterToLower(fileName);
				}
			}

			String encoding = "utf-8";
			Configuration config = new Configuration();
			File file = new File(templatePath);

			config.setDirectoryForTemplateLoading(file);

			config.setObjectWrapper(new DefaultObjectWrapper());

			Template template = config.getTemplate(templateName, encoding);

			Writer out = new OutputStreamWriter(new FileOutputStream(new File(writePath + "/" + fileName)), encoding);

			template.process(contentMap, out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public static void main(String[] args) {
		String fileName = "contne.java";
		if ((fileName.contains(".")) && (fileName.split("\\.").length > 1)
				&& (fileName.split("\\.")[1].equals("java"))) {
			fileName = firstToUpper(fileName);
		}

		System.out.println(fileName);
	}

	public static String firstToUpper(String str) {
		return String.valueOf(str.charAt(0)).toUpperCase() + str.substring(1, str.length());
	}

	public static String firstLetterToLower(String str) {
		return String.valueOf(str.charAt(0)).toLowerCase() + str.substring(1, str.length());
	}
}
