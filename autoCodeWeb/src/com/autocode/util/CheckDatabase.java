package com.autocode.util;

import com.autocode.base.BaseController;
import java.sql.Connection;
import java.sql.DriverManager;

public class CheckDatabase extends BaseController {
	public static boolean checkDatabase(String batabaseName, String databaseType, String ip, Integer port,
			String username, String password) {
		try {
			String url = null;
			Connection conn = null;
			if (equals("MySql", databaseType)) {
				url = "jdbc:mysql://" + ip + ":" + port + "/" + batabaseName;
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(url, username, password);
			} else if (equals("SqlServer", databaseType)) {
				url = "jdbc:sqlserver://" + ip + ":" + port + ";databaseName=" + batabaseName + ";";
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				conn = DriverManager.getConnection(url, username, password);
			} else if (equals("Oracle", databaseType)) {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				url = "jdbc:oracle:thin:@" + ip + ":" + port + ":" + batabaseName;
			}
			conn = DriverManager.getConnection(url, username, password);
			if (conn == null)
				return false;
			try {
				conn.close();
			} catch (Exception localException1) {
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
