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
//Step 1: ���J��Ʈw�X�ʵ{�� 
    Class.forName("com.mysql.jdbc.Driver");
    try {
//Step 2: �إ߳s�u 	
        String url="jdbc:mysql://localhost/?serverTimezone=UTC";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("�s�u�إߥ���");
        else {
//Step 3: ��ܸ�Ʈw   
           sql="use vegetableshop";
           con.createStatement().execute(sql);
		   String pwd=request.getParameter("userPWD");

//Step 4: ���� SQL ���O
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
			   out.println("SQL���~"+sExec.toString());
			}
		}
           
       }
    catch (SQLException sExec) {
           out.println("SQL���~"+sExec.toString());
    }
}
catch (ClassNotFoundException err) {
   out.println("class���~"+err.toString());
}
%>
</body>
</html>
