<%@page import="ticketing.ScreeningInfoBean"%>
<%@page import="board.BoardBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tMgr" class="ticketing.TicketingMgr"/>
<%
String id = null;
int movieIdx = 0;
String movieNm = null;
String cityAddress = null;
String sectionName = null;
int theaterNum = 0;
String screenTime = null;
String reservedSeats = null;
String peopleInfo = null;
int totalPrice = 0;
try {
	id = request.getParameter("id");
	movieIdx = Integer.parseInt(request.getParameter("movieIdx"));
	movieNm = request.getParameter("movieNm");
	cityAddress = request.getParameter("cityAddress");
	sectionName = request.getParameter("sectionName");
	theaterNum = Integer.parseInt(request.getParameter("theaterNum"));
	screenTime = request.getParameter("screenTime");
	reservedSeats = request.getParameter("reservedSeats");
	peopleInfo = request.getParameter("peopleInfo");
	totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	ScreeningInfoBean sBean = new ScreeningInfoBean();
	sBean.setMovieIdx(movieIdx);
	sBean.setCityAddress(cityAddress);
	sBean.setSectionName(sectionName);
	sBean.setTheaterNum(theaterNum);
	sBean.setScreenTime(screenTime);
	tMgr.updateTicketInfo(3, sBean, movieIdx, id, reservedSeats);
} catch (Exception e) {

}
%>
<!DOCTYPE html>
<html>
<head>
<style>
html{
     /* 드래그 방지 */
     -ms-user-select: none;
     -moz-user-select: -moz-none;
     -webkit-user-select: none;
     -khtml-user-select: none;
     user-select: none;
}
</style>

<script type="text/javascript">
location.href = "TicketingSection.jsp";
</script>
</head>
<body>
</body>
</html>