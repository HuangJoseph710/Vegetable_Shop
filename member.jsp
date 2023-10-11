<%
	String loginState = "";
	String redirectURL = "login.jsp";
	String welcomeMsg = "請先登入";
	if( session.getAttribute("user") != null ){
		if( session.getAttribute("user").toString().equals("admin")) {
			loginState = "會員登出";
			redirectURL = "logout.jsp";
			welcomeMsg = "<a href='AllOrder.jsp'>"+session.getAttribute("user").toString()+"</a>";
		}
		else {
			loginState = "會員登出";
			redirectURL = "logout.jsp";
			welcomeMsg = session.getAttribute("user").toString() + "，歡迎回來";
		}
	} else {
		loginState = "會員登入/註冊";
	}
%>
<!DOCTYPE html>
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <link rel="stylesheet" href="css/registration.css">
<title>Vegetable Shop</title>
<script>
function checkForm(form) {
	if(form.pwd.value !== form.userPWD.value) {
		alert("兩次密碼不一致!");
	 return false
 }
} 
</script>
</head>
<body>
<!-- side-list-start -->
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
        <p>歡迎回來，<span><%=session.getAttribute("user")%></span></p>
      </li>
      <!-- 回去index.html -->
      <li>
        <a href="index.jsp"><img class="fa-solid" src="images/home.png"></img><span>回到首頁</span></a>
      </li>
      <!-- 加入購物車的清單然後讓user可以結帳 -->
      <li>
        <a href="cart.jsp"><img class="fa-solid" src="images/shopping-cart.png"></img><span>購物車</span></a>
      </li>
      <!-- 列出前後端組員、系級姓名、簡介與心得 -->
      <li>
        <a href="about.jsp"><img class="fa-solid" src="images/about-us.png"></img><span>關於我們</span></a>
      </li>
      </li>
       <!-- 連結到會員管理介面，包含改名字、頭貼、密碼、電子信箱、手機號碼等等 -->
      <li>
        <a href="member.jsp"><img class="fa-solid" src="images/member.png"></img><span>會員管理</span></a>
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
<!-- side-list-end -->
<%
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
	sql="use vegetableshop";
    con.createStatement().execute(sql);
	sql="SELECT * FROM user WHERE `username` = "+session.getAttribute("user");
	ResultSet rs =con.createStatement().executeQuery(sql);
	if(rs.next()){
%>
<!-- 可編輯區-start -->
<main>
  <!-- scection 內放主要內容 -->
  <section class="container">
    <div class="title">會員資料</div>
    <form method="post" action="change.jsp" onsubmit="return checkForm(this);">
      <div class="user-details">
        <div class="input-box">
          <span class="details">會員名稱</span>
          <input type="text" placeholder="<%=rs.getString(2)%>" readonly="readonly">
        </div>
        <div class="input-box">
          <span class="details">信箱</span>
          <input type="text" name="userEmail" placeholder="<%=rs.getString(3)%>" readonly="readonly">
        </div>
        <div class="input-box">
          <span class="details">密碼</span>
          <input type="password" name="pwd" placeholder="輸入密碼" required>
        </div>
        <div class="input-box">
          <span class="details">確認密碼</span>
          <input type="password" name="userPWD" placeholder="確認密碼" required>
        </div>
      </div>
      
      <div class="button">
        <input type="submit" value="修改">
      </div>
    </form>
</section>
<%
	}
}
con.close();
} catch (SQLException sExec) {
		out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>
  <!-- footer已完工 -->
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
      copyright &copy; 1111多媒體程式設計期末專案
    </div>
  </footer>
</main>

</body>
</html>