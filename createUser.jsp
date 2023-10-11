<!-- Step 0: import library -->
<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<html>
<head>
<title>create table</title>
</head>
<body>
<%
try {
//Step 1: 載入資料庫驅動程式 
     Class.forName("com.mysql.jdbc.Driver");
     try {
//Step 2: 建立連線 	   
         String url="jdbc:mysql://localhost/?serverTimezone=UTC";
         String sql="";
         Connection con=DriverManager.getConnection(url,"root","1234");
         if(con.isClosed())
            out.println("連線建立失敗");
         else
           {
//Step 3: 選擇資料庫           
            sql="use vegetableshop";
            con.createStatement().execute(sql);
//Step 4: 執行 SQL 指令	        
            sql="CREATE TABLE user";
            sql+="(ID int(5) auto_increment,";
			sql+="userid varchar(45),";
            sql+="pwd char(16),";
            sql+="PRIMARY KEY(ID))";
            con.createStatement().execute(sql);
//Step 5: 顯示結果           
            out.println("list建立成功");
        }
//Step 6: 關閉連線        
        con.close();
     }
     catch (SQLException sExec) {
            out.println("SQL錯誤");
     }
}
catch (ClassNotFoundException err) {
       out.println("class錯誤");
}
%>
</body>
</html>
	