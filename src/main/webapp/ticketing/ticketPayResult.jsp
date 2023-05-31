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
	System.out.println(totalPrice);
	ScreeningInfoBean sBean = new ScreeningInfoBean();
	sBean.setCityAddress(cityAddress);
	sBean.setSectionName(sectionName);
	sBean.setTheaterNum(theaterNum);
	sBean.setScreenTime(screenTime);
	tMgr.updateTicketInfo(1, sBean, movieIdx, id, reservedSeats);
} catch (Exception e) {
	e.printStackTrace();
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

function direct_index() {
	
	document.pay_result.action = "TicketingSection.jsp";
	document.pay_result.submit();
	
}


</script>


</head>


<body>

<div align="center" style="padding-top: 180px; padding-bottom: 100px;">
    <form name="pay_result" method="post" >	        
     	<!-- <img class="embed-responsive-item" src="https://ifh.cc/g/obrdKv.png"/> -->
     	<img src="data:image/png;base64,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">
     	<br><br>
     	<h4><b>결제가 완료되었습니다.</b></h4>                  	
     	<br><br><br>
     	
	     <div class="login">      
	     <button type="button" onclick="javascript:direct_index()" class="btn btn-lg btn-block btn-success" style="width: 200px;">돌아가기</button>
	     </div>     	
	</form>
</div>
</body>
</html>