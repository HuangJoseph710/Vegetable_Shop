<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	request.getSession(true);
	String user = (String)session.getAttribute("user");
	String product_ID = request.getParameter("product");
	if(user == null){
		response.sendRedirect("productInfo.jsp?product_ID="+product_ID);
	}
	else {
		String rate_stars = request.getParameter("rateStars");
		String comment = request.getParameter("commentContent");
	
		out.println("<p>"+user+"</p>");
		out.println("<p>"+comment+"</p>");
		try {
	//Step 1: 載入資料庫驅動程式 
			Class.forName("com.mysql.jdbc.Driver");
		try {
	//Step 2: 建立連線
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost/?serverTimezone=UTC";
			Connection con=DriverManager.getConnection(url,"root","1234");
			if(con.isClosed())
			  out.println("連線建立失敗");
			else {
			String sql="use vegetableshop";
			con.createStatement().execute(sql);
			comment=comment.replace("\n","<br>");
			java.sql.Date new_date=new java.sql.Date(System.currentTimeMillis());

	//Step 4: 執行 SQL 指令	
			   sql="insert comment (`username`, `product_id`, `date`, `rate_stars`, `content`) ";
			   sql+="values ('" + user + "', ";
			   sql+="'"+product_ID+"', ";
			   sql+="'"+new_date+"', ";
			   sql+="'"+rate_stars+"', ";
			   sql+="'"+comment+"') "; 
			   con.createStatement().execute(sql);
	//Step 6: 關閉連線
			   con.close();
	//Step 5: 顯示結果 
			  //直接顯示最新的資料
			   response.sendRedirect("productInfo.jsp?product_ID="+product_ID);
		   }
		}
		catch (SQLException sExec) {
			   out.println("SQL錯誤"+sExec.toString());
		}
	}
	catch (ClassNotFoundException err) {
	   out.println("class錯誤"+err.toString());
	}
}
%>
