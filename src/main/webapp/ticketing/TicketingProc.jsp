<%@page import="ticketing.TheaterBean"%>
<%@page import="ticketing.SeatBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.HashMap"%>
<%@page import="ticketing.MovieInfoBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="ticketing.TicketingMgr"/>
<%
String movieIdx = request.getParameter("movieIdx");
String cityIdx = request.getParameter("cityIdx")!=null?request.getParameter("cityIdx"):"1";
String cityNm = request.getParameter("cityNm")!=null?request.getParameter("cityNm"):"강원";
String theaterNm = request.getParameter("theaterNm");
HashMap<Integer, Vector<SeatBean>> filterSeat = (HashMap<Integer, Vector<SeatBean>>) session.getAttribute("filterSeat");
if(!request.getParameter("sectionNm").equals("null")&&!request.getParameter("sectionNm").equals(session.getAttribute("sectionNm"))){
	String sectionNm = request.getParameter("sectionNm");
	session.setAttribute("sectionNm", sectionNm);
	filterSeat = new HashMap<Integer, Vector<SeatBean>>();
	Vector<TheaterBean> vlist = mMgr.getTheaterList(cityNm, sectionNm);
	for(int i=0;i<vlist.size();i++){
		Vector<SeatBean> seatList = new Vector<SeatBean>();
		for(int j=0;j<vlist.get(i).getSeat();j++){
			seatList.add(new SeatBean(null,0));
		}
		filterSeat.put(vlist.get(i).getNum(), seatList);
	}
}
String selectTime = request.getParameter("selectTime");
String tableNm = request.getParameter("tableNm");
String dateIdx = request.getParameter("dateIdx");
String datePage = request.getParameter("datePage");
String printDate = request.getParameter("printDate");
String movieSort = request.getParameter("movieSort");
int seatNum = Integer.parseInt(request.getParameter("seatNum"));
int filterTheaterNum = Integer.parseInt(request.getParameter("filterTheaterNum"));
session.setAttribute("movieIdx", movieIdx);
session.setAttribute("movieSort", movieSort);
session.setAttribute("cityIdx", cityIdx);
session.setAttribute("cityNm", cityNm);
session.setAttribute("theaterNm", theaterNm);
session.setAttribute("selectTime", selectTime);
session.setAttribute("tableNm", tableNm);
session.setAttribute("dateIdx", dateIdx);
session.setAttribute("datePage", datePage);
session.setAttribute("printDate", printDate);
session.setAttribute("filterTheaterNum", filterTheaterNum);
if(seatNum!=-1){
	filterSeat.get(filterTheaterNum).get(seatNum).statusToggle();
}
session.setAttribute("filterSeat", filterSeat);
if(selectTime!=null&&!selectTime.equals("null")){
	session.setAttribute("changeTime", "Yes");
} else {
	session.setAttribute("changeTime", null);
}
response.sendRedirect("TicketingSection.jsp");
%>