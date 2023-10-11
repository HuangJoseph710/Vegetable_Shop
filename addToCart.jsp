<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
	
<%
	String User = (String)session.getAttribute("user");
	String product_Page = request.getParameter("product_page");
	String product_ID = request.getParameter("product_id");
	Cookie shoppingCartItems[] = request.getCookies();
	if(shoppingCartItems.length != 0) {
		for(int i=0;i<shoppingCartItems.length;i++){
			if(shoppingCartItems[i].getName().equals(product_ID)){
				out.print("<p>" + shoppingCartItems[i].getValue() + "</p>");
				Integer q = Integer.parseInt(shoppingCartItems[i].getValue());
				q+=1;
				out.print("<p>" + q + "</p>");
				shoppingCartItems[i].setValue(String.valueOf(q));
				response.addCookie(shoppingCartItems[i]);
				out.print("<p>" + shoppingCartItems[i].getValue() + "</p>");
				response.setHeader("refresh", "0;url=productInfo.jsp?product_ID=" + product_ID);
				break;
			}
			else {
				Cookie shoppingCart = new Cookie(product_ID, "1");
				shoppingCart.setMaxAge(60*60*24*30);
				response.addCookie(shoppingCart);
				out.print("<p>第二" + shoppingCartItems[i].getValue() + "</p>");
				response.setHeader("refresh", "0;url=productInfo.jsp?product_ID=" + product_ID);
			}
		}
	}
	
%>