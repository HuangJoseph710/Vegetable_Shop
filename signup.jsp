<!-- Step 0: import library -->
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Sign up</title>
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
		   String username=request.getParameter("username");
		   String email=request.getParameter("userEmail");
		   String pwd=request.getParameter("userPWD");

//Step 4: 執行 SQL 指令
		   sql = "SELECT * FROM user WHERE username='" + username  + "'  OR email='" + email + "'"  ; 
		   ResultSet rs =con.createStatement().executeQuery(sql);
		   if(rs.next()){
			   String message = "名稱或Email已被使用過!!";
			   out.println("<SCRIPT LANGUAGE='JavaScript' charset='utf-8'>");
			   out.println("alert('"+message+"')");
			   out.println("</SCRIPT>");
			   response.setHeader("refresh", "0;url=registration.jsp");
		   }
		   else {
			 sql="insert user (username,email,pwd) ";
             sql+="value ('" + username + "', ";
		     sql+="'"+  email +"', ";
             sql+="'"+ pwd +"')";      

             con.createStatement().execute(sql);
//Step 6: 關閉連線
             con.close();
		     session.setAttribute("user", username);
			 String message = "歡迎加入!!";
			   out.println("<SCRIPT LANGUAGE='JavaScript'>");
			   out.println("alert('"+message+"')");
			   out.println("</SCRIPT>");
		     response.setHeader("refresh", "0;url=index.jsp");
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
