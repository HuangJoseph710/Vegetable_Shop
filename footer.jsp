<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer class="footer">
      <div class="footer-container">
        <div class="footer-col">
          <ul>
            <li><h4>Vegetable Shop</h4></li>
            <li><a href="index.jsp">回到首頁</a></li>
            <li><a href="cart.jsp">購物車</a></li>
            <li><a href="about.jsp">關於我們</a></li>
            <li><a href="member.jsp">會員管理</a></li>
          </ul>
        </div> 
        <div class="footer-col">
          <div class="social-links">
            <h4>follow us</h4>
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
          </div>
        </div>
      </div>
      <div class="copyright">
	  <%
		int count;
		String countString;
		try {
		String sql="";
		String url="jdbc:mysql://localhost/?serverTimezone=UTC";
		Connection con=DriverManager.getConnection(url,"root","1234");
		if(con.isClosed())
		out.println("連線建立失敗");
		else{
		sql="use vegetableshop";
		con.createStatement().execute(sql);	
		sql="select * from counter" ;
		ResultSet rs=con.createStatement().executeQuery(sql);

		if (rs.next()){
		countString = rs.getString(1);
		count = Integer.parseInt(countString);
		//Object obj = session.getAttribute("online");
		//if (obj == null){ //判斷session是否結束
		if (session.isNew())
		{
			count=count + 1;
		countString = String.valueOf(count);
		sql="update counter set count = " + countString ;
		con.createStatement().execute(sql);
		session.setAttribute("online",count);
		}
		out.println("<div>您是第" + count + "位訪客。</div>");
		}

			   con.close();
			  }


		}
		catch(Exception err)
		{
			out.println(err.toString());
		}
	%>
        copyright &copy; 1111多媒體程式設計期末專案
      </div>
    </footer>