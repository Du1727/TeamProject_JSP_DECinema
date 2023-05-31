<%@page import="member.MemberBean"%>
<%@page import="java.util.Arrays"%>
<%@page import="ticketing.SeatBean"%>
<%@page import="java.util.Vector"%>
<%@page import="ticketing.ScreeningInfoBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tMgr" class="ticketing.TicketingMgr" />
<jsp:useBean id="mMgr" class="member.MemberMgr" />
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
boolean flag = false;
MemberBean mBean = new MemberBean();
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
	Vector<String> reservedSeatsPosition = new Vector<String>(Arrays.asList(reservedSeats.split("/")));
	sBean.setReservedSeatsPosition(reservedSeatsPosition);
	flag = tMgr.insertTicketingInfo(sBean, id, totalPrice, peopleInfo);
	mBean = mMgr.getMember(id);
} catch (Exception e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<form action="ticketPayResult.jsp" id="frm" name="frm">
		<input type="hidden" name="movieIdx" value="<%=movieIdx%>"> <input
			type="hidden" name="cityAddress" value="<%=cityAddress%>"> <input
			type="hidden" name="sectionName" value="<%=sectionName%>"> <input
			type="hidden" name="theaterNum" value="<%=theaterNum%>"> <input
			type="hidden" name="screenTime" value="<%=screenTime%>"> <input
			type="hidden" name="reservedSeats" value="<%=reservedSeats%>">
		<input type="hidden" name="peopleInfo" value="<%=peopleInfo%>">
		<input type="hidden" name="id" value="<%=id%>"> <input
			type="hidden" name="totalPrice" value="<%=totalPrice%>">
	</form>
	<script>
    if (<%=!flag%>) {
    	alert("세션 만료되었거나 이미 선택된 좌석입니다.");
    	location.href='SelectSeatSection.jsp';
	}
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'DEC:<%=movieNm%>',
            amount : <%=totalPrice/1000%>,
            buyer_email : '<%=mBean.getMail()%>',
            buyer_name : '<%=mBean.getName()%>',
            buyer_tel : '<%=mBean.getPhone()%>',
			buyer_addr : '부산광역시 진구 동의대학교',
			buyer_postcode : '(051)123-456',
			m_redirect_url : 'http://www.naver.com'
			}, function(rsp) {
				if (rsp.success) {
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					jQuery.ajax({
						url : "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
						type : 'POST',
						dataType : 'json',
						data : {
							imp_uid : rsp.imp_uid
						//기타 필요한 데이터가 있으면 추가 전달
						}
					}).done(function(data) {
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (everythings_fine) {
							msg = '결제가 완료되었습니다.';
							msg += '\n고유ID : ' + rsp.imp_uid;
							msg += '\n상점 거래ID : ' + rsp.merchant_uid;
							msg += '\결제 금액 : ' + rsp.paid_amount;
							/*  msg += '카드 승인번호 : ' + rsp.apply_num; */
							alert(msg);
						} else {
							//[3] 아직 제대로 결제가 되지 않았습니다.
							//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
						}
					});
					//성공시 이동할 페이지
					document.frm.submit();
				} else {
					msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					alert(msg);
					//실패시 이동할 페이지
					location.href = "ticketFailResult.jsp";
				}
			});
		});
	</script>
</body>
</html>
