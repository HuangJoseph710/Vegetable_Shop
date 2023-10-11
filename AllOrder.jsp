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
	String user_id = (String)session.getAttribute("user");
	sql="SELECT * FROM `order`";
	ResultSet rs=con.createStatement().executeQuery(sql);
	String order_ID = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" href="history.css">
	<link rel="stylesheet" href="css/main.css">
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
    <section class="flex-column">
        
        <div class="tittle">歷史訂單</div>
        <br>
		<%
		while(rs.next()){
			order_ID = rs.getString(1);
		%>
        <!-- 一筆歷史訂單 start -->
        <div class="historyWrap">
            <!-- 訂單宅配資訊 -->
            <div class="row shippingInfo">
                <div class="col-12 ">

                    <!-- 訂單完成時間 -->
                    <div class="timeTittle">
                        <%=rs.getString(3)%>
                    </div>
                </div>
                <div class="col-12">

                    <!-- 收件人 -->
                    <div class="addressee">
                        付款方式: <span><%=rs.getString(4)%></span>
                    </div>
                </div>
                <div class="col-12">

                    <!-- 電話號碼 -->
                    <div class="phoneNum">
                        運送方式: <span><%=rs.getString(6)%></span>
                    </div>
                </div>
                <div class="col-12">

                    <!-- 該訂單總金額 -->
                    <div class="totalPrice">
                        總金額: <span><%=rs.getString(5)%>元</span>
                    </div>
                </div>

            </div>
            <hr>
		<%
			
			sql="SELECT * FROM `order_details` WHERE `order_id` ='"+ order_ID +"'";
			ResultSet rs2=con.createStatement().executeQuery(sql);
			
		%>
            <!-- 訂單詳細資訊 -->
            <div class="goodsList row">
                <!-- 一樣產品 -->
				<%
					while(rs2.next()){
				%>
                <div class="col-12 goodsWrap">

                    <!-- 商品名 -->
                    <div class="goodsName">
                        <%=rs2.getString(3)%>
                    </div>

                    <!-- 商品數量 -->
                    <div class="goodsQty">
                        <%=rs2.getString(4)%>公斤
                    </div>

                    <!-- 商品小計 -->
                    <div class="goodsSubtotal">
                        <%=rs2.getString(5)%>元
                    </div>
                    
                </div>
				<%}%>
                <!-- 以下測試用，連接後端後刪除 -->
              
                <!-- 以上測試用，連接後端後刪除 -->

            </div>

        </div>
        <!-- 一筆歷史訂單 end -->
		<%
			
		}
			con.close();
		}
			} catch (SQLException sExec) {
					   out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
			}
		%>
        <!-- 以下測試用，連接後端後刪除 -->
        
        <!-- 以上測試用，連接後端後刪除 -->
    </section>
	<%@ include file="footer.jsp" %>
</body>
</html>