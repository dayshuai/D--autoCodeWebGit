package ${utilPackage};

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;

/**
 * 读取配置文件类
 * 
 * @author ys
 * 
 */
public class PropertiesUtil {

	private static Properties prop = new Properties();

	private static PropertiesUtil instance = null;

	private static final String fileName = "/config.properties";

	private static String filePath = "";

	/**
	 * Constructor for SysParamReader.
	 */
	public PropertiesUtil() {
		try {
			InputStream is = this.getClass().getResourceAsStream(fileName);
			ClassPathResource resource = new ClassPathResource(fileName);
			filePath = resource.getURL().getPath().replace("20%", "");
			prop.load(is);
			if (is != null) {
				is.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getValue(String key) {
		if (instance == null) {
			instance = new PropertiesUtil();
		}
		return prop.getProperty(key);
	}

	public static void setValue(String key, String value) {
		try {
			InputStream is = PropertiesUtil.class
					.getResourceAsStream(fileName);
			ClassPathResource resource = new ClassPathResource(fileName);
			filePath = resource.getURL().getPath().replace("20%", "");
			OutputStream fos = null;
			try {
				fos = new FileOutputStream(new File(filePath));
				prop.setProperty(key, value);
				prop.store(fos, "");
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (fos != null)
					fos.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		PropertiesUtil.setValue("wamPwd", "sPUMxMjAxNTIw\n");
		System.out.println(PropertiesUtil.getValue("wamPwd"));
	}
}