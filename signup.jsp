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
		   String username=request.getParameter("username");
		   String email=request.getParameter("userEmail");
		   String pwd=request.getParameter("userPWD");

//Step 4: ���� SQL ���O
		   sql = "SELECT * FROM user WHERE username='" + username  + "'  OR email='" + email + "'"  ; 
		   ResultSet rs =con.createStatement().executeQuery(sql);
		   if(rs.next()){
			   String message = "�W�٩�Email�w�Q�ϥιL!!";
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
//Step 6: �����s�u
             con.close();
		     session.setAttribute("user", username);
			 String message = "�w��[�J!!";
			   out.println("<SCRIPT LANGUAGE='JavaScript'>");
			   out.println("alert('"+message+"')");
			   out.println("</SCRIPT>");
		     response.setHeader("refresh", "0;url=index.jsp");
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
