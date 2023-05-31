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
<jsp:useBean id="tMgr" class="ticketing.TicketingMgr"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String id = (String) session.getAttribute("idKey");
String movieIdx = (String) session.getAttribute("movieIdx");
System.out.println("movieIdx: "+movieIdx);	
if(movieIdx!=null && !movieIdx.equals("null") && movieIdx.length()>0){
	MovieInfoBean bean = tMgr.getMovieInfo(Integer.parseInt(movieIdx));
	session.setAttribute("movieNm", bean.getMovieNm());
	session.setAttribute("movieDmType", bean.getMovieDmType());
	session.setAttribute("movieAgeLimit", bean.getAgeLimit());
	session.setAttribute("posterPath", bean.getPosterPath());
	System.out.println(bean.getAgeLimit());
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
String tableNm = (String) session.getAttribute("tableNm");
int filterTheaterNum = session.getAttribute("filterTheaterNum")!=null?(int) session.getAttribute("filterTheaterNum"):0;
HashMap<Integer, Vector<SeatBean>> filterSeat = session.getAttribute("filterSeat")!=null?(HashMap<Integer, Vector<SeatBean>>) session.getAttribute("filterSeat"):null;
String movieSort = (String) session.getAttribute("movieSort");
if(!"최신순".equals(movieSort)&&!"평점순".equals(movieSort)){
	movieSort = "최신순";
}
Vector<MovieInfoBean> movieList = tMgr.getMovieList(movieSort);
Vector<CityBean> cityList = tMgr.getCityList();
Vector<String> theaterList = tMgr.getTheaterNmList(cityNm);
Vector<TheaterBean> screenList = tMgr.getTheaterList(cityNm, sectionNm);
String noImg="https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg";
String ageAll="https://i.namu.wiki/i/u4nooZ0Bgr6_Eal2iwhYXL6Y8XJ8fXhTPqx9GxPlOnxgASAjAkIL7CWiXK2reCgdmFX_c7d5uyssgK4KwVxCZzT1LgBPGi8fqAjO-8Axotwy-nJYAUV-ygSRXZNeqAblg8MyFd7N7IunUoKt4dMJgQ.svg";
String age12="https://i.namu.wiki/i/oyXxp9336DTf9MsQ63DZWNwvKp9tGsAEhuQwMjssVNPPf6uDVctcEty4kN5GJZVP72xmIm_cYVMOaSUcnbf68lrIgnwZuEYAhcxujceK7MUQkyC_GfE86zMpnDgUJ4tIGsbM56T97XGT2WA81xABgQ.svg";
String age15="https://i.namu.wiki/i/UX5J2fdD2m28KL7UIdMiSSDsBeBVhYQGPRe6rI4mebQEfPtGAVI3W7m3GjfgXlNftSOaoIZt4iEq3uBRQ2HzJ6-2_U0pLOb3OvR-LDPjV39AxbQ07-tYxT61bY3cCvo0gCo2I_P-VQw6tSomwzrhxw.svg";
String age18="https://i.namu.wiki/i/TDV9H0JckYLmkew97duuAqwjm_Dt7jktgVbLpi-UXUk2Jidy3xTU1wWtmLTj6JLSrQzDB4W4mlzkz-Mzr0E4w_cl--WBewVPvvQ6PLkBGdHgn0r3fDoNDEcglpwWI_LIK6sjW6JLluwvAtUvsDohrw.svg";
String ageIcon = "";
String ageStr = "";
if(movieAgeLimit!=null){
	if(movieAgeLimit.equals("All")){
		ageIcon = ageAll;
		ageStr = "전체 관람가";
	} else if(movieAgeLimit.equals("12")){
		ageIcon = age12;
		ageStr = "12세 이상 관람가";
	} else if(movieAgeLimit.equals("15")){
		ageIcon = age15;
		ageStr = "15세 이상 관람가";
	} else if(movieAgeLimit.equals("18")){
		ageIcon = age18;
		ageStr = "18세 이상 관람가";
	} else {
		ageIcon = noImg;
		ageStr = "심의 진행중";
	}
}
int datePage = (String)session.getAttribute("datePage")!=null?Integer.parseInt((String)session.getAttribute("datePage")):1;
int dateIdx = (String)session.getAttribute("dateIdx")!=null?Integer.parseInt((String)session.getAttribute("dateIdx")):0;
String printDate = (String)session.getAttribute("printDate");
TreeMap<Integer, Vector<ScreeningInfoBean>> scrnListMap = new TreeMap<Integer, Vector<ScreeningInfoBean>>();
if(movieNm!=null && sectionNm!=null && movieNm.length()>0 && !sectionNm.equals("null") && filterSeat!=null){
	HashMap<Integer, String> seatMap = new HashMap<>();
	for(int key:filterSeat.keySet()){
		Vector<SeatBean> vTemp = filterSeat.get(key);
		for(int i=0;i<vTemp.size();i++){
			if(vTemp.get(i).getStatus()!=0){
				seatMap.put(key, seatMap.get(key)==null?Utils.parseSeatPosition(i)+"/":seatMap.get(key)+Utils.parseSeatPosition(i)+"/");
			}
		}
	}
	scrnListMap = new TreeMap<Integer, Vector<ScreeningInfoBean>>(tMgr.getScrnList(cityNm, sectionNm, printDate, Integer.parseInt(movieIdx), seatMap));
}
int selectedMovieIdx = -1;
%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
/*------------------------------------------------------*/
/*----------------------PRELOADER----------------------------*/


.preload
{
    position: fixed;
    z-index: 2000;
    top: 0;
    left: 0;

    width: 100%;
    height: 100%;

    background: #1a1a1a;
}
.load-align
{
    position: absolute;
    top: 50%;
    left: 50%;

    overflow: hidden;

    width: 60px;
    height: 60px;
    margin-top: -30px;
    margin-left: -30px;
}
.film
{
    position: absolute;
    top: 0;

    width: 60px;
    height: 60px;

    border-top: 10px solid #fff;
    border-right: 2px solid #fff;
    border-bottom: 10px solid #fff;
    border-left: 2px solid #fff;
}
.load-align .film:first-child
{
    left: 0;
}
.load-align .film:last-child
{
    left: -100%;
}
.film span:nth-child(1)
{
    position: absolute;
    top: -8px;
    left: 10px;

    width: 6px;
    height: 6px;

    background: #1a1a1a;
}
.film span:nth-child(1):before
{
    position: absolute;
    top: 0;
    left: -10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(1):after
{
    position: absolute;
    top: 0;
    left: 10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(2)
{
    position: absolute;
    top: -8px;
    left: 40px;

    width: 6px;
    height: 6px;

    background: #1a1a1a;
}
.film span:nth-child(2):before
{
    position: absolute;
    top: 0;
    left: -10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(2):after
{
    position: absolute;
    top: 0;
    left: 10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(3)
{
    position: absolute;
    bottom: -8px;
    left: 10px;

    width: 6px;
    height: 6px;

    background: #1a1a1a;
}
.film span:nth-child(3):before
{
    position: absolute;
    bottom: 0;
    left: -10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(3):after
{
    position: absolute;
    bottom: 0;
    left: 10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(4)
{
    position: absolute;
    bottom: -8px;
    left: 40px;

    width: 6px;
    height: 6px;

    background: #1a1a1a;
}
.film span:nth-child(4):before
{
    position: absolute;
    top: 0;
    left: -10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
.film span:nth-child(4):after
{
    position: absolute;
    top: 0;
    left: 10px;

    width: 6px;
    height: 6px;

    content: '';

    background: #1a1a1a;
}
@keyframes move
{
    50%
    {
        left: 50%;
    }100%
    {
        left: 100%;
    }
}
@-webkit-keyframes move
{
    50%
    {
        left: 50%;
    }100%
    {
        left: 100%;
    }
}
@-moz-keyframes move
{
    50%
    {
        left: 50%;
    }100%
    {
        left: 100%;
    }
}
@keyframes move2
{
    50%
    {
        left: -50%;
    }100%
    {
        left: 0;
    }
}
@-webkit-keyframes move2
{
    50%
    {
        left: -50%;
    }100%
    {
        left: 0;
    }
}
@-moz-keyframes move2
{
    50%
    {
        left: -50%;
    }100%
    {
        left: 0;
    }
}
.film:first-child
{
    -webkit-animation: move 1s infinite .1s;
       -moz-animation: move 1s infinite .1s;
        -ms-animation: move 1s infinite .1s;
            animation: move 1s infinite .1s;
    animation-timing-function: linear;
}
.film:last-child
{
    -webkit-animation: move2 1s infinite .1s;
       -moz-animation: move2 1s infinite .1s;
        -ms-animation: move2 1s infinite .1s;
            animation: move2 1s infinite .1s;
    animation-timing-function: linear;
}
/*----------------------PRELOADER----------------------------*/

.body {
	font-family: 배달의민족 도현;
}

.header {
	background: rgb(51, 51, 51);
	height: 215px;
	font-family: 배달의민족 도현;
}

.main {
	background: white;
	font-family: 배달의민족 도현;
}

.noneUnderLine {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 색상 상속 */
}

.tg-0lax {
	align-content: center;
	font-family: 배달의민족 도현;
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


.payments {
	text-decoration: none; /* 밑줄 제거 */
	color: white; /* 색상 상속 */
}
.payments:hover{
	text-decoration: none; /* 밑줄 제거 */
	color: yellow; /* 색상 상속 */
}
</style>
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript">
function loaded() {
	var loader = document.getElementById("loader");
	var container = document.getElementById("main");
	loader.style.display = 'none';
	container.style.display = 'block';
}
document.addEventListener("DOMContentLoaded", loaded);
function SelectCity() {
	var cityIdx = document.getElementById("selectedCity").selectedIndex;
	document.getElementById("cityIdx").value = cityIdx;
	var cityNm = document.getElementById("selectedCity").options[cityIdx].value;
	document.getElementById("cityNm").value = cityNm;
	var cell1 = document.getElementById("sendTheater");
	cell1.value = "null";
	var cell2 = document.getElementById("sendTime");
	cell2.value = "null";
	var table = document.getElementById("sendTable");
	table.value = "null";
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function SelectMovieSort() {
	var idx = document.getElementById("selectMovieSort").selectedIndex;
	var sort = document.getElementById("selectMovieSort").options[idx].value;
	document.getElementById("movieSort").value = sort;
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function selectMovie(movieIdx) {
	var cell = document.getElementById("sendMvIdx");
	cell.value = movieIdx;
	var cell1 = document.getElementById("sendTheater");
	cell1.value = "null";
	var cell2 = document.getElementById("sendTime");
	cell2.value = "null";
	var table = document.getElementById("sendTable");
	table.value = "null";
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function selectSection(sectionName) {
	var cell = document.getElementById("sendScNm");
	cell.value = sectionName;
	var cell1 = document.getElementById("sendTheater");
	cell1.value = "null";
	var cell2 = document.getElementById("sendTime");
	cell2.value = "null";
	var table = document.getElementById("sendTable");
	table.value = "null";
	document.getElementById("filterTheaterNum").value = 1;
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function selectTime(i, j, sTime) {
	var cell1 = document.getElementById("sendTheater");
	cell1.value = (parseInt(i));
	var cell2 = document.getElementById("sendTime");
	cell2.value = sTime;
	var table = document.getElementById("sendTable");
	table.value = i+j+"table";
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function selectDate(dateIdx) {
	var cell = document.getElementById("dateIdx");
	cell.value = dateIdx;
	var today = new Date();
	var targetDay = new Date(today.setDate(today.getDate() + dateIdx));
	document.getElementById("printDate").value = targetDay
			.toLocaleDateString("kr", {
				year : "numeric",
				month : "numeric",
				day : "numeric",
				weekday : "short"
			});
	var cell1 = document.getElementById("sendTheater");
	cell1.value = "null";
	var cell2 = document.getElementById("sendTime");
	cell2.value = "null";
	var table = document.getElementById("sendTable");
	table.value = "null";
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function changeDatePage(datePage) {
	var cell = document.getElementById("datePage");
	cell.value = datePage;
	if(datePage==2){
		selectDate(5);
	} else {
		selectDate(0);
	}
}
function SelectFilterTheaterNum() {
	var idx = document.getElementById("selectedFilterTheater").selectedIndex;
	var theaterNum = document.getElementById("selectedFilterTheater").options[idx].value;
	document.getElementById("filterTheaterNum").value = theaterNum;
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function SelectFilterSeat(seatNum) {
	var cell = document.getElementById("seatNum");
	cell.value = seatNum;
	var cell1 = document.getElementById("sendTheater");
	cell1.value = "null";
	var cell2 = document.getElementById("sendTime");
	cell2.value = "null";
	var table = document.getElementById("sendTable");
	table.value = "null";
	document.ticketingFrm.action = "TicketingProc.jsp";
	document.ticketingFrm.submit();
}
function submitToSelectSeat() {
	document.ticketingFrm.action = "SelectSeatSection.jsp";
	document.ticketingFrm.submit();
}
</script>
</head>
<body>
	<div class="preload" id="loader">
		<div class="load-align">
			<div class="film">
				<span></span><span></span><span></span><span></span>
			</div>
			<div class="film">
				<span></span><span></span><span></span><span></span>
			</div>
		</div>
	</div>
	<div id="main">
		<form id="ticketingFrm" name="ticketingFrm" method="post">
			<table class="tg" height="190" width="1600" border="0" align="center"
				style="background: black;">
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
						<a class="payments" href="javascript:submitToSelectSeat()">
						<span style="font-size: 150px;" class="material-symbols-outlined">
						arrow_forward_ios
						</span><br>다  음
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
			<table class="tg2" align="center" border="1" width="1600"
				height="640" style="background: lightyellow;">
				<thead>
					<tr style="background: slategray; color: lavender;">
						<th class="tg-0lax" width=20%>영화</th>
						<th class="tg-0lax" width=30%>좌석필터</th>
						<th class="tg-0lax" width=30%>좌석현황</th>
						<th class="tg-0lax" width=20%>상영일시</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="tg-0lax" height="10%" align="center">
							<!-- 영화정렬선택 --> <select id="selectMovieSort" style="width: 30%;" onchange="javascript:SelectMovieSort()">
								<option <%if(movieSort.equals("최신순")){%>selected="selected"<%}%>>최신순</option>
								<option <%if(movieSort.equals("평점순")){%>selected="selected"<%}%>>평점순</option>
						</select>
						<input type="hidden" id="movieSort" name="movieSort" value="<%=movieSort%>">
						</td>
						<td class="tg-0lax" align="center">
							<!-- 좌석필터상영관선택 --> <select id="selectedFilterTheater"
							style="width: 20%;"
							onchange="javascript:SelectFilterTheaterNum()">
								<%
								if(screenList.size()>0){
									for (int i=0;i<screenList.size();i++) {
										TheaterBean bean = screenList.get(i);
								%>
								<option value="<%=bean.getNum()%>"
									<%if(filterTheaterNum!=0&&filterTheaterNum==bean.getNum()){%>
									selected <%}%>><%=bean.getNum()%>관
								</option>
								<%
									}
								}
								%>
						</select> <input type="hidden" id="filterTheaterNum"
							name="filterTheaterNum" value="<%=filterTheaterNum%>">
						</td>
						<td class="tg-0lax" align="center"
							style="font-size: 18px; font-style: oblique;"><%=theaterNm!=null&&!theaterNm.equals("null")?"선택된 상영관 : "+theaterNm+"관":"-"%></td>
						<td class="tg-0lax">
							<!-- 날짜 선택 -->
							<table id="DateTable" width="100%">
								<tr>
									<td colspan="7"><div id="DateMonth" align="center">Month</div></td>
								</tr>
								<tr align="center">
									<td><input type="button" <%if(datePage==1){%>
										disabled="disabled" <%}%> onclick="changeDatePage('<%=1%>')"
										value="<"></td>
									<%for(int i=(datePage-1)*5;i<(datePage-1)*5+5;i++){%>
									<td>
										<div>
											<input type="button" id="DateTd<%=i%>" class="hover"
												onclick="javascript:selectDate(<%=i%>)"
												style="border: none; width: 40; <%if(dateIdx==i){%>background: black; color: white;<%}%>">
										</div>
										<div id="WkdTd<%=i%>"></div>
									</td>
									<%}%>
									<td><input type="button" <%if(datePage==2){%>
										disabled="disabled" <%}%> onclick="changeDatePage('<%=2%>')"
										value=">"><input type="hidden" id="dateIdx"
										name="dateIdx" value="<%=dateIdx%>"><input
										type="hidden" id="datePage" name="datePage"
										value="<%=datePage%>"><input type="hidden"
										id="printDate" name="printDate" value="<%=printDate%>"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="tg-0lax" rowspan="2" height="40%">
							<!-- 영화목록 -->
							<div id="movieScroll" style="height: 100%; width: 100%; overflow: auto;">
								<%
									for (int i = 0; i < movieList.size(); i++) { String icon="";
									String age=movieList.get(i).getAgeLimit();
									if(age.equals("All")){icon=ageAll;}
									else if(age.equals("12")) {icon=age12;}
									else if(age.equals("15")) {icon=age15;}
									else if(age.equals("18")) {icon=age18;}
									else {icon=noImg;}
									%>
								<table width=100%>
									<tr>
										<td class="rccl"
											<%if(movieList.get(i).getMovieNm().equals(movieNm)){selectedMovieIdx=i;%>
											style="background: lightgray;" <%}%>><a
											href="javascript:selectMovie('<%=movieList.get(i).getIdx()%>')"
											class="noneUnderLine"> <img width="22" src="<%=icon%>">
												<%=movieList.get(i).getMovieNm()%>
										</a></td>
									</tr>
								</table>
								<p></p>
								<%
									}
									%>
								<input type="hidden" id="sendMvIdx" name="movieIdx"
									value="<%=movieIdx%>">
							</div>
						</td>
						<td class="tg-0lax" rowspan="5" height="80%">
							<!-- 좌석필터배치도 -->
							<div align="center"
								style="margin: 2; padding: 2; overflow: auto; height: 100%;">
								<%if(screenList.size()>0 && filterSeat!=null && filterSeat.get(filterTheaterNum)!=null){
								int totalSeat = 0;
								for(int i=0;i<screenList.size();i++){
									if(screenList.get(i).getNum()==filterTheaterNum){
										totalSeat = screenList.get(i).getSeat();
										break;
									}
								}
							%>
								<table style="border-style: solid;">
									<tr>
										<td colspan="17" align="center"
											style="background: white; color: black;">스크린</td>
									</tr>
									<%for(int i=0;i<totalSeat;i++){%>
									<%if(i%15==0){%>
									<tr>
										<%}%>
										<td width="20">
											<%if(filterSeat.get(filterTheaterNum).get(i).getStatus()==0){%>
											<a href="javascript:SelectFilterSeat('<%=i%>')"
											class="noneUnderLine"> <span
												class="material-symbols-outlined">chair</span>
										</a> <%}else{%> <a href="javascript:SelectFilterSeat('<%=i%>')"
											class="noneUnderLine"> <span
												class="material-symbols-outlined"
												style="font-variation-settings: 'FILL' 1">chair</span>
										</a> <%}%>
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
												<i class="bi bi-film" style="font-size: 30;"></i> <br>조회
												가능한 상영관이 없습니다.<br>조건을 변경해주세요.
											</div>
										</td>
									</tr>
								</table>
								<%}%>
								<input type="hidden" id="seatNum" name="seatNum" value="-1">
							</div>
						</td>
						<td class="tg-0lax" rowspan="5">
							<!-- 좌석현황배치도 --> <iframe id="seatIframe" width="100%"
								height="100%" style="margin: 0px;"
								src="TicketingSeat.jsp"></iframe>
						</td>
						<td id="minimovieNm" class="rccl" height="10%" align="center">
							<!-- 상영영화제목표시 --> <%if(movieNm!=null){%> <img id="testId"
							name="TestName" width=22 src="<%=ageIcon%>"> <%}%> <%=movieNm != null ? movieNm : "영화를 선택해주세요"%></td>
					</tr>
					<tr>
						<td class="tg-0lax" rowspan="4">
							<!-- 상영관목록 -->
							<div style="height: 100%; width: 100%; overflow: auto;">
								<%
								if(scrnListMap.size()>0){
								for (int i : scrnListMap.keySet() ) {
									Vector<ScreeningInfoBean> vlist = scrnListMap.get(i);
								%>
								<p style="font-size: 22px">
									2D |
									<%=i%>관
								</p>
								<%
								for (int j = 0; j < vlist.size(); j++) {
									ScreeningInfoBean bean = vlist.get(j);
									String splitSpace[] = bean.getScreenTime().split(" ");
									String splitColon[] = splitSpace[1].split(":");
									String timeText = splitColon[0]+":"+splitColon[1];
								%>
								<table class="items" border="1" width="70"
									onclick="selectTime('<%=i%>','<%=j%>','<%=timeText%>')">
									<tr>
										<td align="center"
											style="background: <%if((""+i+j+"table").equals(tableNm)){%>lightgray<%}else{%>white<%}%>;">
											<div style="font-size: 10px;"><%=i%>관
											</div>
											<div id="<%=j%>" style="font: bold; font-size: 20px"><%=timeText%></div>
											<div style="font-size: 12px"><%=bean.getReservedSeat()%>/<%=bean.getTotalSeat()%></div>
										</td>
									</tr>
								</table>
								<%
										}
								%>
								<hr>
								<%
									}
								} else {
								%>
								<table height="100%" align="center">
									<tr>
										<td>
											<div align="center" style="vertical-align: middle;">
												<i class="bi bi-film" style="font-size: 30;"></i> <br>조회
												가능한 상영시간이 없습니다.<br>조건을 변경해주세요.
											</div>
										</td>
									</tr>
									<tr height="50%">
										<td></td>
									</tr>
								</table>
								<%}%>
								<input type="hidden" id="sendTheater" name="theaterNm"
									value="<%=theaterNm%>"> <input type="hidden"
									id="sendTime" name="selectTime" value="<%=selectTime%>">
								<input type="hidden" id="sendTable" name="tableNm"
									value="<%=tableNm%>">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tg-0lax" align="center" height="12"
							style="background: slategray; color: lavender;">극장</td>
					</tr>
					<tr>
						<td class="tg-0lax" align="center">
							<!-- 도시선택 --> <select id="selectedCity" style="width: 50%;"
							onchange="javascript:SelectCity()">
								<%
								for (int i = 0; i < cityList.size(); i++) {
								%>
								<option value="<%=cityList.get(i).getAddress()%>"
									<%if(cityIdx!=null&&cityIdx.equals(Integer.toString(i))){%>
									selected <%}%>><%=cityList.get(i).getAddress()%></option>
								<%
								}
								%>
						</select> <input type="hidden" id="cityIdx" name="cityIdx"
							value="<%=cityIdx%>"> <input type="hidden" id="cityNm"
							name="cityNm" value="<%=cityNm%>">
						</td>
					</tr>
					<tr>
						<td class="tg-0lax" height="40%">
							<!-- 지점목록 -->
							<div style="height: 100%; width: 100%; overflow: auto;">
								<table id="regionTable" width=100%>
									<%
									for (int i = 0; i < theaterList.size(); i++) {
									%>
									<tr align="center" style="font-size: 20px;">
										<td <%if(theaterList.get(i).equals(sectionNm)){%>
											style="background: lightgray;" <%}%>><a
											href="javascript:selectSection('<%=theaterList.get(i)%>')"
											class="noneUnderLine"><%=theaterList.get(i)%></a></td>
									</tr>
									<%
									}
									%>
								</table>
								<input type="hidden" id="sendScNm" name="sectionNm"
									value="<%=sectionNm%>">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<script>
	var scrollableDiv = document.getElementById("movieScroll");
	scrollableDiv.scrollTop = <%=selectedMovieIdx*42.15%>;
	for(var i=<%=(datePage-1)*5%>;i<<%=(datePage-1)*5+5%>; i++) {
			var now = new Date();
			var targetDay = new Date(now.setDate(now.getDate() + i));
			var day = targetDay.toLocaleDateString("en-us", {
				day : "numeric"
			});
			var weekday = targetDay.toLocaleDateString("kr", {
				weekday : "short"
			});
			document.getElementById("DateTd" + i).value = day;
			document.getElementById("WkdTd" + i).innerHTML = weekday;
			if (weekday == "토") {
				document.getElementById("WkdTd" + i).style.color = "blue";
				if(i!=<%=dateIdx%>){
					document.getElementById("DateTd" + i).style.color = "blue";
				}
			} else if (weekday == "일") {
				document.getElementById("WkdTd" + i).style.color = "red";
				if(i!=<%=dateIdx%>){
					document.getElementById("DateTd" + i).style.color = "red";
				}
			}
		}
		var now = new Date();
		var targetDay = new Date(now.setDate(now.getDate() + <%=dateIdx%>));
		document.getElementById("DateMonth").innerHTML = targetDay
				.toLocaleDateString("kr", {
					month : "numeric"
				});
		if("<%=printDate%>" == "null") {
			selectDate(0);
		}
	</script>
</body>