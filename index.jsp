<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	sql="SELECT * FROM `products` ORDER BY `sell_quantity` DESC LIMIT 3 ";
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
  <%@ include file="sideMenu.jsp" %>
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

    <!-- 熱銷排行-->
    <h2>熱銷排行榜 TOP3</h2>
    <section class="commodity-wrap">
      <!-- template給後端處理！請包在wrap裡面 -->
	  <%
		while(rs.next()){
	  %>
      
        <!-- 一個item是一個商品 -->
      <div class="commodity-item hot-sales">
        <!-- span僅作為css處理用 -->
        <span></span>
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
          <p class="price">售價：$<%=rs.getInt(6)%></p>
        </article>
      </div>
		<%
			}
		%>
      <!-- 以下是前端顯示用，後端請刪除 -->

      <!-- 一個item是一個商品 -->
      
    </section>
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
        <a href="productInfo.jsp?product_ID=<%=rs2.getString(1)%>" class="more-information">更多資訊</a>
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