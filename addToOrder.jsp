<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.*" %> 
<%
try {
//Step 1: 載入資料庫驅動程式 
    Class.forName("com.mysql.jdbc.Driver");
    try {
//Step 2: 建立連線
		request.setCharacterEncoding("utf-8");
        String url="jdbc:mysql://localhost/?serverTimezone=UTC";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("連線建立失敗");
        else {
//Step 3: 選擇資料庫   
           sql="use vegetableshop";
           con.createStatement().execute(sql);
		   String username=(String)session.getAttribute("user");
		   String Payment=request.getParameter("payment");
		   String Delivery=request.getParameter("delivery");
		   String subtotal[] = request.getParameterValues("subTotal");
		   String total = request.getParameter("Total");
		   String Products[] = request.getParameterValues("product_ID");
		   String Quantity[] = request.getParameterValues("quantity");
		   
		   java.sql.Date new_date=new java.sql.Date(System.currentTimeMillis());
		   
		   out.println(username);
		   out.println(Payment);
		   out.println(total);
		   out.println(Delivery+"<br>");
		   sql="insert `order` (`username`, `date`,`payment`, `total_payment`, `delivery`) ";
           sql+="value ('" + username + "', ";
		   sql+="'"+  new_date +"', ";
		   sql+="'"+  Payment +"', ";
		   sql+="'"+  total +"', ";
           sql+="'"+ Delivery +"')";      

           con.createStatement().execute(sql);
		   try{
			 sql="SELECT LAST_INSERT_ID()";
			 ResultSet rs = con.createStatement().executeQuery(sql);
			 rs.next();
			 String last_id = rs.getString(1);
			 String product_Name = "";
			 Cookie shoppingCart[] = request.getCookies();
			 ResultSet rs2;
			 for(int i=0;i<Products.length;i++){
					 out.println("last:"+last_id+"商品:"+Products[i]+"數量:"+Quantity[i]+"小計:"+subtotal[i]+"<br>");
					 sql="SELECT `inventory`,`sell_quantity`,`product_name` FROM products WHERE `product_id` = " + Products[i];
					 rs2 = con.createStatement().executeQuery(sql);
					 rs2.next();
					 int sold_quantity = Integer.parseInt(Quantity[i]);
					 int new_inventory = Integer.parseInt(rs2.getString(1))-sold_quantity;
				     int new_quantity = Integer.parseInt(rs2.getString(2))+sold_quantity;
					 product_Name = rs2.getString(3);
					 sql="UPDATE `products` set `inventory`='"+ new_inventory +"',`sell_quantity` = " + "'" + new_quantity + "' WHERE `product_id`=" + Products[i];
					 con.createStatement().execute(sql);
					 sql="insert order_details (`order_id`, `product_id`, `product_name`, `item_quantity`, `subtotal`) ";
					 sql+="values ('" + last_id + "', ";
					 sql+="'"+  Products[i] +"', ";
					 sql+="'"+  product_Name +"', ";
					 sql+="'"+  Quantity[i] +"', ";
					 sql+="'"+ subtotal[i] +"')";
					 con.createStatement().execute(sql);
					 
					 shoppingCart[i].setMaxAge(0);
					 response.addCookie(shoppingCart[i]);
				}
				response.sendRedirect("index.jsp");
			}
			catch (SQLException sExec) {
				out.println("LAST SQL錯誤"+sExec.toString());
			}
		}
		   
		   
		   
//Step 4: 執行 SQL 指令
			
//Step 6: 關閉連線
             con.close();
	}      
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
    }
}
catch (ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}
%>