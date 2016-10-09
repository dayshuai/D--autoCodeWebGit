package com.autocode.database.operator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.autocode.base.ServiceException;
import com.autocode.bean.Column;
import com.autocode.bean.ColumnConvert;
import com.autocode.bean.DatabaseConvert;
import com.autocode.bean.PackageConvert;
import com.autocode.bean.Project;
import com.autocode.bean.Table;

public class ConnectMySql {
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private Connection getConnection(Project p) {
		String url = "jdbc:mysql://" + p.getDatabaseIp() + ":" + p.getDatabasePort() + "/" + p.getDatabaseName();
		try {
			return DriverManager.getConnection(url, p.getDatabaseUser(), p.getDatabasePwd());
		} catch (SQLException e) {
			System.err.println("数据库名字不存在:" + url);
		}
		return null;
	}

	public List<Table> queryProjectTableList(Project p, List<ColumnConvert> columnConvertList) {
		Connection conn = getConnection(p);
		if (conn == null) {
			return null;
		}
		Map<String, String> columnConvertMap = new HashMap<String, String>();

		Map<String, String> translateMap = new HashMap<String, String>();
		if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
			for (int j = 0; j < columnConvertList.size(); j++) {
				ColumnConvert cc = (ColumnConvert) columnConvertList.get(j);
				columnConvertMap.put(cc.getMappingName().toLowerCase(), cc.getColumnName());
				translateMap.put(cc.getMappingName().toLowerCase(), cc.getColumnZhName());
			}
		}
		ArrayList<Table> tableList = new ArrayList<Table>();
		ArrayList<Table> allTable = queryTableList(conn, p.getDatabaseName());
		for (Table table : allTable) {
			List<Column> columnList = queryColumnList(conn, p.getDatabaseName(), table.getMappingName(), columnConvertList);
			if ((columnList != null) && (columnList.size() != 0)) {
				String mappingName = table.getMappingName();
				String tableName = (String) columnConvertMap.get(mappingName.toLowerCase());
				String tableZhName = table.getTableTitle();
				if ((tableName == null) || (tableName.equals(""))) {
					if (mappingName.contains("_"))
						tableName = handleColumnLetter(mappingName, "table");
					else {
						tableName = "null";
					}
				}
				if ((tableZhName == null) || (tableZhName.equals(""))) {
					tableZhName = (String) translateMap.get(mappingName.toLowerCase());
				}
				if ((tableZhName == null) || (tableZhName.equals(""))) {
					tableZhName = "null";
				}
				Table t = new Table(p.getProjectId(), tableZhName, mappingName, tableName, "NO", "自动生成");
				t.setColumnList(columnList);
				tableList.add(t);
			}
		}
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if ((tableList != null) && (tableList.size() > 0)) {
			return tableList;
		}
		return null;
	}

	private ArrayList<Table> queryTableList(Connection conn, String databaseName) {
		String sql = "SELECT TABLE_NAME,TABLE_COMMENT from information_schema.TABLES where TABLE_SCHEMA='"
				+ databaseName + "'";
		ArrayList<Table> tableList = new ArrayList<Table>();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ((rs != null) && (rs.next())) {
				Table table = new Table();
				table.setMappingName(rs.getString("TABLE_NAME"));
				table.setTableTitle(rs.getString("TABLE_COMMENT"));
				tableList.add(table);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tableList;
	}

	public ArrayList<Column> queryColumnList(Project p, Table table, List<ColumnConvert> columnConvertList,
			List<PackageConvert> packageConvertList, List<DatabaseConvert> databaseConvertList) {
		Connection conn = getConnection(p);
		if (conn == null) {
			return null;
		}
		Map <String, String> columnConvertMap = new HashMap <String, String> ();
		Map<String, String> databaseConvertMap = new HashMap<String, String>();
		Map<String, String> packageConvertMap = new HashMap<String, String>();
		Map<String, String> translateMap = new HashMap<String, String>();
		if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
			for (int j = 0; j < columnConvertList.size(); j++) {
				ColumnConvert cc = (ColumnConvert) columnConvertList.get(j);
				columnConvertMap.put(cc.getMappingName().toLowerCase(), cc.getColumnName());
				translateMap.put(cc.getMappingName().toLowerCase(), cc.getColumnZhName());
			}
		}
		if ((packageConvertList != null) && (packageConvertList.size() > 0)) {
			for (int i = 0; i < packageConvertList.size(); i++) {
				PackageConvert pc = (PackageConvert) packageConvertList.get(i);
				packageConvertMap.put(pc.getClassName(), pc.getPackageName());
			}
		}
		if ((databaseConvertList != null) && (databaseConvertList.size() > 0)) {
			for (int i = 0; i < databaseConvertList.size(); i++) {
				DatabaseConvert dc = (DatabaseConvert) databaseConvertList.get(i);
				databaseConvertMap.put(dc.getColumnType().toLowerCase(), dc.getConvertType());
			}
		}
		String sql = "SELECT COLUMN_NAME,DATA_TYPE,COLUMN_TYPE,COLUMN_KEY,COLUMN_COMMENT FROM information_schema.Columns WHERE TABLE_NAME='"
				+ table.getMappingName() + "' AND TABLE_SCHEMA='" + p.getDatabaseName() + "'";
		ArrayList<Column> columnList = new ArrayList<Column>();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			int index = 1;
			while ((rs != null) && (rs.next())) {
				Column c = new Column();
				String mappingName = rs.getString("COLUMN_NAME");
				String coumnName = (String) columnConvertMap.get(mappingName.toLowerCase());
				String columnZhName = (String) translateMap.get(mappingName.toLowerCase());
				if ((coumnName == null) || (coumnName.equals(""))) {
					boolean bool = true;
					if (mappingName.contains("_")) {
						coumnName = handleColumnLetter(mappingName, "column");
						bool = false;
					}
					if (bool) {
						for (int i = 0; i < mappingName.length(); i++) {
							if (mappingName.charAt(i) < '[') {
								coumnName = mappingName;
								bool = false;
								break;
							}
						}
					}
					if (bool) {
						coumnName = "null";
					}
				}
				if ((columnZhName == null) || (columnZhName.equals(""))) {
					String comment = rs.getString("COLUMN_COMMENT");
					if ((comment != null) && (!comment.equals("")))
						columnZhName = comment;
					else {
						columnZhName = "null";
					}
				}
				c.setMappingName(mappingName);
				c.setColumnName(coumnName);
				c.setColumnZhName(columnZhName);
				c.setShowOrder(Integer.valueOf(index));
				c.setMappingType(rs.getString("COLUMN_TYPE"));
				String columnType = (String) databaseConvertMap.get(rs.getString("DATA_TYPE"));
				if ((columnType == null) || (columnType.equals(""))) {
					throw new ServiceException("添加失败,请在数据库类型转换中配置" + rs.getString("DATA_TYPE"));
				}
				c.setColumnType(columnType);
				c.setTableId(table.getTableId());
				c.setProjectId(p.getProjectId());
				c.setIsDefault("NO");
				c.setIsShow("YES");
				if (rs.getString("COLUMN_KEY").equals("PRI")) {
					c.setIsPrimary("YES");
					c.setColumnZhName("序号");
					c.setIsCheck("NO");
					c.setIsRepeat("NO");
					c.setIsUpdate("NO");
				} else {
					c.setIsRepeat("YES");
					c.setIsPrimary("NO");
					c.setIsCheck("YES");
					c.setIsUpdate("YES");
				}
				String importPackage = (String) packageConvertMap.get(c.getColumnType());
				if (importPackage == null)
					c.setIsImportPackage("NO");
				else {
					c.setIsImportPackage("YES");
				}
				if ((c.getColumnName().toLowerCase().contains("img"))
						&& (c.getColumnName().toLowerCase().contains("image")))
					c.setShowType("IMAGE");
				else {
					c.setShowType("TEXT");
				}
				columnList.add(c);
				index++;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			return null;
		}
		return columnList;
	}

	private ArrayList<Column> queryColumnList(Connection conn, String databaseName, String tableName,
			List<ColumnConvert> columnConvertList) {
		String sql = "SELECT COLUMN_NAME,DATA_TYPE,COLUMN_TYPE,COLUMN_KEY,COLUMN_COMMENT FROM information_schema.Columns WHERE TABLE_NAME='"
				+ tableName + "' AND TABLE_SCHEMA='" + databaseName + "'";
		ArrayList<Column> columnList = new ArrayList<Column>();
		try {
			Map<String, String> columnConvertMap = new HashMap<String, String>();
			Map<String, String> translateMap = new HashMap<String, String>();
			if ((columnConvertList != null) && (columnConvertList.size() > 0)) {
				for (int j = 0; j < columnConvertList.size(); j++) {
					ColumnConvert cc = (ColumnConvert) columnConvertList.get(j);
					columnConvertMap.put(cc.getMappingName().toLowerCase(), cc.getColumnName());
					translateMap.put(cc.getMappingName().toLowerCase(), cc.getColumnZhName());
				}
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ((rs != null) && (rs.next())) {
				Column c = new Column();
				String mappingName = rs.getString("COLUMN_NAME");
				String coumnName = (String) columnConvertMap.get(mappingName.toLowerCase());
				String columnZhName = (String) translateMap.get(mappingName.toLowerCase());
				if ((coumnName == null) || (coumnName.equals(""))) {
					boolean bool = true;
					if (mappingName.contains("_")) {
						coumnName = handleColumnLetter(mappingName, "column");
						bool = false;
					}

					if (bool) {
						for (int i = 0; i < mappingName.length(); i++) {
							if (mappingName.charAt(i) < '[') {
								coumnName = mappingName;
								bool = false;
								break;
							}
						}
					}
					if (bool) {
						coumnName = "null";
					}
				}
				if (((columnZhName == null) || (columnZhName.equals("")))
						&& ((columnZhName == null) || (columnZhName.equals("")))) {
					String comment = rs.getString("COLUMN_COMMENT");
					if ((comment != null) && (!comment.equals("")))
						columnZhName = comment;
					else {
						columnZhName = "null";
					}
				}

				c.setMappingName(mappingName);
				c.setColumnName(coumnName);
				c.setColumnZhName(columnZhName);
				c.setIsShow("YES");
				if (rs.getString("COLUMN_KEY").equals("PRI")) {
					c.setIsPrimary("YES");
					c.setColumnZhName("序号");
				} else {
					c.setIsPrimary("NO");
				}
				if ((c.getColumnName().toLowerCase().contains("img"))
						&& (c.getColumnName().toLowerCase().contains("image")))
					c.setShowType("IMAGE");
				else {
					c.setShowType("TEXT");
				}
				columnList.add(c);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			return null;
		}
		return columnList;
	}

	private String workedTableName(String str) {
		if (str.contains("_")) {
			String[] values = str.split("_");
			str = "";
			for (int i = 0; i < values.length; i++) {
				String val = String.valueOf(values[i].charAt(0)).toUpperCase()
						+ values[i].substring(1, values[i].length());
				str = str + val;
			}
		}
		return handleColumnLetter(str, "table");
	}

	private String workedColumnName(String str) {
		if (str.contains("_")) {
			String[] values = str.split("_");
			str = String.valueOf(values[0].charAt(0)).toLowerCase() + values[0].substring(1, values[0].length());
			for (int i = 1; i < values.length; i++) {
				String val = String.valueOf(values[i].charAt(0)).toUpperCase()
						+ values[i].substring(1, values[i].length());
				str = str + val;
			}
		}
		return handleColumnLetter(str, "column");
	}

	private String workedColumnType(String str) {
		if (str.contains("(")) {
			str = str.substring(0, str.indexOf("("));
		}
		return str;
	}

	private boolean checkTableName(String tableName, Connection conn) {
		if (tableName.toLowerCase().contains("user")) {
			tableName = "'" + tableName + "'";
		}
		String sql = "select * from " + tableName;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if ((rs == null) && (!rs.next())) {
				return false;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}

	private String handleColumnLetter(String str, String flag) {
		if (str.contains("_")) {
			String rs = "";
			String[] strs = str.split("_");
			if (flag.equals("table")) {
				rs = String.valueOf(strs[0].charAt(0)).toUpperCase() + strs[0].substring(1, strs[0].length());
				for (int i = 1; i < strs.length; i++) {
					rs = rs + String.valueOf(strs[i].charAt(0)).toUpperCase() + strs[i].substring(1, strs[i].length());
				}
			} else {
				rs = String.valueOf(strs[0].charAt(0)).toLowerCase() + strs[0].substring(1, strs[0].length());
				for (int i = 1; i < strs.length; i++) {
					rs = rs + String.valueOf(strs[i].charAt(0)).toUpperCase() + strs[i].substring(1, strs[i].length());
				}
			}
			return rs;
		}
		return null;
	}
}
