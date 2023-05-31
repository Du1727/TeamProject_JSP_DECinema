<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="store.UtilMgr"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="store.storeBean"%>
<%@page import="member.MemberBean"%>
<%@page import="store.cartBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="smgr" class="store.storeMgr" />
<jsp:useBean id="cmgr" class="store.cartMgr" />
<jsp:useBean id="mmgr" class="member.MemberMgr" />
<%
	//세션을 통해 아이디 확인 후 로그인 안되어있으면 로그인 페이지로 사출
	String id = (String) session.getAttribute("idKey");
	if (id == null) {
		response.sendRedirect("login.jsp");
		return; // 이후에 코드를 무력화
	}
	Vector<cartBean> vlist = cmgr.getCart(id);
	MemberBean mBean = mmgr.getMember(id);
	String[] category = smgr.getCategory();
	int lastprice = 0; 			// 총 상품금액
	double discountRate = 0;    // 할인율
	if(mBean.getGrade().equals("Bronze")){
		
	}else if(mBean.getGrade().equals("Gold")){
		
	}else if(mBean.getGrade().equals("Bronze")){
		
	}
	int discountPrice = 0;      // 할인금액
	int last_payPrice = 0; 		// 최종 결재 금액 
	
%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
¿<script src="../assets/js/color-modes.js"></script> 

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<script>

	
	function deleteCart(no) {
		document.deleteFrm.flag.value = "delete";
		document.deleteFrm.cartNo.value = no;
		document.deleteFrm.action = "cartProc.jsp";
		document.deleteFrm.submit();
	}
	function buyCart() {
		document.payFrm.flag.value = "buy";
		document.payFrm.action = "cartProc.jsp";
		document.payFrm.submit();
	}
	function toStore() {
		location.href ="store_main.jsp";
	}
</script>
<%@include file="/navbar-white.jsp"%>
</head>
<body>
	<main>
		<div class="container-lg">
			<img src="https://ifh.cc/g/C9B70Z.jpg"
				class="product-img img-fluid mx-auto d-block " alt="...">
	
			<div class="nav-scroller py-1 mb-2" id="list-example">
				<nav class="nav d-flex justify-content-around">
					<a class="nav-link p-2 link-secondary" href="store_main.jsp#best"><h4>베스트</h4></a>
					<%for (int i = 0; i < category.length; i++) {%>
					<a class="nav-link p-2 link-secondary" href="store_main.jsp#store<%=i%>"><h4><%=category[i]%></h4></a>
					<%}%>				
					<a class="nav-link p-2 link-secondary" href="cart.jsp"><h4>장바구니</h4></a>				
				</nav>
			</div>
		</div>
		<div class="container-lg">
			<hr>
			<div class="container-lg gap-10">
				<table class="table">
					<thead class="table-dark">
						<tr>
							<th width="60%" scope="col" class="text-center">상품명</th>
							<th width="8%" scope="col" class="text-center">판매금액</th>
							<th width="8%" scope="col" class="text-center">수량</th>
							<th width="8%" scope="col" class="text-center">구매금액</th>
							<th width="16%" scope="col" class="text-center">선택상품 삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (int i = 0; i < vlist.size(); i++) {
							cartBean bean = vlist.get(i);
							storeBean pbean = smgr.getProduct(bean.getProductNo());
							int totalprice = bean.getQuantity() * pbean.getPrice();
							lastprice += totalprice;
						%>
						
						<tr>
						
							<th class="text-center align-middle"><%=pbean.getName()%></th>
							<td class="text-center align-middle" ><%=UtilMgr.monFormat(pbean.getPrice())%> 원</td>
							<td class="text-center align-middle" ><%=bean.getQuantity()%></td>
							<td class="text-center align-middle"><%=totalprice%> 원</td>
							<td class="text-center align-middle">
							
							
							<button type="button" class="btn align-middle" onclick="javascript:deleteCart('<%=bean.getNo()%>')"><i class="bi bi-trash fs-2"></i></button>
								
								<form name="completeFrm" method="post" >
									<input type="hidden" name="flag"/>
									
									<input type="hidden" name="cartNo" value="<%=bean.getNo() %>"/>
									<input type="hidden" name="productPrice" value="<%=UtilMgr.monFormat(pbean.getPrice())%> 원"/>
									<input type="hidden" name="productQuantity" value="<%=bean.getQuantity()%>"/>
									<input type="hidden" name="productNo" value="<%=pbean.getIdx()%>"/>
								</form>
								
							</td>
								
						</tr>
				
						<%
						}
						%>

					</tbody>
				</table>
			</div>


			<div class="container-lg gap-5" style="padding-top: 25px;">
				<table class="table">
					<thead class="table-active">
						<tr>
							<th width="25%" scope="col" class="text-center">총 상품 금액</th>
							<th width="10%" scope="col" class="text-center"></th>
							<th width="25%" scope="col" class="text-center">할인금액</th>
							<th width="40%" scope="col" class="text-center">총결제 예정금액</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (mBean.getGrade().equals("bronze")) {
							discountRate = 0.1;
						} else if (mBean.getGrade().equals("silver")) {
							discountRate = 0.15;
						} else if (mBean.getGrade().equals("gold")) {
							discountRate = 0.18;
						} else if (mBean.getGrade().equals("vip")) {
							discountRate = 0.2;
							//System.out.println("등급 vip적용");
						}
						
						
						
						discountPrice = (int)Math.ceil(lastprice * discountRate); 
						last_payPrice = lastprice - discountPrice;
						
						
						
						
						%>
						<tr>
							<td class="text-center align-middle"><%=UtilMgr.monFormat(lastprice)%> 원</td>
							<td class="text-center align-middle"><i class="bi bi-dash fs-3"></i></td>
							<td class="text-center align-middle"><%=UtilMgr.monFormat(discountPrice)%> 원</td>
							<td class="text-center align-middle"><%=UtilMgr.monFormat(last_payPrice)%> 원</td>
						</tr>

					</tbody>
				</table>
			</div>
			<div align="right" style="padding-right: 20px; padding-bottom: 200px;">
			<a class="btn-theme btn" href="javascript:buyCart()" style="  background-color: #6799FF;  border-color: rgba(255,255,255,0.1);
						color: #fff;"><i class="bi bi-credit-card-fill"></i>&nbsp;&nbsp;구매하기</a>
			</div>
		</div>
		
		<form name="payFrm" method="post">
			<input type="hidden" name="flag"/>
			<input type="hidden" name="last_payPrice" value="<%=last_payPrice%>"/>
		</form>
		
		<form name="deleteFrm" method="post" >
			<input type="hidden" name="flag"/>
			<input type="hidden" name="cartNo"/>
		</form>
									
	</main>
</body>

<%@include file="footer.jsp"%>
</body>
</html>
