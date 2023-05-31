<%@page contentType="text/html; charset=UTF-8"%>

<%

	application.setAttribute("rootPath", request.getContextPath());
	String cookie = "";
	Cookie[] cookies = request.getCookies();
	if(cookies !=null&& cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("userId")) {
				cookie = cookies[i].getValue();
			}
		}
	}
	
%>

<!doctype html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1, shrink-to-fit=no">
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

<%@include file="navbar-white.jsp"%>
<script type="text/javascript" src="js/loginscript.js"></script>
</head>
<body>
    <div class="container" id="login">
        <div class="row justify-content-center">
	        <div class="col-lg-8">
	          <div class="login">
	            <h1>Login</h1>            
	            <!-- Login form -->
	                  <form name="loginFrm" method="post" action = "<%=application.getAttribute("rootPath")%>/LoginAction">
	                    <div class="form-group">
	                      <input type="text" class="form-control" id="id" name="id" placeholder="아이디" value="<%=cookie%>">                     
	                    </div>
	                    <div class="form-group">
	                      <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호">
	                    </div>
	                      <div class="form-check">
	                      <label class="switch">
	                      <input type="checkbox" id="checkId" name="checkId" 
	                      <% if(cookie != "") { %>
	                      	checked="checked"
	                      <% } %>>
	                      <span class="slider round"></span>
	                    </label>
	                      <label class="form-check-label" for="checkId">아이디 저장</label>                      
	                      <label class="forgot-password"><a href="register.jsp">아이디가 없으신가요?</a></label>
	                    </div>                  
	                    <br>
	                    <button type="button" class="btn btn-lg btn-block btn-success" onclick="javascript:loginCheck(document.loginFrm.id.value, document.loginFrm.pw.value)">로그인</button>
	                  </form>
	             <!-- End Login form -->
	          </div>
	        </div>
        </div>  
    </div>	
</body>
<%@include file="footer.jsp"%>
</html>