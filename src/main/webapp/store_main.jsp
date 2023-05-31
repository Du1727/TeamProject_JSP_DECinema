<!-- -->
<%@page import="member.MemberBean"%>
<%@page import="store.UtilMgr"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="store.storeBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="store.storeMgr"></jsp:useBean>
<jsp:useBean id="mmgr" class="member.MemberMgr"></jsp:useBean>

<%
String id = "";
id = (String) session.getAttribute("idKey");
String authority = "user";
String path = "./assets/img/store/";
//권한 확인
if (id != null) {
	MemberBean mbean = new MemberBean();
	mbean = mmgr.getMember(id);
	authority = mbean.getAuthority();
}
String[] category = mgr.getCategory();
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
<link href="css/store.css" rel="stylesheet" />
<link href="bootstrap/.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>
<style type="text/css">
</style>
<script>
	
	function sendCart() {
		var product = document.getElementById('productIdx').value;
        document.getElementById('form-d').submit();	
    }
	
	function modal(name,detail,price,idx,path) {
		var result = price.toLocaleString();
		document.forms['form-detail'].reset();
		$(".modal-body #modalImg").attr("src", path);
		$(".modal-body #productName").text(name);
		$(".modal-body #productDetail").text(detail);
		$(".modal-body #productIdx").val(idx);
		$(".modal-body #ownprice").val(result);
		$(".modal-body #sell_price").val(result);
		$("#detail").modal("show");

	}
	function closeModal() {
		$("#detail").modal("hide");

	}

	function fnCalCount(type, ths) {
		var $input = $(ths).parents("td").find("input[name='amount']");
		var tCount = Number($input.val());
		var tEqCount = Number($(ths).parents("tr").find("td.bseq_ea").html());
		var price = document.getElementById('ownprice').value;
		price = parseInt(price.replaceAll(",",""));
		if (type == 'p') {
			if (tCount < tEqCount){
				$input.val(Number(tCount) + 1);
				$(".modal-body #sell_price").val((price*((tCount) + 1)).toLocaleString());
			}
		} else {
			if (tCount > 1){
				$input.val(Number(tCount) - 1);
				$(".modal-body #sell_price").val((price*((tCount) - 1)).toLocaleString());
			}
		}
		
	}
	$(document).on("click", ".open-productDetail", function() {
		var myBookId = $(this).data('id');
		$(".modal-body #bookId").val(myBookId);
	});
	
	function productInsert(){
	    var _width = '500';
	    var _height = '600';
	    var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.height - _height )/2);

	    window.open('store_insert.jsp', '상품 추가', 'width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top );        
    }
	function productUpdate(productno){
		var _width = '500';
	    var _height = '600';
	    var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.height - _height )/2);

	    window.open("store_update.jsp?productNo="+productno, '상품 정보 수정', 'width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top );		
   }
	
</script>
<%@include file="/navbar-white.jsp"%>
</head>

<body>
	<div class="container-lg">
		<img src="https://ifh.cc/g/C9B70Z.jpg"
			class="product-img img-fluid mx-auto d-block " alt="...">

		<div class="nav-scroller py-1 mb-2" id="list-example">
			<nav class="nav d-flex justify-content-around">
				<a class="nav-link p-2 link-secondary" href="#best"><h4>베스트</h4></a>
				<%
				for (int i = 0; i < category.length; i++) {
				%>
				<a class="nav-link p-2 link-secondary" href="#store<%=i%>"><h4><%=category[i]%></h4></a>
				<%
				}
				%>
				<a class="nav-link p-2 link-secondary" href="cart.jsp"><h4>장바구니</h4></a>
				<%
				if (authority.equals("admin")) {
				%>
				<a class="nav-link p-2 link-secondary"
					href="javascript:productInsert()"><h4>
						<i class="bi bi-plus-circle"></i>&nbsp;관리
						<h4></h4></a>
				<%
				}
				%>
			</nav>
		</div>
	</div>
	<main class="container-lg">
		<div data-bs-spy="scroll" data-bs-target="#list-example"
			data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
			<div>
				<h3 id="best" style="padding-top: 35px;">
					<i class="fa-solid fa-star"></i>&nbsp;베스트
				</h3>
				<hr width="130px" color="#FF0000"
					style="color: #FF0000; height: 5px;">
				<div class="row row-cols-1 rofw-cols-xs-3 g-4"
					style="padding-left: 30px; padding-top: 20px">
					<!-- 카드 생성 부분 -->
					<%
					Vector<storeBean> blist = mgr.getHighLight();
					for (int i = 0; i < blist.size(); i++) {
						storeBean bean2 = blist.get(i);
					%>
					<%
					if (authority.equals("admin")) {
					%>
					<div class="card" style="width: 18rem;">
						<div class="product text-center" style="height: 200px">

							<form method="post" id="proInfo">
								<a class="open-productDetail nav-link mx-auto"
									style="width: 16rem; height: 16rem;"
									onclick="productUpdate(<%=bean2.getIdx()%>)">
									<figure>
										<img class="embed-responsive-item" id="productImg<%%>"
											src="<%=path + bean2.getImage()%>"
											style="width: 200px; height: 200px;">

										<figcaption>
											<i class="bi bi-pencil-square fs-3"></i> <input type="hidden"
												name="productNo" id="productNo" value="<%=bean2.getIdx()%>" />
										</figcaption>
									</figure>
								</a>
							</form>
						</div>
						<div class="col p-4 d-flex flex-column position-static">
							<div class="mb-1 text-body-secondary text-center"
								style="font-size: 20px;"><%=bean2.getName()%></div>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=bean2.getDetail()%></p>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=UtilMgr.monFormat(bean2.getPrice())%> 원</p>
						</div>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%
					} else {
					if (bean2.getStatus() == 1) {
					%>
					<div class="card" style="width: 18rem;">
						<div class="product text-center" style="height: 200px">
							<a class="open-productDetail nav-link mx-auto"
								style="width: 16rem; height: 16rem;"
								onclick="modal('<%=bean2.getName()%>','<%=bean2.getDetail()%>',<%=bean2.getPrice()%>,<%=bean2.getIdx()%>,'<%=path + bean2.getImage()%>')">
								<figure>
									<img class="embed-responsive-item"
										src="<%=path + bean2.getImage()%>"
										style="width: 200px; height: 200px;">
									<figcaption>
										<i class="bi bi-cart-plus fs-3"></i>
									</figcaption>
								</figure>
							</a>

						</div>
						<div class="col p-4 d-flex flex-column position-static">
							<div class="mb-1 text-body-secondary text-center"
								style="font-size: 20px;"><%=bean2.getName()%></div>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=bean2.getDetail()%></p>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=UtilMgr.monFormat(bean2.getPrice())%> 원</p>
						</div>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%
					}
					}
					}
					%>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<%
			for (int i = 0; i < category.length; i++) {
			%>
			<div>

				<h3 id="store<%=i%>" style="padding-top: 35px;">
					<i class="fa-solid fa-check"></i>&nbsp;<%=category[i]%></h3>
				<%
				if (category[i].length() > 2) {
				%>
				<hr width="130px" color="#6B66FF"
					style="color: #6B66FF; height: 5px;">
				<%
				} else {
				%>
				<hr width="100px" color="#6B66FF"
					style="color: #6B66FF; height: 5px;">
				<%
				}
				%>
				<div class="row row-cols-1 row-cols-xs-3 g-4"
					style="padding-left: 30px; padding-top: 20px">
					<!-- 카드 생성 부분 -->

					<%
					Vector<storeBean> vlist = mgr.getProductCategory(category[i]);//
					for (int j = 0; j < vlist.size(); j++) {
						storeBean bean = vlist.get(j);
						//if(bean.getImage()!=null){
						//System.out.print(path+bean.getImage());
						//}
					%>



					<%
					if (authority.equals("admin")) {
					%>
					<div class="card" style="width: 18rem;">
						<div class="product text-center" style="height: 200px">

							<form method="post" id="proInfo">
								<a class="open-productDetail nav-link mx-auto"
									style="width: 16rem; height: 16rem;"
									onclick="productUpdate(<%=bean.getIdx()%>)">
									<figure>
										<img class="embed-responsive-item" id="productImg<%%>"
											src="<%=path + bean.getImage()%>"
											style="width: 200px; height: 200px;">

										<figcaption>
											<i class="bi bi-pencil-square fs-3"></i> <input type="hidden"
												name="productNo" id="productNo" value="<%=bean.getIdx()%>" />
										</figcaption>
									</figure>
								</a>
							</form>
						</div>
						<div class="col p-4 d-flex flex-column position-static">
							<div class="mb-1 text-body-secondary text-center"
								style="font-size: 20px;"><%=bean.getName()%></div>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=bean.getDetail()%></p>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=UtilMgr.monFormat(bean.getPrice())%> 원</p>
						</div>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%
					} else {
					if (bean.getStatus() == 1) {
					%>
					<div class="card" style="width: 18rem;">
						<div class="product text-center" style="height: 200px">
							<a class="open-productDetail nav-link mx-auto"
								style="width: 16rem; height: 16rem;"
								onclick="modal('<%=bean.getName()%>','<%=bean.getDetail()%>',<%=bean.getPrice()%>,<%=bean.getIdx()%>,'<%=path + bean.getImage()%>')">
								<figure>
									<img class="embed-responsive-item"
										src="<%=path + bean.getImage()%>"
										style="width: 200px; height: 200px;">
									<figcaption>
										<i class="bi bi-cart-plus fs-3"></i>
									</figcaption>
								</figure>
							</a>

						</div>
						<div class="col p-4 d-flex flex-column position-static">
							<div class="mb-1 text-body-secondary text-center"
								style="font-size: 20px;"><%=bean.getName()%></div>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=bean.getDetail()%></p>
							<p class="card-text mb-auto text-center" style="font-size: 20px;"><%=UtilMgr.monFormat(bean.getPrice())%> 원</p>
						</div>
					</div>

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%
					}
					}
					}
					%>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<%
			}
			%>
		</div>
	</main>
</body>
<label style="padding-top: 50px;"></label>
<%@include file="footer.jsp"%>
<!-- Modal -->
<form name="form-detail" id="form-d" method="post"
	action="store_main_proc.jsp">
	<div class="modal fade" id="detail" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="productname"></h5>
					<button type="button" class="btn-close customBtn"
						data-bs-dismiss="modal" aria-label="Close" onclick="closeModal()"></button>
				</div>
				<div class="modal-body">
					<div class="container d-flex flex-column-reverse">
						<div class="card mb-3 border-0 justify-content-center "
							style="max-width: 540px;">
							<div class="row g-0">
								<div class="col-xs-5">
									<img src="" id="modalImg" class="mx-auto d-block" width="200px"
										height="200px" alt="">
								</div>
								<div class="col-xs-7">
									<div class="card-body">
										<table class="mx-auto">
											<tr>
												<td height="60px" class="d-none"><input type="text"
													id="productIdx" name="product"></td>
											</tr>
											<tr>
												<td height="60px" class="text-center border-bottom"><h5
														id="productName"></h5></td>
											</tr>
											<tr>
												<td height="60px" class="text-center"><h5
														id="productDetail"></h5></td>
											</tr>
											<tr>
												<td height="60px" class="text-center">상품가격 <input
													id="ownprice" name="ownprice" value="" readonly="readonly"
													style="text-align: center; width: 100px; height: 50px; border: 0 solid black; font-size: 25px;"></td>
											</tr>


										</table>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-mx-5"></div>
								<div class="col-mx-7">
									<table class="mx-auto">
										<tr style="text-align: center;">
											<td class="bseq_ea d-none">5</td>
											<td class="updown col">
												<button type="button" class="btn customBtn"
													onclick="fnCalCount('m', this);">
													<i class="bi bi-dash fs-2"></i>
												</button> <input type="text" class="amount mx-auto" name="amount"
												value="1" readonly="readonly"
												style="text-align: center; width: 50px; height: 50px; border: 0 solid black; font-size: 25px;"/>
												<button type="button" class="btn customBtn"
													onclick="fnCalCount('p',this);">
													<i class="bi bi-plus fs-2"></i>
												</button>
											</td>
										</tr>
										<tr>
											<td height="60px" class="text-center">총 상품 금액 <input
												id="sell_price" name="sell_price" value=""
												readonly="readonly"
												style="text-align: center; width: 100px; height: 50px; border: 0 solid black; font-size: 25px;"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary customBtn"
						onclick="closeModal()">
						<i class="bi bi-arrow-return-left"></i>
					</button>
					<a class="btn-theme btn" href="javascript:sendCart()"
						style="background-color: #74D36D; border-color: rgba(255, 255, 255, 0.1); color: #fff;"><i
						class="bi bi-cart-plus"></i>&nbsp;&nbsp;장바구니</a>
				</div>
			</div>
		</div>
	</div>
</form>
</html>
