<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginState = "";
	String redirectURL = "login.jsp";
	String welcomeMsg = "請先登入";
	if( session.getAttribute("user").toString().equals("admin")) {
			loginState = "會員登出";
			redirectURL = "logout.jsp";
			welcomeMsg = "<a href='AllOrder.jsp'>"+session.getAttribute("user").toString()+"</a>";
	}
	else {
		response.sendRedirect("index.jsp");
	}
try{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost/?serverTimezone=UTC";
	Connection con=DriverManager.getConnection(url,"root","1234");
	if(con.isClosed())
	  out.println("連線建立失敗");
	else {
	String sql="use vegetableshop";
	con.createStatement().execute(sql);
	request.setCharacterEncoding("utf-8");
	request.getSession(true);

	
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 引入icon的JS檔案-->
  <script
    src="https://kit.fontawesome.com/8d21a50c85.js"crossorigin="anonymous">
  </script>
  <link rel="stylesheet" href="css/main.css">
  <link rel="stylesheet" href="css/index.css">
<title>Vegetable Shop</title>
</head>
<body>
  <input type="checkbox" name="" id="side-menu-switch" />
  <aside class="side-menu">
    <div class="side-fixed">
      <form action="search.jsp" method="get">
        <input type="search" name="searchContent" placeholder="請輸入關鍵字" />
        <button onclick="submit();"><i class="fa-solid fa-magnifying-glass"></i></button>
      </form>
      <ul class="nav">
        <li>
          <!-- user name -->
          <p><%=welcomeMsg%><span></span></p>
        </li>
        <!-- 回去index.html -->
        <li>
          <a href="index.jsp"><img class="fa-solid" src="images/home.png"></img><span>回到首頁</span></a>
        </li>
        <!-- 加入購物車的清單然後讓user可以結帳 -->
        <!-- 列出前後端組員、系級姓名、簡介與心得 -->
        <li>
          <a href="about.jsp"><img class="fa-solid" src="images/about-us.png"></img><span>關於我們</span></a>
        </li>
         <!-- 連結到會員管理介面，包含改名字、頭貼、密碼、電子信箱、手機號碼等等 -->
        <li>
          <a href="AllOrder.jsp"><img class="fa-solid" src="images/member.png"></img><span>訂單瀏覽</span></a>
        </li>
		<li>
          <a href="addCommodity.jsp"><img class="fa-solid" src="images/member.png"></img><span>新增商品</span></a>
        </li>
		<li>
          <a href="ProductsView.jsp"><img class="fa-solid" src="images/member.png"></img><span>商品管理</span></a>
        </li>
        <!-- 登入前顯示「登入/註冊」，會員登入後顯示「登出」，不知道有沒有辦法做到(？ -->
        <li>
          <a href="<%=redirectURL%>"><i class="fa-solid"></i><span><%=loginState%></span></a>
        </li>
      </ul>
    </div>
    <!-- side-menu的按鈕 -->
    <label for="side-menu-switch">
      <i class="fa-solid fa-greater-than"></i>
    </label>
  </aside>
  <main class="content">
    <!-- header-ads-start -->
    <!-- header-script -->
    <!-- header-ads-end -->

    <!-- 熱銷排行-->
    
    <h2><img src="">所有商品</h2>
    <section class="commodity-wrap">
      <!-- 一個item是一個商品 -->
	 <%
		sql="SELECT * FROM `products` ORDER BY `sell_quantity` DESC";
		ResultSet rs2=con.createStatement().executeQuery(sql);
		while(rs2.next()){
	 %>
      <div class="commodity-item">
        <!-- 商品圖片 -->
        <img src="<%=rs2.getString(9)%>" />
        <!-- 商品名稱 -->
        <a href="ProductContent.jsp?product_ID=<%=rs2.getString(1)%>" class="more-information">更多資訊</a>
        <article>
          <h3><%=rs2.getString(2)%></h3>
          <!-- 商品敘述 -->
          <p>
            <%=rs2.getString(3)%>
          </p>
          <!-- 商品售價 -->
          <p class="price">售價：$<%=rs2.getInt(6)%></p>
        </article>
      </div>
	  <%}%>
     
    </section>
  <!-- 可編輯區-end -->
 <%
	con.close();
		}
	} catch (SQLException sExec) {
			   out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>
  <!-- footer -->
  <%@ include file="footer.jsp" %>
  </main>
</body>
</html>