<%@page import="board.BoardBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%

%>


<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<!-- Loding font -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:300,700"
	rel="stylesheet">
<!-- Custom Styles -->
<link href="css/login.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />

<%@include file ="navbar-white.jsp" %>
<style>

html{
     /* 드래그 방지 */
     -ms-user-select: none;
     -moz-user-select: -moz-none;
     -webkit-user-select: none;
     -khtml-user-select: none;
     user-select: none;
}
</style>

<script type="text/javascript">

function direct_index() {
	
	document.pay_result.action = "payHistory.jsp";
	document.pay_result.submit();
	
}

</script>


</head>


<body>

<div align="center" style="padding-top: 180px; padding-bottom: 100px;">
    <form name="pay_result" method="post" >	        
     	<!-- <img class="embed-responsive-item" src="https://ifh.cc/g/obrdKv.png"/> -->
     	<img src="img/eat_popcorn.jpg">
     	<br><br>
     	<h4><b>결제가 완료되었습니다.</b></h4>                  	
     	<br><br><br>
     	
	     <div class="login">      
	     <button type="button" onclick="javascript:direct_index()" class="btn btn-lg btn-block btn-success" style="width: 200px;">결제내역</button>
	     </div>     	
	</form>
</div>
</body>
  <%@include file ="footer.jsp" %>
</html>