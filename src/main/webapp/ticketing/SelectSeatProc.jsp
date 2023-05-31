<%@page import="ticketing.TheaterBean"%>
<%@page import="ticketing.SeatBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.HashMap"%>
<%@page import="ticketing.MovieInfoBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="ticketing.TicketingMgr"/>
<%
try{
	String movieNm = (String)session.getAttribute("movieNm");
	String movieIdx = (String)session.getAttribute("movieIdx");
	String cityNm = (String)session.getAttribute("cityNm");
	String theaterNm = (String)session.getAttribute("theaterNm");
	String selectTime = (String)session.getAttribute("selectTime");
	String printDate = (String)session.getAttribute("printDate");
	int type = Integer.parseInt(request.getParameter("age_info"));
	int adult = (int)session.getAttribute("adult");
	int teenager = (int)session.getAttribute("teenager");
	int children = (int)session.getAttribute("children");
	session.setAttribute("type", type);
	int seatNum = Integer.parseInt(request.getParameter("seatNum"));
	Vector<SeatBean> vlist = (Vector<SeatBean>)session.getAttribute("vlist");
	if(seatNum!=-1){
		int add = 0;
		int preType = vlist.get(seatNum).getStatus();
		vlist.get(seatNum).statusToggle(type);
		if(vlist.get(seatNum).getStatus()!=0){
			add = 1;
		} else {
			add = -1;
		}
		switch(preType!=0?preType:type){
		case -1:
			adult += add;
			break;
		case -2:
			teenager += add;
			break;
		case -3:
			children += add;
			break;
		default:
			break;
		}
	}
	session.setAttribute("vlist", vlist);
	session.setAttribute("adult", adult);
	session.setAttribute("teenager", teenager);
	session.setAttribute("children", children);
	response.sendRedirect("SelectSeatSection.jsp");
}catch(Exception e){
	
}
%>
<!DOCTYPE jsp:useBean PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
alert("세션이 만료되었습니다.");
location.href="TicketingSection.jsp";
</script>