<%@page import="payHistory.TicketHistoryBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pMgr" class="payHistory.PayHistoryMgr" />
<%
Vector<TicketHistoryBean> vlist = pMgr.getTicketHistoryList((String)session.getAttribute("idKey"));
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
				<th width="10%">포스터</th>
				<th>영화제목</th>
				<th>지역</th>
				<th width="6%">지점</th>
				<th width="6%">상영관</th>
				<th>상영일시</th>
				<th>예매좌석</th>
				<th width="10%">인원정보</th>
				<th width="10%">결제금액</th>
				<th>결제 일</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (int i = 0; i < vlist.size(); i++) {
				TicketHistoryBean bean = vlist.get(i);
			%>
			<tr>
				<td><img width="100px"
					src=<%=bean.getmBean().getPosterPath() != null ? bean.getmBean().getPosterPath() : noImg%>></td>
				<td><%=bean.getmBean().getMovieNm()%></td>
				<td><%=bean.getsBean().getCityAddress()%></td>
				<td><%=bean.getsBean().getSectionName()%></td>
				<td><%=bean.getsBean().getTheaterNum()%></td>
				<td><%=bean.getsBean().getScreenTime()%></td>
				<td>
				|
				<%for(int j=0;j<bean.getsBean().getReservedSeatsPosition().size();j++){%>
				<%=bean.getsBean().getReservedSeatsPosition().get(j)+"|"%>
				<%}%>
				</td>
				<td>
				<%String[] str = bean.getPeopleInfo().split("/");%>
				성인 : <%=str[0]%><br>
				청소년 : <%=str[1]%><br>
				어린이 : <%=str[2]%>
				</td>
				<td><%=bean.getPrice()%></td>
				<td><%=bean.getPayDt()%></td>
			</tr>
			<%
			}
			%>

		</tbody>
	</table>
</body>
