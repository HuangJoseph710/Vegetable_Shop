<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String Item = request.getParameter("item_id");
	Cookie shoppingCart[] = request.getCookies();
	for(int i=0;i<shoppingCart.length-1;i++){
		if(shoppingCart[i].getName().equals(Item)){
			shoppingCart[i].setMaxAge(0);
			response.addCookie(shoppingCart[i]);
			response.setHeader("refresh", "0;url=cart.jsp");
		}
	}

%>