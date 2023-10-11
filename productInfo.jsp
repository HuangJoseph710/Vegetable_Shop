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
	sql="SELECT * FROM `comment` WHERE `product_id` = "+product_Id; //算出共幾筆留言
	ResultSet rs2=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
        
	//先移到檔尾, getRow()後, 就可知道共有幾筆記錄
	rs2.last();
	int total_content=rs2.getRow();
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
	<script>
		function addToCart() {
			setTimeout(() => document.shoppingCart.submit(), 4400);
		};
	</script>
</head>
<body>

    <div class="productInfo row justify-content-center">
        
        <!-- 回到首頁 -->
        <div class=".col-12">
            <a href="index.jsp">
                <div class="previousPage">
                    <i class="fa-solid fa-chevron-left"></i>
                    <span>回到首頁</span>
                </div>
            </a>
        </div>
        
		<%
		   while(rs.next()){
		%>
        <!-- 蔬果圖片 -->
        <div class="imgArea position-relative d-flex justify-content-center align-items-center col-lg-6">
            <img src="<%=rs.getString(9)%>" alt="蔬果照片" class="pic">
        </div>

        <!-- 文字說明 -->
        <div class="textArea col-lg-6">

            <!-- 顯示評分 -->
            <div class="rating_wrap">
                <div class="rating_review_cont d-flex d-flex align-items-center">
                    <ul class="rating_star ul_li">
                        <!-- 此處控制顯示星星數量 -->
                        <li class="active"><i class="fas fa-star"></i></li>
                        <li class="active"><i class="fas fa-star"></i></li>
                        <li class="active"><i class="fas fa-star"></i></li>
                        <li class="active"><i class="fas fa-star"></i></li>
                        <li><i class="far fa-star"></i></li>
                    </ul>
                    <!-- 此處控制顯示訊息數量 -->
                    <a href="#seeComment" class="review">瀏覽 <%=total_content%> 則評論</a>
                </div>
            </div>

            <!-- 蔬果名稱 -->
            <h2 class="product_detail_title"><%=rs.getString(2)%></h2>

            <!-- 蔬果簡述 -->
            <p class="product_detail_desc py-2"><%=rs.getString(3)%></p>
            
            <!-- 蔬果價格 -->
            <h1>$ <%=rs.getInt(6)%> / 斤</h1>
			<p>庫存數量:<%=rs.getInt(7)%></p>
            <!-- 加入購物車 -->
			<form method="post" name="shoppingCart" action="addToCart.jsp">
			<input type="hidden" name="product_page" value="productInfo?product_ID=<%=product_Id%>">
			<input type="hidden" name="product_id" value="<%=product_Id%>">
            <div class="addToCart">
                <button onclick="addToCart('234')" class="cartButton">
                    <span>加入購物車</span>
                    <div class="cart">
                        <svg viewBox="0 0 36 26">
                            <polyline points="1 2.5 6 2.5 10 18.5 25.5 18.5 28.5 7.5 7.5 7.5"></polyline>
                            <polyline points="15 13.5 17 15.5 22 10.5"></polyline>
                        </svg>
                    </div>
                </button>
            
                <script>
                    document.querySelectorAll(".cartButton").forEach((button) =>
                        button.addEventListener("click", (e) => {
                            if (!button.classList.contains("loading")) {
                                button.classList.add("loading");
            
                                setTimeout(() => button.classList.remove("loading"), 3700);
                            }
                            e.preventDefault();
                        })
                    );
                </script>
            </div>
            </form>
            <!-- 蔬果詳細資料 -->
            <div class="product_detail_content row mt-5">
                <div class="col-lg-4">
                    <h4 class="content_title mb-3">原產地</h4>
                    <h5><%=rs.getString(4)%></h5>
                </div>
                <div class="col-lg-8">
                    <h4 class="content_title mb-3">保存期限</h4>
                    <h5><%=rs.getString(5)%></h5>
                </div>
            </div>
        </div>
		<%
			}
		%>
        <!-- 留言板 -->
        <div class="product_comment col-lg-6" id="seeComment">
            <h3 class="title_text">商品評論:<br></h3>
            <ul class="review_comment_list ul_li_block">
			<%
			try{

				//遞減排序, 讓最新的資料排在最前面
				sql="SELECT * FROM `comment` WHERE `product_id`='" + product_Id + "' ORDER BY `comment_id` DESC";
				rs=con.createStatement().executeQuery(sql);
				while(rs.next())
					{
						  
			%>
                <!-- 一則評論 start -->
                <li class="review_comment_wrap">

                    <!-- 評論者名字 -->
                    <h4 class="admin_name"><%=rs.getString(2)%>
                        <!-- 評論時間 -->
                        <span class="comment_date"><%=rs.getString(4)%></span>
                    </h4>
                    <ul class="rating_star ul_li">
                        <!-- 此處控制顯示星星數量 -->
						<%for(int i=0;i<rs.getInt(5);i++){	
						%>
							<li class="active"><i class="fas fa-star"></i></li>
						<%
						}
						%>
						<%for(int i=0;i<5-rs.getInt(5);i++){	
						%>
							<li class=""><i class="fas fa-star"></i></li>
						<%
						}
						%>
                    </ul>

                    <!-- 使用者評論 -->
                    <p class="mb-0">
                        <%=rs.getString(6)%>
                    </p>
                </li>
                <!-- 一則評論結束 -->
			<%
				}
				//Step 6: 關閉連線
						  con.close();
					}
					catch (SQLException sExec) {
						   out.println("SQL錯誤"+sExec.toString());
						   
					}
			%>
                <!-- 以下單純測試用 後端加上去後請刪 -->
                <!-- 以上測試用 -->

            </ul>
        </div>

        <!-- 評分留言系統 -->
        <div class="col-lg-6 product_rating">
            <div class="container">
                <div class="post">
                  <div class="text">感謝你的評論</div>
                  <div class="edit">編輯</div>
                </div>
				
					<div class="star-widget">
					
					  <input type="radio" name="rate" id="rate-5" value="5">
					  <label for="rate-5" class="fas fa-star"></label>
					  <input type="radio" name="rate" id="rate-4" value="4">
					  <label for="rate-4" class="fas fa-star"></label>
					  <input type="radio" name="rate" id="rate-3" value="3">
					  <label for="rate-3" class="fas fa-star"></label>
					  <input type="radio" name="rate" id="rate-2" value="2">
					  <label for="rate-2" class="fas fa-star"></label>
					  <input type="radio" name="rate" id="rate-1" value="1">
					  <label for="rate-1" class="fas fa-star"></label>

					  <!-- 使用者評論輸入 -->
				<form name="comment" action="comment.jsp" method="post">
							<header></header>
							<div class="textarea">
								<input type="hidden" name="rateStars" value="">
								<input type="hidden" name="product" value="<%=product_Id%>">
								<textarea cols="30" name="commentContent" placeholder="在這裡留下評論..."></textarea>
							</div>
							<div class="btn">
								<button class="submitBtn">送出</button>
							</div>
                 </form>

                </div>
              </div>
 <%
	con.close();
		}
	} catch (SQLException sExec) {
			   out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>
              <script>
                const btn = document.querySelector(".submitBtn");
                const post = document.querySelector(".post");
                const widget = document.querySelector(".star-widget");
                const editBtn = document.querySelector(".edit");
                btn.onclick = ()=>{
                    widget.style.display = "none";
                    post.style.display = "block";

                    editBtn.onclick = ()=>{
                        widget.style.display = "block";
                        post.style.display = "none";
                    }
					document.comment.rateStars.value = document.querySelector('input[name="rate"]:checked').value;
					return true
                }
              </script>
        </div>
        
        
        
    </div>
	
</body>
</html>