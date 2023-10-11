<!-- Step 0: import library -->
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>change</title>
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
        else {
//Step 3: 選擇資料庫   
           sql="use vegetableshop";
           con.createStatement().execute(sql);
		   String pwd=request.getParameter("userPWD");

//Step 4: 執行 SQL 指令
		try{
		   sql = "UPDATE user set `pwd`='"+ pwd +"'WHERE username=" +"'"+ session.getAttribute("user") + "'"; 
		   con.createStatement().executeUpdate(sql);
		   con.close();
		   String message = "Success";
			   out.println("<SCRIPT LANGUAGE='JavaScript' charset='big5'>");
			   out.println("alert('"+message+"')");
			   out.println("</SCRIPT>");
		   response.setHeader("refresh", "0;url=index.jsp");
			}
			catch (SQLException sExec) {
			   out.println("SQL錯誤"+sExec.toString());
			}
		}
           
       }
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
    }
}
catch (ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}
%>
</body>
</html>
