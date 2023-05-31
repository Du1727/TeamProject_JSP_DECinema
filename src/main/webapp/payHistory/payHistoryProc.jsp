<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String sortType = request.getParameter("sortType");
	session.setAttribute("sortType", sortType);
	response.sendRedirect("../payHistory.jsp");
%>