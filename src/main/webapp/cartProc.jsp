<%@page import="member.MemberBean"%>
<%@page import="java.time.LocalDate"%>
<%@page import="sale.saleBean"%>
<%@page import="store.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class="store.cartMgr" />
<jsp:useBean id="sMgr" class="sale.saleMgr" />
<jsp:useBean id="mmgr" class="member.MemberMgr" />

<%
	System.out.println("cartProc으로 넘어왔다.");

	String id = (String) session.getAttribute("idKey");
	
	if (id == null) {
		response.sendRedirect("login.jsp");
		return; // 이후에 코드를 무력화
	}
	
	String destination = "";
	LocalDate date = LocalDate.now();
	
	int last_payPrice;
			
	
	
	// insert, update, delete
	String flag = request.getParameter("flag");
	
	if (flag.equals("delete")) {	
		int cartNo = Integer.parseInt((String)request.getParameter("cartNo"));
		cMgr.deleteCart(cartNo);
		destination = "cart.jsp";
		
	} else if (flag.equals("buy")) {	
		last_payPrice = UtilMgr.parseInt(request, "last_payPrice");
		
		MemberBean mbean = mmgr.getMember(id);
		
	    session.setAttribute("name", mbean.getName());
	    session.setAttribute("email", mbean.getMail());
	    session.setAttribute("phone", mbean.getPhone());
	    session.setAttribute("totalPrice", last_payPrice);
		
	    session.setAttribute("idKey", id);
		
		destination = "payProc.jsp";
		
	} else if (flag.equals("complete")) {
		System.out.println("cartProc > complete 로 들어옴");
		saleBean bean = new saleBean();
		bean.setId(id);
		bean.setProductNo(UtilMgr.parseInt(request, "productNo"));
		bean.setType(0);
		bean.setPrice(UtilMgr.parseInt(request, "productPrice"));
		bean.setQuantity(UtilMgr.parseInt(request, "productQuantity"));
		bean.setPaystate(0);//결제 안된상태 = 0, 결제된 상태 = 1
		
		//결제 완료시 cart proc으로 귀환해서 sale 테이블에 결제정보 추가
		sMgr.addSale(bean);
	}
%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<!-- <script src="../assets/js/color-modes.js"></script> -->

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">

<script>

	location.href ="<%=destination%>";
	
</script>

</head>

<body>

</body>