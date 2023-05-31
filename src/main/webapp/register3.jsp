<%@page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>

<!doctype html>
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
</head>
<body>

    <div class="container" id="login">
        <div class="row justify-content-center">
	        <div class="col-lg-8">
	          <div class="login">         
	            <!-- Loging form -->
	                  <form name="register" method="post" action="login.jsp">	                  
	                  	<img class="embed-responsive-item" src="https://ifh.cc/g/obrdKv.png"/>
	                  	<br><br><br><br>
	                  	<h2 style="text-align: left; padding-left:25px; width: 1200px;">회원가입에 성공하였습니다!</h2>                  	
	                  	<br><br><br>
	                    <button type="submit" class="btn btn-lg btn-block btn-success" style="width: 200px;">로그인</button>
	                  </form>
	             <!-- End Loging form -->
	          </div>
	        </div>
        </div>  
    </div>	
</body>
<%@include file="footer.jsp"%>
</html>