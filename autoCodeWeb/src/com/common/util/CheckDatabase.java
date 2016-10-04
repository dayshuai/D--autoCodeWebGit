/*    */ package com.common.util;
/*    */ 
/*    */ import com.autocode.base.BaseController;
/*    */ import java.sql.Connection;
/*    */ import java.sql.DriverManager;
/*    */ import org.apache.commons.lang.StringUtils;
/*    */ 
/*    */ public class CheckDatabase extends BaseController
/*    */ {
/*    */   public static boolean checkDatabase(String batabaseName, String databaseType, String ip, Integer port, String username, String password)
/*    */   {
/*    */     try
/*    */     {
/* 15 */       String url = null;
/* 16 */       Connection conn = null;
/* 17 */       if (StringUtils.equals("MySql", databaseType)) {
/* 18 */         url = "jdbc:mysql://" + ip + ":" + port + "/" + batabaseName;
/* 19 */         Class.forName("com.mysql.jdbc.Driver");
/* 20 */         conn = DriverManager.getConnection(url, username, password);
/* 21 */       } else if (StringUtils.equals("SqlServer", databaseType)) {
/* 22 */         url = "jdbc:sqlserver://" + ip + ":" + port + ";databaseName=" + batabaseName + ";";
/* 23 */         Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
/* 24 */         conn = DriverManager.getConnection(url, username, password);
/* 25 */       } else if (StringUtils.equals("Oracle", databaseType)) {
/* 26 */         Class.forName("oracle.jdbc.driver.OracleDriver");
/* 27 */         url = "jdbc:oracle:thin:@" + ip + ":" + port + ":" + batabaseName;
/*    */       }
/* 29 */       conn = DriverManager.getConnection(url, username, password);
/* 30 */       if (conn == null)
/* 31 */         return false;
/*    */       try
/*    */       {
/* 34 */         conn.close();
/*    */       } catch (Exception localException1) {
/*    */       }
/* 37 */       return true;
/*    */     } catch (Exception e) {
/* 39 */       e.printStackTrace();
/* 40 */     }return false;
/*    */   }
/*    */ }

/* Location:           C:\Users\day\Desktop\代码生生成器\autocode\WEB-INF\classes\
 * Qualified Name:     com.ys.util.CheckDatabase
 * JD-Core Version:    0.6.2
 */