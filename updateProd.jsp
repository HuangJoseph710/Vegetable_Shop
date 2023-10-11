<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%
	request.setCharacterEncoding("utf-8");
	request.getSession(true);
	String product_ID = request.getParameter("product_id");
	String img_file = request.getParameter("product-photo");
	String name = request.getParameter("product_name");
	String origin = request.getParameter("origin");
	String Expire_time = request.getParameter("expire_time");
	String Num = request.getParameter("num");
	String Price = request.getParameter("price");
	String subscription = request.getParameter("sub");
	out.println("商品圖片:"+img_file);
	out.println("商品名稱:"+name);
	out.println("商品產地:"+origin);
	out.println("商品期限:"+Expire_time);
	out.println("商品數量:"+Num);
	out.println("商品價格:"+Price);
	out.println("商品簡介:"+subscription);
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

//Step 4: 執行 SQL 指令
		try{
		   sql = "UPDATE `products` set `product_name`='"+ name + "',";
		   sql+="`subscription`='"+subscription+"',";
		   sql+="`origin`='"+origin+"',";
		   sql+="`expire_time`='"+Expire_time+"',";
		   sql+="`price`='"+Price+"',";
		   sql+="`inventory`='"+Num+"',";
		   sql+="`img`='images/"+img_file+"'";
		   sql+="WHERE `product_id`=" +"'"+ product_ID + "'";
		   con.createStatement().executeUpdate(sql);
		   con.close();
		   String message = "Success";
			   out.println("<SCRIPT LANGUAGE='JavaScript' charset='big5'>");
			   out.println("alert('"+message+"')");
			   out.println("</SCRIPT>");
		   response.sendRedirect("ProductsView.jsp");
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