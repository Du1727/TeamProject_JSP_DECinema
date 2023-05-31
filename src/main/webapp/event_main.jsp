<!-- -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
	String event[] = {"5월의 이벤트","가디언즈 오브 갤럭시 필름","해피DEC데이","가디언즈 오브 갤럭시 탑퍼컵","[극장판 짱구는 못말려] 닌자피규어 전격 론칭!","[메리 마이 데드 바디] Meet & Greet", "이달의 아이스콘", "프렌즈 신상품 씨네샵 출시", "슈퍼마리오 굿즈 씨네샵 출시!"};
%>
<!doctype html>

<script type="text/javascript">
	function search(i, t) {
		document.eventFrm.index.value=i; 
		document.eventFrm.title.value=t; 
		document.eventFrm.submit();
	}
</script>
<%@include file ="navbar-white.jsp" %>	

<style>
.body{
	font-family: 배달의민족 도현;
}
</style>

 <body>
 	<main>
 	 <div class="container-lg">
<div class="container-lg">
	<h2 class="display-4" style="padding-top: 50px; text-align: center;">이벤트 <span class="text-theme">목록</span></h2>                
	<div class="section-bottom" style="padding-bottom: 50px;"></div>
</div>
	<div class="row row-cols-1 row-cols-md-3 g-3" style="padding-left: 18px; padding-bottom: 200px;">
	<%for(int i = 0; i < event.length; i++) { %>
		<a href="javascript:search('<%=i%>','<%=event[i]%>')" style="text-decoration: none; color: rgb(20,20,20);">
			<div class="card mx-1 border-0" style="width: 23rem;">
			    <img src="./assets/event/event<%=i%>.jpg" class="card-img-top mt-1" alt="" >
			    <div class="card-body" style="text-align: center;">
			      	<h5 class="card-title"><%=event[i]%></h5>	
			    </div>
			</div>
		</a>
	<% } %>
	</div>
</div>
</main>
	<form name="eventFrm" method="post" action="event_detail.jsp">
		<input type="hidden" name="index" value="">
		<input type="hidden" name="title" value="">
	</form>
 </body>
<%@include file = "footer.jsp" %>
