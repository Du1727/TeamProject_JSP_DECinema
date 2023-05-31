<%@page import="ticketing.SeatBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tMgr" class="ticketing.TicketingMgr"/>
<%
String movieIdx = (String) session.getAttribute("movieIdx");
String cityNm = (String) session.getAttribute("cityNm");
String sectionNm = (String) session.getAttribute("sectionNm");
String theaterNm = (String) session.getAttribute("theaterNm");
String selectTime = (String) session.getAttribute("selectTime");
String printDate = (String)session.getAttribute("printDate");
String changeTime = (String) session.getAttribute("changeTime");
Vector<SeatBean> vlist = new Vector<>();
if("Yes".equals(changeTime)){
	vlist = tMgr.getSeatInfo(Integer.parseInt(movieIdx), cityNm, sectionNm, Integer.parseInt(theaterNm), printDate, selectTime);
}
%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style>
.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48
}
</style>
</head>
<body marginheight="2">
	<div align="center" style="margin: 0px;">
	<%if(vlist.size()>0){%>
		<table style="border-style: solid; margin: 0px;">
			<tr>
				<td colspan="17" align="center" style="background: white; color: black;">스크린</td>
			</tr>
			<%for(int i=0;i<vlist.size();i++){%>
			<%if(i%15==0){%>
			<tr>
			<%}%>
			<td width="20">
				<%if(vlist.get(i).getStatus()==0){%>
				<span class="material-symbols-outlined" style="font-size: 22;">chair</span>
				<%}else{%>
				<span class="material-symbols-outlined" style="font-size: 22; font-variation-settings: 'FILL' 1">chair</span>
				<%}%>
			</td>
				<%if(i%15==4||i%15==9){%>
				<td width="20"></td>
				<%}%>
			<%if(i%15==14){%>
			</tr>
			<%}%>
			<%}%>
		</table>
		<%}else{%>
		<table height="100%" align="center">
			<tr>
				<td>
					<div align="center" style="vertical-align: middle;">
						<i class="bi bi-film" style="font-size: 30;"></i>
						<br>조회 가능한 상영관이 없습니다.<br>조건을 변경해주세요.
					</div>
				</td>
			</tr>
		</table>
		<%}%>
	</div>
</body>