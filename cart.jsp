<%
	String loginState = "";
	if( session.getAttribute("user") != null ){
		loginState = "會員登出";
	}else{
		loginState = "會員登入/註冊";
		response.sendRedirect("login.jsp");
	}
	Cookie shoppingCart[] = request.getCookies();
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

	sql="SELECT * FROM `products` ";
	ResultSet rs=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
%>
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <!-- 嵌入 jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- 嵌入 cart -->
    <link rel="stylesheet" href="css/cartStyle.css">
</head>
<body>

    <section class="cart-page section-ptb">
    <form action="addToOrder.jsp" id="order" method="post" >
        <div class="container">
            <div class="row">
                <div class="col-xl-9 col-lg-9 col-md-8 col-12">
                    <div class="cart-title">
                        <h2>我的購物車 :</h2>
                        <span class="cart-count">

                            <!-- 輸出總共幾項商品 -->
                            <span class="bigcounter"><%=shoppingCart.length-1%></span>
                            <span class="cart-item-title">項商品</span>
                        </span>
                    </div>

                    <!-- 購物清單列表 -->
                    <div class="item-wrap cart-item-wrap">
                        <%	
							int subtotal = 0;
							int total = 0;
							int delivery_fee = 60;
							int index = 0;
							int g=shoppingCart.length;
							while(rs.next()){
								if(shoppingCart[index].getName().equals(rs.getString(1))){
						%>
                        <!-- 一項商品 start -->
                        <ul class="cart-wrap">
                            <!-- 商品資訊 -->
							<input type="hidden" name="product_ID" value="<%=shoppingCart[index].getName()%>"></input>
                            <li class="item-info">

                                <!-- 商品縮圖 -->
                                <div class="item-img">

                                    <!-- 連接至商品各自的頁面 -->
                                    <a href="productInfo.jsp?product_ID=<%=shoppingCart[index].getName()%>">
                                        <!-- 蔬果照片 -->
                                        <img src="<%=rs.getString(9)%>"/>
                                    </a>
                                </div>
                                <div class="item-title">

                                    <!-- 連接至商品各自的頁面 -->
                                    <a href="productInfo.jsp?product_ID=<%=shoppingCart[index].getName()%>"><%=rs.getString(2)%></a>
                                    <span class="item-option">
                                        <span class="pro-variant-title">單位:</span>

                                        <!-- 商品單位 -->
                                        <span class="pro-variant-type">顆</span>
                                    </span><span class="item-option">
                                        <span class="pro-variant-title">產地:</span>

                                        <!-- 商品產地 -->
                                        <span class="pro-variant-type"><%=rs.getString(4)%></span>
                                    </span>

                                    <span class="item-option">
                                        <!-- 商品售價 -->
                                        <span class="item-price">
                                            $<%=rs.getInt(6)%>
                                        </span>
                                    </span>
                                </div>
                            </li>

                            <!-- 商品購買數量 -->
                            <li class="item-qty">
                                <div class="product-quantity-action">
                                    <div class="product-quantity" data-variant="40039008862357">
                                        <div class="cart-plus-minus">

                                            <!-- 數量減少按鈕 -->
                                            <div class="dec qtybutton" onclick="if(this.parentNode.children.q.value == 1){return false};window.location.href='addQuantity.jsp?product_ID=<%=shoppingCart[index].getName()%>&op=minus';">-</div>

                                            <!-- 直接輸入數量、顯示數量 -->
                                            <input type="text" value="<%=shoppingCart[index].getValue()%>" name="quantity" id="q" class="qt"/>
                                        
                                            <!-- 數量增加按鈕 -->
                                            <div class="inc qtybutton" onclick="window.location.href='addQuantity.jsp?product_ID=<%=shoppingCart[index].getName()%>&op=plus';">+</div>
                                        </div>                                        

                                    </div>
                                </div>

                                <!-- 移除該項商品 -->
                                <div class="item-remove">
                                    <span class="remove-wrap">
                                        <a href="deleteItem.jsp?item_id=<%=shoppingCart[index].getName()%>">移除此商品</a>
                                    </span>
                                </div>
                            </li>
                            <li class="item-price">
                                <span class="amount full-price">

                                    <!-- 該項商品小計(產品單價*數量) -->
                                    <span class="money amount full-price-40039008862357" id="subtotal">$
									<%
										int Quantity = Integer.parseInt(shoppingCart[index].getValue());
										subtotal = Quantity*rs.getInt(6);
										total+=subtotal;
										out.println(subtotal);
									%>
									<input type="hidden" name="subTotal" value="<%=subtotal%>">
									</span>
                                </span>
                            </li>
                        </ul>
                        <!-- 一項商品 end -->
                        <%
							if(index+1<g)index++;
							rs.beforeFirst();
							}
						}
						%>
                        <!-- 以下測試時 顯示用的，連接後端後可刪 -->
                        
                        <!-- 以上測時時 顯示用的，連接後端後可刪 -->
                        
                    </div>

                    <div class="cart-buttons">
                        <a class="btn btn-style1" href="index.jsp">繼續購物</a>

                        <!-- 清空購物車、跳至空購物車介面 -->
                        <a class="btn btn-style1" href="deleteAll.jsp">清除購物車</a>
                    </div>

                </div>

                <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                    <div class="cart-total-wrap">
                        <div class="cart-sub-total">
                            <span class="subtotal-title">商品總額</span>
                            <span class="amount subtotal">
                                <!-- 商品總額 -->
                                <span class="bold_cart_total" style="display:none !important;"></span>
                                $<%=total%>
                            </span>
                        </div>

                        <!-- 宅配資訊 -->
                        <div class="cart-sub-total cancelBorder1">
                            <div class="shipping">
                                <div>
                                    <label for="address">付款方式:</label>
                                    <select name="payment">
										<option value="貨到付款">貨到付款
										<option value="信用卡">信用卡
										<option value="Line Pay">Line Pay
										<option value="銀行轉帳">銀行轉帳
									</select>
                                </div>
                                <div>
                                    <label for="address">運送方式:</label>
                                    <select name="delivery">
										<option value="宅配">宅配
										<option value="7-11取貨">7-11取貨
										<option value="全家取貨">全家取貨
										<option value="OK取貨">OK取貨
									</select>
                                </div>
                                
                            </div>
                        </div>

                        <div class="cart-sub-total cancelBorder2">
                            <span class="subtotal-title">運費</span>
                        <span class="amount subtotal">
                            <span class="bold_cart_total" style="display:none !important;"></span>
                            $60.00
                        </span>
                        </div>
                        <!-- 待處理 end -->

                        <div class="cart-total">
                            <span class="total-amount">
                                <span class="total-title">總額</span>
                                <span class="amount total-price">
                                    <!-- 商品總額+60 -->
                                    <span class="bold_cart_total" style="display:none !important;"></span>
                                    $<%
										total+=60;
										out.print(total);
									%>
                                </span>
								<input type="hidden" name="Total" value="<%=total%>">
                            </span><div class="proceed-to-checkout">
                                <a  class= "btn-style1 center" onclick="document.getElementById('order').submit()">送出訂單</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
	 <%
	con.close();
		}
	} catch (SQLException sExec) {
			   out.println("<p>SQL錯誤"+sExec.toString()+"</p>");
	}
%>
    </section>
    

</body>
</html>