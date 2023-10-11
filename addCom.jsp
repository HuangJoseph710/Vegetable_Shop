<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%
	request.setCharacterEncoding("utf-8");
	request.getSession(true);
	String img_file = request.getParameter("product-photo");
	String name = request.getParameter("product-name");
	String origin = request.getParameter("product-origin");
	String Expire_time = request.getParameter("expire-time");
	String num = request.getParameter("number");
	String Price = request.getParameter("price");
	String subscription = request.getParameter("sub");
	out.println("商品圖片:"+img_file);
	out.println("商品名稱:"+name);
	out.println("商品產地:"+origin);
	out.println("商品期限:"+Expire_time);
	out.println("商品數量:"+num);
	out.println("商品價格:"+Price);
	out.println("商品簡介:"+subscription);
	try{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost/?serverTimezone=UTC";
	Connection con=DriverManager.getConnection(url,"root","1234");
	if(con.isClosed())
	  out.println("連線建立失敗");
	else {
		String sql="use vegetableshop";
		con.createStatement().execute(sql);
		sql="insert products (`product_name`, `subscription`, `origin`, `expire_time`, `price`, `inventory`, `img`) ";
		sql+="values ('" + name + "', ";
		sql+="'"+  subscription +"', ";
		sql+="'"+  origin +"', ";
		sql+="'"+  Expire_time +"', ";
		sql+="'"+  Price +"', ";
		sql+="'"+  num +"', ";
		sql+="'images/"+ img_file +"')";
		con.createStatement().execute(sql);
		response.sendRedirect("ProductsView.jsp");
	}
	con.close();
	} catch (SQLException sExec) {
		out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>