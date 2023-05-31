<%@page import="movie.MovieBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="movieMgr" class="movie.MovieMgr"></jsp:useBean>
<%	

	String id = (String)session.getAttribute("idKey");
	Vector<MovieBean> vlist = movieMgr.loadAllMovie();
	int nowPage = 1;
	int maxPage = vlist.size()/5+1;
	if(request.getParameter("page")!=null)
		nowPage = Integer.parseInt(request.getParameter("page"));
	
	
%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	function pageing(p) {
		document.pageFrm.page.value=p;  
		document.pageFrm.submit();
	}
	function search(t) {
		document.movieFrm.title.value=t; 
		document.movieFrm.submit();
	}
</script>
    <head>    	
		<%@include file ="navbar-white.jsp" %>	
    </head>
    <body class="body">
            <div class="container">
                <h2 class="display-4" style="padding-top: 50px; text-align: center;">영화 <span class="text-theme">목록</span></h2>                
                <div class="section-bottom" style="padding-bottom: 50px;">
                    <div class="paginator">                                        	
                        <a class="paginator-item" href="javascript:pageing('<%=nowPage-1%>')"><i class="fas fa-chevron-left"></i></a>
                        <%if(nowPage != 1) { %>
                        	<a class="paginator-item" href="javascript:pageing(1)">1</a>                        
                        <% } %>
                        <%if(nowPage > 3) { %>
                        <span class="paginator-item">...</span>
                        <% } %>                        
                        <% for(int i = 2; i >= 1; i--) {
                        	if(nowPage-i>0 && nowPage-i!=1) {%>
                        	<a class="paginator-item" href="javascript:pageing('<%=nowPage-i%>')"><%=nowPage-i%></a>  
                        <% }} %>                   
                        <a class="active paginator-item" href="javascript:pageing('<%=nowPage%>')"><%=nowPage%></a>
                        <% for(int i = 1; i < 3; i++) {
                        	if(nowPage+i<maxPage && nowPage+i!=maxPage) {%>
                        	<a class="paginator-item" href="javascript:pageing('<%=nowPage+i%>')"><%=nowPage+i%></a>  
                        <% }} %>                              
                        <% if (nowPage < maxPage-3) { %>
                        <span class="paginator-item">...</span>
                        <% } %>
                        <% if (nowPage != maxPage) { %>
                        	<a class="paginator-item" href="javascript:pageing(<%=maxPage%>)"><%=maxPage%></a>
                        <% } %>
                        <a class="paginator-item" href="javascript:pageing('<%=nowPage+1%>')"><i class="fas fa-chevron-right"></i></a>
                    </div>
                </div>
                <%for(int i = (nowPage-1)*5; i < (nowPage*5>vlist.size()?vlist.size():(nowPage*5)); i++) {                	
                	MovieBean bean = vlist.get(i);	%>    
                <article class="movie-line-entity">
                    <div class="entity-poster" data-role="hover-wrap">
                        <div class="embed-responsive embed-responsive-poster">
                            <img class="embed-responsive-item" src="<%=bean.getPhoto()%>" alt="" />
                        </div>
                        <div class="d-over bg-theme-lighted collapse animated faster" data-show-class="fadeIn show" data-hide-class="fadeOut show">
                            <div class="entity-play">
                                <a class="action-icon-theme action-icon-bordered rounded-circle" href="<%=bean.getTrailer()%>" data-magnific-popup="iframe">
                                    <span class="icon-content"><i class="fas fa-play"></i></span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="entity-content">
                        <h4 class="entity-title">
                            <a class="content-link" href="javascript:search('<%=bean.getName()%>')"><%=bean.getName()%></a>
                        </h4>
                        <div class="entity-category">
                            <a class="content-link"><%=bean.getGenre()%></a>
                        </div>
                        <div class="entity-info">
                            <div class="info-lines">
                                <div class="info info-short">
                                    <span class="text-theme info-icon"><i class="fas fa-star"></i></span>
                                    <span class="info-text"><%=bean.getVote().substring(0,3)%></span>
                                    <span class="info-rest">/10</span>
                                </div>   
                                <div class="info info-short">
                                    <span class="text-theme info-icon"><i class="fas fa-calendar-alt"></i></span>
                                    <span class="info-text"><%=bean.getOpendt()%></span>
                                </div>
                                <div class="info info-short">
                                    <span class="text-theme info-icon"><i class="fas fa-clock"></i></span>
                                    <span class="info-text"><%=bean.getRuntime()%></span>
                                    <span class="info-rest">&nbsp;분</span>
                                </div>
                            </div>
                        </div>
                        <p class="text-short entity-text"><%=bean.getIntro()%>
                        </p>
                    </div>
                    <div class="entity-extra">
                        <div class="text-uppercase entity-extra-title">출연진</div>
                        <div class="entity-showtime">
                       		<%for(int j = 0; j < bean.getActor().split("/").length; j++) { %>
   	                        <div class="showtime-wrap"><div class="showtime-item">
   	                        <a class="btn-time btn" aria-disabled="false" style="width:283px;"
   	                         href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=
   	                         <%=bean.getActor().split("/")[j]%>"><%=bean.getActor().split("/")[j]%></a></div></div>                          			
                            <% } %>
                        </div>
                    </div>
                </article>
                <% } %>
                <div class="section-bottom" style="padding-bottom: 200px;">
                    <div class="paginator">                                        	
                        <a class="paginator-item" href="javascript:pageing('<%=nowPage-1%>')"><i class="fas fa-chevron-left"></i></a>
                        <%if(nowPage != 1) { %>
                        	<a class="paginator-item" href="javascript:pageing(1)">1</a>                        
                        <% } %>
                        <%if(nowPage > 3) { %>
                        <span class="paginator-item">...</span>
                        <% } %>                        
                        <% for(int i = 2; i >= 1; i--) {
                        	if(nowPage-i>0 && nowPage-i!=1) {%>
                        	<a class="paginator-item" href="javascript:pageing('<%=nowPage-i%>')"><%=nowPage-i%></a>  
                        <% }} %>                   
                        <a class="active paginator-item" href="javascript:pageing('<%=nowPage%>')"><%=nowPage%></a>
                        <% for(int i = 1; i < 3; i++) {
                        	if(nowPage+i<maxPage && nowPage+i!=maxPage) {%>
                        	<a class="paginator-item" href="javascript:pageing('<%=nowPage+i%>')"><%=nowPage+i%></a>  
                        <% }} %>                              
                        <% if (nowPage < maxPage-3) { %>
                        <span class="paginator-item">...</span>
                        <% } %>
                        <% if (nowPage != maxPage) { %>
                        	<a class="paginator-item" href="javascript:pageing(<%=maxPage%>)"><%=maxPage%></a>
                        <% } %>
                        <a class="paginator-item" href="javascript:pageing('<%=nowPage+1%>')"><i class="fas fa-chevron-right"></i></a>
                    </div>
                </div>
            </div>
		<form name="pageFrm" method="post" action="movielist.jsp">
			<input type="hidden" name="page" value="<%=nowPage%>">
		</form>
		<form name="movieFrm" method="post" action="moviedetail.jsp">
			<input type="hidden" name="title" value="">
		</form>
    </body>
    
    <%@include file ="footer.jsp" %>
</html>