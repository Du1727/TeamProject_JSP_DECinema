<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

	String id = (String) session.getAttribute("idKey");
	if(id==null) {
		response.sendRedirect("login.jsp");
	}
	String movieIdx = null;
	if(request.getParameter("movieIdx")!=null)
		session.setAttribute("movieIdx", request.getParameter("movieIdx"));
%>
<head>
<%@include file="/navbar-white.jsp"%>
</head>
<body>
	<div class="main" align="center">
		<iframe width="90%" height="100%" src="./ticketing/TicketingSection.jsp"></iframe>
	</div>
</body>
<%@include file="/footer.jsp"%>