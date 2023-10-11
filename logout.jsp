<%

    
    if(session.getAttribute("user") != null){            

		//request.getSession().removeAttribute("user");
		//request.getSession(true).invalidate(); 
		
		session.removeAttribute("user");
        response.sendRedirect("index.jsp") ;
	}else{
        out.println("µn¥X¿ù»~") ;
	}
%>

