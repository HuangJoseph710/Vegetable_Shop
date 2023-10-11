<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
	
<%
	String product_ID = request.getParameter("product_ID");
	String oprt = request.getParameter("op");
	Cookie shoppingCartItems[] = request.getCookies();
	for(int i=0;i<shoppingCartItems.length;i++){
		if(shoppingCartItems[i].getName().equals(product_ID)){
			if(oprt.equals("plus")) {
				Integer q = Integer.parseInt(shoppingCartItems[i].getValue());
				q+=1;
				shoppingCartItems[i].setValue(String.valueOf(q));
				response.addCookie(shoppingCartItems[i]);
				response.setHeader("refresh", "0;url=cart.jsp");
				break;
			}
			else {
				Integer q = Integer.parseInt(shoppingCartItems[i].getValue());
				if(q-1 == 0){
					response.setHeader("refresh", "0;url=cart.jsp");
				}
				else {
					q-=1;
					shoppingCartItems[i].setValue(String.valueOf(q));
					response.addCookie(shoppingCartItems[i]);
					response.setHeader("refresh", "0;url=cart.jsp");
				}
				
					
			}
				
		}
	}
	
%>