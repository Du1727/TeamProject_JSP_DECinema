<!-- -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
	String index = "0";
	String title= "5월의 이벤트";
	if(request.getParameter("index") != null)
		index = request.getParameter("index");
	if(request.getParameter("title") != null)
		title = request.getParameter("title");	
%>
<!doctype html>

<%@include file ="navbar-white.jsp" %>	

<style>
.body{
	font-family: 배달의민족 도현;
}
</style>

 <body>
 	<main>
 	 <div class="container-lg" align="center">
<div class="container-lg">
	<h5 class="display-4" style="padding-top: 50px; text-align: center;"><%=title%></h5>                
	<div class="section-bottom" style="padding-bottom: 50px;"></div>
</div>
	<img src="./assets/event/section<%=index%>.jpg" alt="" width="80%" height="80%" style="padding-bottom: 100px;">
</div>
</main>
 </body>
<%@include file = "footer.jsp" %>
