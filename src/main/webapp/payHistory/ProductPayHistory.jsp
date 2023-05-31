<%@page import="payHistory.payHistoryBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pMgr" class="payHistory.PayHistoryMgr" />
<%

Vector<payHistoryBean> vlist = pMgr.getPayHistoryList((String)session.getAttribute("idKey"));
String noImg = "https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg";
%>
<head>
<style>
body {
  color: #666;
  font: 14px/24px "Open Sans", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", Sans-Serif;
}
table {
  border-collapse: separate;
  border-spacing: 0;
  width: 100%;
}
th,
td {
  padding: 6px 15px;
}
th {
  background: #42444e;
  color: #fff;
  text-align: left;
}
tr:first-child th:first-child {
  border-top-left-radius: 6px;
}
tr:first-child th:last-child {
  border-top-right-radius: 6px;
}
td {
  border-right: 1px solid #c6c9cc;
  border-bottom: 1px solid #c6c9cc;
}
td:first-child {
  border-left: 1px solid #c6c9cc;
}
tr:nth-child(even) td {
  background: #eaeaed;
}
tr:last-child td:first-child {
  border-bottom-left-radius: 6px;
}
tr:last-child td:last-child {
  border-bottom-right-radius: 6px;
}
</style>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th width="10%">상품 이미지</th>
				<th>상품명</th>
				<th>단품가격</th>
				<th>결제수량</th>
				<th>결제금액</th>
				<th>결제일</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (int i = 0; i < vlist.size(); i++) {
				payHistoryBean bean = vlist.get(i);
			%>
			<tr>
				<td><img width="120px"
					src=<%=bean.getStorebean().getImage() != null ? "../assets/img/store/"+bean.getStorebean().getImage() : noImg%>></td>
				<td><%=bean.getStorebean().getName()%></td>
				<td><%=bean.getStorebean().getPrice()%></td>
				<td><%=bean.getSalebean().getQuantity()%></td>
				<td><%=bean.getSalebean().getPrice()%></td>
				<td><%=bean.getSalebean().getPaydt()%></td>
			</tr>
			<%
			}
			%>

		</tbody>
	</table>
</body>
