<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="member.MemberMgr"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String idList[] = mgr.getMemberIdAll();
	String idListString = idList[0];
	for (int i = 1; i < idList.length; i++) {
		idListString = idListString + "/" + idList[i];
	}
%>

<!doctype html>
<html>
<script type="text/javascript" src="js/regscript.js"></script>
<head>
<!-- Required meta tags -->
<meta charset="UTF-8">
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

<%@include file="navbar-white.jsp"%>
</head>
<body>
    <div class="container" id="register" align="center" style="padding-bottom: 500px;">
        <div class="row justify-content-center">
	        <div class="col-lg-8">
	          <div class="login">
	            <h3>회원가입</h3>            
	            <!-- Register form -->
	                  <form name="regFrm" method="post" action="registerProc.jsp">
	                    <div class="form-group2">	         
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-tag"></i> 아이디</h6>             
	                        <input type="text" class="form-control" id="id" name="id" maxlength="20" onkeyup="javascript:idCheck(this.form.id.value)" onchange="javascript:duplicateCheck('<%=idListString%>',this.form.id.value)">
	                        <h6 id = "idText" style="color: rgb(50,50,50); padding-top: 10px; padding-bottom: 15px;">📌 5~20자 영문 소문자, 숫자</h6>						    					  
	                    </div>
	                    <div class="form-group2">
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-unlock"></i> 비밀번호</h6>
	                      <input type="password" class="form-control" id="pw" name="pw" maxlength="16" onkeyup="javascript:pwCheck(this.form.pw.value)">
	                      <h6 id = "pwText" style="color: rgb(50,50,50); padding-top: 10px; padding-bottom: 15px;">📌 8~16자 영문 대 소문자, 숫자, 특수문자</h6>
	                    </div>
	                    <div class="form-group2">
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-lock"></i> 비밀번호 확인</h6>
	                      <input type="password" class="form-control" id="pwd" name="pwd" maxlength="16" onkeyup="javascript:pwdCheck()" onchange="javascript:pwdCheck()">
	                      <h6 id = "pwdText" style="color: rgb(50,50,50); padding-top: 10px; padding-bottom: 15px;">📌 비밀번호와 일치</h6>
	                    </div>
	                    <br><br>                  
	                    <div class="form-group2">	                    
	                      <div class="row">                                       
	                      	<div class="col-8">	
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-user-tag"></i> 이름</h6>
	                    		<input type="text" class="form-control" style="width: 300px;" id="name" name="name" maxlength="6" onkeyup="javascript:nameCheck()">
	                    	</div>	                    		                    	
	                    	<div class="col-3">	                    	
	                    <h6 style="text-align:right; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-venus-mars"></i> 성별</h6>                    	
		                		<div class="form-check" style=""><label class="switch"><input type="checkbox" id="gender" name="gender"><span class="gender round" style="width:100px; height:50px;"></span></label></div>		                	
		                	</div>		                	  
	                    </div>	                    
	                    <br>
	                    <div class="form-group2">
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-envelope"></i> 생년월일</h6>	                      
	                      <input type="date" class="form-control" id="birthday" name="birthday">                      
	                    </div>
	                    <br>	  
	                    </div>
	                    <br><br>                 
	                    <div class="form-group2">           
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-phone"></i> 휴대전화</h6>
	                      <input type="text" class="form-control" id="phone" name="phone" onkeyup="javascript:phoneCheck()">  
	                    </div>	                    
	                    <br>   
	                    <div class="form-group2">	                      
	                    <h6 style="text-align:left; color: rgb(50,50,50); padding-top: 7px; padding-bottom: 1px;"><i class="fa-solid fa-envelope"></i> 이메일(선택)</h6>
	                      <input type="email"  class="form-control" id="mail" name="mail" placeholder="example@email.com">                      
	                    </div>
	                    <br><br><br>
	                    <button type="button" class="btn btn-lg btn-block btn-success" style="width: 200px;" onclick="javascript:inputCheck()">가입하기</button>                                    
	                  </form>
	             <!-- End Register form -->
	          </div>
	        </div>
        </div>  
    </div>	
    <%@include file="footer.jsp"%>
</body>
</html>