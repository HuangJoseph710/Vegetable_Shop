<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String product_Id = request.getParameter("product_ID");
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

	sql="SELECT * FROM `products` WHERE `product_id` = "+product_Id;
	ResultSet rs=con.createStatement().executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- 嵌入 font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- 嵌入 bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <!-- 嵌入 購物車按鈕 -->
    <link rel="stylesheet" href="css/cartBtnStyle.css">
    <!-- 嵌入 評論系統 -->
    <link rel="stylesheet" href="css/ratingStyle.css">
    <!-- 嵌入 商品介面 -->
    <link rel="stylesheet" href="css/productInfoStyle.css">
	<style>
		.info {
			margin: auto;
			display: flex;
			justify-content: center;
			align-items: center;
		}
	</style>
</head>
<body>

    <div class="productInfo row justify-content-center">
        
        <!-- 回到首頁 -->
        <div class=".col-12">
            <a href="ProductsView.jsp">
                <div class="previousPage">
                    <i class="fa-solid fa-chevron-left"></i>
                    <span>回到首頁</span>
                </div>
            </a>
        </div>
		<div name="info">
			<form method="post" name="updateProduct" action="">
			<%
			   while(rs.next()){
			%>
			<!-- 蔬果圖片 -->
			<div class="">
				<img src="<%=rs.getString(9)%>" alt="蔬果照片" class="pic">
			</div>
			<br>
			<h2>圖片上傳</h2>
			<input type="file" name="product-photo" id="">
			<br>
			<!-- 文字說明 -->
			<div class="textArea col-lg-6">

				<!-- 顯示評分 -->

				<!-- 蔬果名稱 -->
				<h3>蔬果名稱:</h2>
				<input type="text" name="product_name" value="<%=rs.getString(2)%>"></h2>
				
				<!-- 蔬果簡述 -->
				<h3>蔬果簡述:</h2>
				<textarea name="sub" rows="5" cols="40" ><%=rs.getString(3)%></textarea>
				
				<!-- 蔬果價格 -->
				<h3>價格:</h2>
				<input type="text" name="price" value="<%=rs.getInt(6)%>">/ 斤</input>
				
				<h3>庫存數量:</h2>
				<input type="text" name="num" value="<%=rs.getInt(7)%>"></input>
				<!-- 加入購物車 -->
				<input type="hidden" name="product_id" value="<%=product_Id%>">
				
				<!-- 蔬果詳細資料 -->
				<div class="product_detail_content row mt-5">
					<div class="col-lg-4">
						<h4 class="content_title mb-3">原產地</h4>
						<input type="text" name="origin" value="<%=rs.getString(4)%>">
					</div>
					<div class="col-lg-8">
						<h4 class="content_title mb-3">保存期限</h4>
						<input type="text" name="expire_time" value="<%=rs.getString(5)%>">
					</div>
				</div>
			</div>
			<br>
			<div class="product_detail_content row mt-3">
				<div class="col-lg-1">
					<button onclick="document.updateProduct.action='deleteProd.jsp'">刪除
				</div>
				<div class="col-lg-1">
					<button onclick="document.updateProduct.action='updateProd.jsp'">修改
				</div>
			</div>
			</form>
		</div>
		<%
			}
		%>
        <!-- 留言板 -->
        
 <%
	con.close();
		}
	} catch (SQLException sExec) {
			   out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>
        </div>
        
        
        
    </div>
	
</body>
</html>