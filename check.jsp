<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost/?serverTimezone=UTC";
Connection con=DriverManager.getConnection(url,"root","1234");
String sql="use vegetableshop";
con.createStatement().execute(sql);
%>
<%
if(request.getParameter("username").equals("admin") && request.getParameter("userPWD").equals("1234")){
	session.setAttribute("user",request.getParameter("username"));
	response.sendRedirect("index.jsp");
}
if(request.getParameter("username") !=null && request.getParameter("userPWD") != null){
     sql = "SELECT * FROM user WHERE `username`=? AND `pwd`=?"  ;
	PreparedStatement pstmt = null;
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("username"));
	pstmt.setString(2,request.getParameter("userPWD"));
    ResultSet paperrs =pstmt.executeQuery();
    if(paperrs.next()){            
        session.setAttribute("user",request.getParameter("username"));
		con.close();
        response.sendRedirect("index.jsp");
    }
    else {
		String message = "帳號或密碼錯誤!!";
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
	    
		out.println("alert('"+message+"')");
		
		out.println("</SCRIPT>");
		response.setHeader("refresh", "0;url=index.jsp");
	}
}


%>


