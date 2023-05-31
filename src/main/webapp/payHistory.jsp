<%@ page contentType="text/html; charset=UTF-8"%>
<%
String id = (String)session.getAttribute("idKey");
if(id==null) {
	response.sendRedirect("login.jsp");
}
String sortType = session.getAttribute("sortType") != null ? (String) session.getAttribute("sortType") : "0";
%>
<head>
<script type="text/javascript">
	function Select() {
		var idx = document.getElementById("select").selectedIndex;
		document.getElementById("hidden").value = idx;
		document.payHistoryFrm.action = "payHistory/payHistoryProc.jsp";
		document.payHistoryFrm.submit();
	}
</script>
<%@include file="navbar-white.jsp"%>
</head>
<body>
	<form id="payHistoryFrm" name="payHistoryFrm" method="post">
		<div align="center"
			style="width: 100%; padding-top: 20px; margin-bottom: 0px;">
			<div class="container" style="width: 73%;display: flex;justify-content: space-between;">
				<span style="font-size: 30px; font-weight: bold;"><%=id%>님의
					결제내역</span> <span style="vertical-align: bottom;"> <select
					id="select" onchange="javascript:Select()">
						<option <%if(sortType.equals("0")){%>selected="selected"<%}%>>일반상품 결제 내역</option>
						<option <%if(sortType.equals("1")){%>selected="selected"<%}%>>영화예매 결제 내역</option>
				</select> <input type="hidden" id="hidden" name="sortType" value="<%=sortType%>">
				</span>
			</div>
			<hr style="margin-top: 10px; margin-bottom: 10px;">
			<%
			if (sortType.equals("0")) {
			%>
			<iframe width="75%" height="50%"
				src="./payHistory/ProductPayHistory.jsp"></iframe>
			<%
			} else {
			%>
			<iframe width="75%" height="50%"
				src="./payHistory/TicketingPayHistory.jsp"></iframe>
			<%
			}
			%>
		</div>
	</form>
    <%@include file = "footer.jsp" %>
</body>