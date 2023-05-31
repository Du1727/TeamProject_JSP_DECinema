<!-- -->
<%@page import="store.cartBean"%>
<%@page import="store.UtilMgr"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="store.storeBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="store.storeMgr"></jsp:useBean>
<jsp:useBean id="cmgr" class="store.cartMgr"></jsp:useBean>

<%
int idx = UtilMgr.parseInt(request, "product");
int quantity = UtilMgr.parseInt(request, "amount");
String id = (String)session.getAttribute("idKey");
cartBean bean = new cartBean();
bean.setId(id);
bean.setQuantity(quantity);
bean.setProductNo(idx);
boolean result = false;
String destination = "";
String msg = "";
if (id == null) {
	msg="로그인 해주세요!";
	destination="login.jsp";
}else{
	msg = "장바구니에 담았습니다!";
	result = cmgr.addCart(bean);
}

%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<script src="../assets/js/color-modes.js"></script>

<meta charset="utf-8">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.111.3">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>
<style type="text/css">
</style>
</head>
<script type="text/javascript">
$(document).ready(function() {
	$("#modal").modal("show");
});
function toCart(){
	location.href = "cart.jsp";
}
function toLogin(){
	location.href = "login.jsp";
}
function toHome(){
	location.href = "index.jsp";
}
function toStore(){
	location.href = "store_main.jsp";
}


</script>

<body>
<div class="modal" id="modal"tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><%=msg%></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" align="center">
      <%if(id == null){ %>
      <a class="btn-theme btn" href="javascript:toLogin()" style="  background-color: #74D36D;  border-color: rgba(255,255,255,0.1);
						color: #fff;"><i class="bi bi-person-fill"></i>&nbsp;&nbsp;로그인</a>&nbsp;&nbsp;	
        <button type="button" class="btn btn-primary" onclick="toHome()"><i class="bi bi-house"></i>&nbsp;&nbsp;홈페이지</button> 
      <%}else{ %>      					
		<a class="btn-theme btn" href="javascript:toCart()" style="  background-color: #74D36D;  border-color: rgba(255,255,255,0.1);
			color: #fff;"><i class="bi bi-cart-plus"></i>&nbsp;&nbsp;장바구니</a>&nbsp;&nbsp;
			<button type="button" class="btn btn-secondary customBtn"
			onclick="toStore()"><i class="bi bi-arrow-return-left"></i></button>        
       <%} %>
      </div>

    </div>
  </div>
</div>

</body>

</html>