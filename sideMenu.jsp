<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<input type="checkbox" name="" id="side-menu-switch" />
  <aside class="side-menu">
    <div class="side-fixed">
      <form action="search.jsp" method="get">
        <input type="search" name="searchContent" placeholder="請輸入關鍵字" />
        <button onclick="submit();"><i class="fa-solid fa-magnifying-glass"></i></button>
      </form>
      <ul class="nav">
        <li class="nav-li">
          <!-- user name -->
          <p><%=welcomeMsg%><span></span></p>
        </li>
        <!-- 回去index.html -->
        <li class="nav-li">
          <a href="index.jsp"><img class="fa-solid" src="images/home.png"></img><span>回到首頁</span></a>
        </li>
        <!-- 加入購物車的清單然後讓user可以結帳 -->
        <li class="nav-li">
          <a href="cart.jsp"><img class="fa-solid" src="images/shopping-cart.png"></img><span>購物車</span></a>
        </li>
        <!-- 歷史訂單 -->
        <li class="nav-li">
          <a href="history.jsp"><img class="fa-solid" src="images/history.png"></img><span>歷史訂單</span></a>
        </li>
        <!-- 列出前後端組員、系級姓名、簡介與心得 -->
        <li class="nav-li">
          <a href="about.jsp"><img class="fa-solid" src="images/about-us.png"></img><span>關於我們</span></a>
        </li>
         <!-- 連結到會員管理介面，包含改名字、頭貼、密碼、電子信箱、手機號碼等等 -->
        <li class="nav-li">
          <a href="member.jsp"><img class="fa-solid" src="images/member.png"></img><span>會員管理</span></a>
        </li>
        <!-- 登入前顯示「登入/註冊」，會員登入後顯示「登出」，不知道有沒有辦法做到(？ -->
        <li class="nav-li">
          <a href="<%=redirectURL%>"><i class="fa-solid"></i><span><%=loginState%></span></a>
        </li>
      </ul>
    </div>
    <!-- side-menu的按鈕 -->
    <label for="side-menu-switch">
      <i class="fa-solid fa-greater-than"></i>
    </label>
  </aside>