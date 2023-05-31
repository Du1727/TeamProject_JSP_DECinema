<%@page import="utils.Utils"%>
<%@page import="ticketing.SeatBean"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="ticketing.ScreeningInfoBean"%>
<%@page import="ticketing.TheaterBean"%>
<%@page import="ticketing.CityBean"%>
<%@page import="ticketing.MovieInfoBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tMgr" class="ticketing.TicketingMgr" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String id = (String) session.getAttribute("idKey");
String movieIdx = (String) session.getAttribute("movieIdx");
if(movieIdx!=null && !movieIdx.equals("null") && movieIdx.length()>0){
	MovieInfoBean bean = tMgr.getMovieInfo(Integer.parseInt(movieIdx));
	session.setAttribute("movieNm", bean.getMovieNm());
	session.setAttribute("movieDmType", bean.getMovieDmType());
	session.setAttribute("movieAgeLimit", bean.getAgeLimit());
	session.setAttribute("posterPath", bean.getPosterPath());
	session.setAttribute("movieIdx", movieIdx);
}
String movieNm = (String) session.getAttribute("movieNm");
String movieDmType = (String) session.getAttribute("movieDmType");
String movieAgeLimit = (String) session.getAttribute("movieAgeLimit");
String posterPath = (String) session.getAttribute("posterPath");
String sectionNm = (String) session.getAttribute("sectionNm");
String cityIdx = (String) session.getAttribute("cityIdx");
String cityNm = (String) session.getAttribute("cityNm");
cityNm = cityNm!=null&&!cityNm.equals("")?cityNm:"강원";
String theaterNm = (String) session.getAttribute("theaterNm");
String selectTime = (String) session.getAttribute("selectTime");
String noImg="https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg";
String ageStr = "";
if(movieAgeLimit!=null){
	if(movieAgeLimit.equals("All")){
		ageStr = "전체 관람가";
	} else if(movieAgeLimit.equals("12")){
		ageStr = "12세 이상 관람가";
	} else if(movieAgeLimit.equals("15")){
		ageStr = "15세 이상 관람가";
	} else if(movieAgeLimit.equals("18")){
		ageStr = "18세 이상 관람가";
	} else {
		ageStr = "심의 진행중";
	}
}
String printDate = (String)session.getAttribute("printDate");
String[] temp = printDate.split("[.]");
String dbTime = temp[0].trim()+"-"+temp[1].trim()+"-"+temp[2].trim()+" "+selectTime+":00";
int adult = session.getAttribute("adult")!=null?(int)session.getAttribute("adult"):0;
int teenager = session.getAttribute("teenager")!=null?(int)session.getAttribute("teenager"):0;
int children = session.getAttribute("children")!=null?(int)session.getAttribute("children"):0;
int type = session.getAttribute("type")!=null?(int)session.getAttribute("type"):-1;

Vector<SeatBean> vlist = session.getAttribute("vlist")!=null?(Vector<SeatBean>) session.getAttribute("vlist"):tMgr.getSeatInfo(Integer.parseInt(movieIdx), cityNm, sectionNm, Integer.parseInt(theaterNm), printDate, selectTime);
StringBuilder sb = new StringBuilder();
session.setAttribute("vlist", vlist);
session.setAttribute("adult", adult);
session.setAttribute("teenager", teenager);
session.setAttribute("children", children);
%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>예매 페이지</title>
<link href="style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.header {
	background: rgb(51, 51, 51);
	height: 215px;
}

.main {
	background: white;
}

.footer {
	background: darkgray;
	height: 215px;
}

.noneUnderLine {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 색상 상속 */
}
.payments {
	text-decoration: none; /* 밑줄 제거 */
	color: white; /* 색상 상속 */
}
.payments:hover{
	text-decoration: none; /* 밑줄 제거 */
	color: yellow; /* 색상 상속 */
}
.tg-0lax {
	align-content: center;
}

#rccl {
	display: flex;
	flex-direction: row;
	justify-content: flex-start; /* 왼쪽 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
}

.items {
	display: inline-table;
	white-space: nowrap;
}

.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 48
}

.hover {
	background: none;
}
.hover:hover {
	background: lightgray;
}
</style>
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript">
function SelectSeat(seatNum) {
	var cell = document.getElementById("seatNum");
	cell.value = seatNum;
	document.ticketingFrm.action = "SelectSeatProc.jsp";
	document.ticketingFrm.submit();
}
function alertCaution(idx) {
	if('<%=movieAgeLimit%>'=='18' && idx==-2){
		alert("본 영화를 관람하기 위해서는 보호자가 반드시 동반되어야 합니다. 보호자 미 동반시 입장이 제한될 수 있다는점 양해바랍니다.");
	} else if('<%=movieAgeLimit%>'=='18' && idx==-3){
		alert("본 영화를 관람하기 위해서는 보호자가 반드시 동반되어야 합니다. 보호자 미 동반시 입장이 제한될 수 있다는점 양해바랍니다.");
	} else if('<%=movieAgeLimit%>'=='15' && idx==-3){
		alert("본 영화를 관람하기 위해서는 보호자가 반드시 동반되어야 합니다. 보호자 미 동반시 입장이 제한될 수 있다는점 양해바랍니다.");
	} else if('<%=movieAgeLimit%>'=='12' && idx==-3){
		alert("본 영화를 관람하기 위해서는 보호자가 반드시 동반되어야 합니다. 보호자 미 동반시 입장이 제한될 수 있다는점 양해바랍니다.");
	}
}
function payment(){
	document.ticketingFrm.action = "payProcTicket.jsp";
	document.ticketingFrm.submit();
}
</script>
</head>
<body>
	<div class="main">
		<form id="ticketingFrm" name="ticketingFrm" method="post">
			<table class="tg" height="190" width="1600" border="0" align="center" style="background: black;">
				<tr>
					<td class="tg-0lax" rowspan="3" width=100><img
						id="printPoster"
						src="<%=posterPath!=null&&!posterPath.equals("")?posterPath:noImg%>"
						width="100%"></td>
					<td id="printMvNm" class="tg-0lax" width=300 height="75"
						style="font-size: 30; padding-left: 10; color: white;"><%=movieNm != null ? movieNm : "영화를 선택해주세요"%></td>
					<td id="printTime" class="tg-0lax" width=300 height="75"
						style="font-size: 30; color: white;">일시: <%=selectTime!=null&&!selectTime.equals("null")?printDate+" "+selectTime:"-"%></td>
					<td class="tg-0lax" rowspan="3" width=150 align="center">
						<a class="payments" href="javascript:payment()">
						<span style="font-size: 150px;" class="material-symbols-outlined">
						payments
						</span><br>결  제
						</a>
					</td>
				</tr>
				<tr>
					<td id="printMvDT" class="tg-0lax" width=300
						style="padding-left: 10; color: white; font-size: 20;"><%=movieNm!=null ? movieDmType : "영화를 선택해주세요"%></td>
					<td id="printScNm" class="tg-0lax" width=300
						style="color: white; font-size: 20;">극장: <%=sectionNm!=null&&!sectionNm.equals("null") ? sectionNm : "극장을 선택해주세요"%></td>
				</tr>
				<tr>
					<td id="printMvAg" class="tg-0lax" width=300
						style="padding-left: 10; color: white; font-size: 20;"><%=movieNm!=null ? ageStr : "영화를 선택해주세요"%></td>
					<td id="printThNm" class="tg-0lax" width=300
						style="color: white; font-size: 20;">상영관: <%=theaterNm!=null&&!theaterNm.equals("null")?theaterNm+"관":"-"%></td>
				</tr>
			</table>
			<table class="tg" align="center" width="1600" height="640" style="background: lightyellow;">
				<thead>
					<tr style="background: slategray; color: lavender;">
						<th width="20%">구분</th>
						<th width="60%">좌석선택</th>
						<th width="20%">가격</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="center">
							<div align="left" style="width: 80%; font-size: 26px;">
								<input type="radio" name="age_info" value="-1" <%if(type==-1){%>checked="checked"<%}%>>
								<span style="color: red;">성인(18세 이상)</span><br>
								<input type="radio" name="age_info" value="-2" onchange="javascript:alertCaution(-2)" <%if(type==-2){%>checked="checked"<%}%>>
								<span style="color: green;">청소년(12세~17세)</span><br>
								<input type="radio" name="age_info" value="-3" onchange="javascript:alertCaution(-3)" <%if(type==-3){%>checked="checked"<%}%>>
								<span style="color: blue;">어린이(12세 미만)</span>
							</div>
						</td>
						<td>
							<div align="center" style="margin: 2; padding: 2; overflow: auto; height: 100%;">
							<table style="border-style: solid;">
								<tr>
									<td colspan="17" align="center" style="background: white; color: black;">스크린</td>
								</tr>
								<%for(int i=0;i<vlist.size();i++){%>
								<%if(i%15==0){%>
								<tr>
								<%}%>
								<td width="20">
									<%if(vlist.get(i).getStatus()==0){%>
									<a href="javascript:SelectSeat('<%=i%>')" class="noneUnderLine">
									<span class="material-symbols-outlined">chair</span>
									</a>
									<%}else if(vlist.get(i).getStatus()==-1){sb.append(Utils.parseSeatPosition(i).trim()+"/");%>
									<a href="javascript:SelectSeat('<%=i%>')" class="noneUnderLine">
									<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1; color: red;">chair</span>
									</a>
									<%}else if(vlist.get(i).getStatus()==-2){sb.append(Utils.parseSeatPosition(i).trim()+"/");%>
									<a href="javascript:SelectSeat('<%=i%>')" class="noneUnderLine">
									<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1; color: green;">chair</span>
									</a>
									<%}else if(vlist.get(i).getStatus()==-3){sb.append(Utils.parseSeatPosition(i).trim()+"/");%>
									<a href="javascript:SelectSeat('<%=i%>')" class="noneUnderLine">
									<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1; color: blue;">chair</span>
									</a>
									<%}else{%>
									<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">chair</span>
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
							<input type="hidden" id="seatNum" name="seatNum" value="-1">
							<input type="hidden" id="type" name="type" value="-1">
						</div>
						</td>
						<td style="font-size: 30px; font-style: oblique;">
						성인 : <%=adult%>명(14,000원)<br>
						청소년 : <%=teenager%>명(10,000원)<br>
						어린이 : <%=children%>명(7,000원)<br>
						총 원 : <%=adult+teenager+children%>명<br>
						결제 금액 : <%=Utils.toWon(adult*14000+teenager*10000+children*7000)%>원
						<input type="hidden" name="totalPrice" value="<%=adult*14000+teenager*10000+children*7000%>">
						<input type="hidden" name="cityAddress" value="<%=cityNm%>">
						<input type="hidden" name="sectionName" value="<%=sectionNm%>">
						<input type="hidden" name="theaterNum" value="<%=theaterNm%>">
						<input type="hidden" name="screenTime" value="<%=dbTime%>">
						<input type="hidden" name="reservedSeats" value="<%=sb.toString()%>">						
						<input type="hidden" name="peopleInfo" value="<%=adult+"/"+teenager+"/"+children%>">						
						<input type="hidden" name="id" value="<%=id%>">						
						<input type="hidden" name="movieNm" value="<%=movieNm%>">						
						<input type="hidden" name="movieIdx" value="<%=movieIdx%>">						
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>