<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String search = request.getParameter("searchContent");
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

	sql="SELECT * FROM `products` WHERE `product_name` LIKE '%"+search+"%' AND `product_name` LIKE '"+search+"%'";
	ResultSet rs=con.createStatement().executeQuery(sql);
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
        <li>
          <a href="cart.jsp"><img class="fa-solid" src="images/shopping-cart.png"></img><span>購物車</span></a>
        </li>
        <!-- 列出前後端組員、系級姓名、簡介與心得 -->
        <li>
          <a href="about.jsp"><img class="fa-solid" src="images/about-us.png"></img><span>關於我們</span></a>
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
  <main class="content">
    <!-- header-ads-start -->
    <header>
      <div class="slider">
        <div class="slides">
            <!-- 按鈕 -->
            <input type="radio" name="radio-btn" id="radio1">
            <input type="radio" name="radio-btn" id="radio2">
            <input type="radio" name="radio-btn" id="radio3">
            <input type="radio" name="radio-btn" id="radio4">

            <!-- 滑動 圖片 -->
            <div class="slide first">
              <img src="images/ads2.jpg">
            </div>
            <div class="slide">
              <img src="images/ads2.jpg">
            </div>
            <div class="slide">
              <img src="images/ads2.jpg">
            </div>
            <div class="slide">
              <img src="images/ads2.jpg">
            </div>

            <!-- 自動切換 -->
            <div class="navigation-auto">
              <div class="auto-btn1"></div>
              <div class="auto-btn2"></div>
              <div class="auto-btn3"></div>
              <div class="auto-btn4"></div>
            </div>

          </div>
          <!-- manual navigation -->
          <div class="navigation-manual">
            <label for="radio1" class="manual-btn"></label>
            <label for="radio2" class="manual-btn"></label>
            <label for="radio3" class="manual-btn"></label>
            <label for="radio4" class="manual-btn"></label>
          </div>
      </div>
    </header>
    <!-- header-script -->
    <script>
      var counter = 1;
      setInterval(function(){
        document.getElementById('radio' + counter).checked = true;
        counter++;
        if(counter > 4){
          counter = 1
        }
      }, 5000); /*數字控制切換頻率 單位:毫秒*/
    </script>
    <!-- header-ads-end -->

    <section class="commodity-wrap">
      <!-- 一個item是一個商品 -->
	 <%
		while(rs.next()){
	 %>
      <div class="commodity-item">
        <!-- 商品圖片 -->
        <img src="<%=rs.getString(9)%>" />
        <!-- 商品名稱 -->
        <a href="productInfo.jsp?product_ID=<%=rs.getString(1)%>" class="more-information">更多資訊</a>
        <article>
          <h3><%=rs.getString(2)%></h3>
          <!-- 商品敘述 -->
          <p>
            <%=rs.getString(3)%>
          </p>
          <!-- 商品售價 -->
          <p class="price">售價：$<%=rs.getInt(6)%></p>
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
    <footer class="footer">
      <div class="footer-container">
        <div class="footer-col">
          <ul>
            <li><h4>Vegetable Shop</h4></li>
            <li><a href="index.html">回到首頁</a></li>
            <li><a href="cart.html">購物車</a></li>
            <li><a href="about.html">關於我們</a></li>
            <li><a href="member.html">會員管理</a></li>
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