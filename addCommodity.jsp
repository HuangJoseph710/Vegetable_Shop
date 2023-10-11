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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 引入icon的JS檔案 -->
  <script
    src="https://kit.fontawesome.com/8d21a50c85.js"crossorigin="anonymous">
  </script>
  <link rel="stylesheet" href="css/main.css">
<title>Vegetable Shop</title>
<style>
  *{
    margin: 0px;
    padding: 0px;
    box-sizing: border-box;
  }
  section {
    width: 100%;
    height: 600px;
  }
  table {
    margin: 5% auto;
  }
  table tr {
    margin: 10px 0;
  }
  table td {
    padding: 10px;
    margin: 10px;
  }
  .table-title {
    width: 30%;
  }
  .output input{
    width: 100%;
    background-color: rgba(100, 255, 100, 0.5);
    border: 0;
    border-radius: 10px;
  }
</style>
</head>
<body>
<!-- side-list-start -->
<input type="checkbox" name="" id="side-menu-switch" />
<aside class="side-menu">
  <div class="side-fixed">
    <form action="">
      <input type="search" placeholder="請輸入關鍵字" />
      <button><i class="fa-solid fa-magnifying-glass"></i></button>
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
<!-- side-list-end -->

<!-- 可編輯區-start -->
<main>
  <!-- scection 內放主要內容 -->
  <section>
    <form action="addCom.jsp" method="post">
      <table>
        <tr>
          <td class="table-title">商品圖片</td>
          <td><input type="file" name="product-photo" id=""></td>
        </tr>
        <tr>
          <td class="table-title">商品名稱</td>
          <td><input type="text" name="product-name" id=""></td>
        </tr>
        <tr>
          <td class="table-title">商品產地</td>
          <td><input type="text" name="product-origin" id=""></td>
        </tr>
        <tr>
          <td class="table-title">保存期限</td>
          <td><input type="text" name="expire-time" id=""></td>
        </tr>
        <tr>
          <td class="table-title">商品數量</td>
          <td><input type="number" name="number" id=""></td>
        </tr>
        <tr>
          <td class="table-title">價格</td>
          <td><input type="number" name="price" id=""></td>
        </tr>
        <tr>
          <td class="table-title">商品介紹</td>
          <td>
            <textarea name="sub" rows="5" cols="40"></textarea>
          </td>
        </tr>
        <tr class="output">
          <td class="table-title"><input type="button" value="取消回首頁" onclick="location.href='ProductsView.jsp'" ></td>
          <td><input type="button" value="上架商品囉！" onclick="submit()"></td>
        </tr>
      </table>
    </form>
  </section>

  <footer class="footer">
    <div class="footer-container">
      <div class="footer-col">
        <ul>
          <li><h4>Vegetable Shop</h4></li>
          <li><a href="index.html">回到首頁</a></li>
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
	  <div>訪客人數:111</div>
      copyright &copy; 1111多媒體程式設計期末專案
    </div>
  </footer>
</main>

</body>
</html>