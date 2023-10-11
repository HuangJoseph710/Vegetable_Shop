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
  <link rel="stylesheet" href="css/about.css">
<title>Vegetable Shop</title>
</head>
<body>
  <%@ include file="sideMenu.jsp" %>

<!-- 可編輯區-start -->
<main>
  <!-- scection 內放主要內容 -->
  <section>
    <div class="wrap">
      <div class="item">
        <img src="images/11044143.jpg">
        <div class="text">
          <h2>前端 - 資管二甲 黃恆嘉</h2>
          <p>在這次的專案中我負責了前端的購物車介面與商品詳細資訊的介面，
            雖然課程只有對前端程式設計做基礎的介紹，但是在做專案的過程中，
            我透過研究他人的程式碼，學到了很多實戰的技巧，獲益良多。
          </p>
        </div>
      </div>
      <div class="item">
        <img src="images/11044144.jpg">
        <div class="text">
          <h2>前端 - 資管二甲 陳威宏</h2>
          <p>
            謝謝包容我的組員以及熱烈討論想要把專題做好的心，
            第一次利用分組實戰RWD功能，果然有團隊才能走得長遠。
          </p>
        </div>
      </div>
      <div class="item">
        <img src="images/11044145.jpg">
        <div class="text">
          <h2>前端 - 資管二甲 陳秉庭</h2>
          <p>
            這次的前端網頁設計我對css和JavaScript的使用都還不太熟練，
            但經過這次的專案後我也有慢慢的在進步，
            除此之外我也了解到了要把網頁設計的好看是一件非常不容易的事，
            希望未來我能夠多練習，讓我的技術持續進步。
          </p>
        </div>
      </div>
      <div class="item">
        <img src="images/jay.jpg">
        <div class="text">
          <h2>後端 - 資管二乙 傅子杰</h2>
          <p>資管二乙傅子杰， 我有一個感情很好的姐姐，我跟姐姐共用同一個爸媽，
            但我們從不曾為此吵過架，她下禮拜要去瑞典留學了，我想想念她的</p>
        </div>
      </div>
      <div class="item">
        <img src="images/S__11902989.jpg">
        <div class="text">
          <h2>後端 - 資管四乙 林心民</h2>
          <p>雖然第一次修沒有過，但是這次重修真的了解到網程是非常實用的東西，
            希望以後可以帶著學習到的東西繼續努力下去。</p>
        </div>
      </div>
      <div class="item">
        <img src="images/S__14721031.jpg">
        <div class="text">
          <h2>後端 - 資管四乙 李紹誠</h2>
          <p>透過本堂網路程式設計課程學習到了如何使用JSP配合Mysql去搭建一個購物網站，也了解到什麼是sql Injection，上完本學期的課程後，更加地了解到後端的運作方式</p>
        </div>
      </div>
      <div class="item">
        <img src="images/S__2072660.jpg">
        <div class="text">
          <h2>後端 - 資管二乙 簡承弘</h2>
          <p>上完這堂課我覺得自己受益良多，也學習了非常多的新知識，
            這段時間裡面，我經常遇到自己不會的問題，有時會去看老師的影片，
            有時會去問學長，我覺得這樣很像之後出社會的模擬，總而言之，這堂課讓我很滿意！</p>
        </div>
      </div>
    </div>
  </section>
  <footer class="footer">
    <div class="footer-container">
      <div class="footer-col">
        <ul>
          <li><h4>Vegetable Shop</h4></li>
          <li><a href="index.html">回到首頁</a></li>
          <li><a href="cart.html">購物車</a></li>
          <li><a href="about.html">關於我們</a></li>
          <li><a href="member.html">會員管理</a></li>
          <li><a href="add-commodity.html">上架商品</a></li>

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
      <div>訪客人數：111</div>
      copyright &copy; 1111多媒體程式設計期末專案
    </div>
  </footer>
</main>

</body>
</html>