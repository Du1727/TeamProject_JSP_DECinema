<%@page import="controller.ParsingMgr"%>
<%@page import="store.UtilMgr"%>
<%@page import="movie.OfficeBean"%>
<%@page import="movie.MovieMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="store.storeBean"%>
<%@page import="controller.Parsing"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="storeMgr" class="store.storeMgr"></jsp:useBean>
<jsp:useBean id="movieMgr" class="movie.MovieMgr"></jsp:useBean>


	<%-- ParsingMgr parsing = new ParsingMgr();
	parsing.insertBoxOffice(); //박스오피스 자동추가 --%>	 
<%	
	session.setMaxInactiveInterval(1200);
	String id = (String)session.getAttribute("idKey");	
	Vector<OfficeBean> vlist = movieMgr.loadOfficeMovie();
	Vector<storeBean> blist = storeMgr.getHighLight();
	
%>

<!DOCTYPE html>
<html>
	<script type="text/javascript">
		function search(t) {
			document.movieFrm.title.value=t; 
			document.movieFrm.submit();
		}
	</script>
	<head>
		<%@include file ="navbar-black.jsp" %>	
	</head>
    <body class="body" > 
        <section class="section-solid-long section-text-white position-relative">
            <div class="d-background" data-image-src="assets/img/body_background.png" data-parallax="scroll"></div>
            <div class="d-background bg-gradient-black"></div>
            <div class="container position-relative" style="height: 800px;">
                <div class="slick-spaced slick-carousel" data-slick-view="navigation single">
                    <div class="slick-slides">
                    <%for(int i = 0; i < vlist.size(); i++) {
                    	OfficeBean bean = vlist.get(i);	%>
                        <div class="slick-slide" >
                            <article class="movie-line-entity">
                                <div class="entity-preview">
                                    <div class="embed-responsive embed-responsive-16by9" style="width: 750px; height: 750px;">
                                        <a href="javascript:search('<%=bean.getName()%>')"><img class="embed-responsive-item" style=" padding-left: 250px; padding-top: 50px;" src=<%=bean.getPhoto()%> alt="" /></a>
                                    </div>
                                </div>
                                <div class="entity-content" style=" padding-left: 220px;">
                                    <h4 class="entity-title">
                                        <a class="content-link" href="javascript:search('<%=bean.getName()%>')"><%=bean.getName()%></a>
                                    </h4>
                                    <div class="entity-category">
                                        <a class="content-link"><%=bean.getGenre()%></a>
                                    </div>
                                    <div class="entity-info">
                                        <div class="info-lines">
                                            <div class="info info-short">
                                                <span class="text-theme info-icon"><i class="fas fa-trophy"></i></span>
                                                <span class="info-text"><%=bean.getIdx()%></span>
                                                <span class="info-rest">&nbsp;위</span>
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
                                    <p class="text-long entity-text"><%=bean.getIntro().length()>97?bean.getIntro().substring(0,97)+"...":bean.getIntro()%></p>
                                </div>
                            </article>
                        </div>
                     <% } %>
                    </div>
                    <div class="slick-arrows">
                        <div class="slick-arrow-prev">
                            <span class="th-dots th-arrow-left th-dots-animated">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </div>
                        <div class="slick-arrow-next">
                            <span class="th-dots th-arrow-right th-dots-animated">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="section-head"></div><div class="section-head"></div><div class="section-head"></div>
            </div>
        </section>       
        <section class="section-text-white position-relative">
            <div class="d-background" data-image-src="assets/img/body_background.png" data-parallax="scroll"></div>
            <div class="d-background bg-theme-blacked"></div>
            <div class="mt-auto container position-relative">
                <div class="top-block-head text-uppercase">
                    <h2 class="display-4">무비
                        <span class="text-theme">차트</span>
                    </h2>
                </div>
                <div class="top-block-footer">
                    <div class="slick-spaced slick-carousel" data-slick-view="navigation responsive-4">
                        <div class="slick-slides">
                    <%for(int i = 0; i < vlist.size(); i++) {
                    	OfficeBean bean = vlist.get(i);	%>
                            <div class="slick-slide">
                                <article class="poster-entity" data-role="hover-wrap">
                                    <div class="embed-responsive embed-responsive-poster">
                                        <img class="embed-responsive-item" src=<%=bean.getPhoto()%> alt="" />
                                    </div>
                                    <div class="d-background bg-theme-lighted collapse animated faster" data-show-class="fadeIn show" data-hide-class="fadeOut show"></div>
                                    <div class="d-over bg-highlight-bottom">
                                        <div class="collapse animated faster entity-play" data-show-class="fadeIn show" data-hide-class="fadeOut show">
                                            <a class="action-icon-theme action-icon-bordered rounded-circle" href="<%=bean.getTrailer()%>" data-magnific-popup="iframe">
                                                <span class="icon-content"><i class="fas fa-play"></i></span>
                                            </a>
                                        </div>
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
                                                    <span class="text-theme info-icon"><i class="fas fa-clock"></i></span>
                                                    <span class="info-text"><%=bean.getRuntime()%></span>
                                                    <span class="info-rest">&nbsp;분</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        <% } %>
                        </div>
                        <div class="slick-arrows">
                            <div class="slick-arrow-prev">
                                <span class="th-dots th-arrow-left th-dots-animated">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                            </div>
                            <div class="slick-arrow-next">
                                <span class="th-dots th-arrow-right th-dots-animated">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="section-long">        
        <div class="d-background" data-parallax="scroll"></div>
            <div class="d-background"></div>
            <div class="mt-auto container position-relative">
                <div class="top-block-head text-uppercase">
                    <h2 class="display-4">스토어
                        <span class="text-theme">Best</span>
                    </h2>
                </div>
                <div class="top-block-footer">
                    <div class="slick-spaced slick-carousel" data-slick-view="navigation responsive-4">
                        <div class="slick-slides">
							<%
							for (int i = 0; i < blist.size(); i++) {
								storeBean bean2 = blist.get(i);
							%>
                            <div class="slick-slide" style="text-align: center;" align="center">
                                <article class="poster-entity" data-role="hover-wrap">
                                    <div class="embed-responsive embed-responsive-poster" style="height: 300px;">
                                        <img class="embed-responsive-item" src="./assets/img/store/<%=bean2.getImage()%>" alt=""/>
                                    </div>
                                    <div class="d-background bg-theme-lighted collapse animated faster" data-show-class="fadeIn show" data-hide-class="fadeOut show"></div>
                                    <div class="d-over bg-highlight-bottom">
                                        <div class="collapse animated faster entity-play" data-show-class="fadeIn show" data-hide-class="fadeOut show">
                                            <a class="action-icon-theme action-icon-bordered rounded-circle" href="store_main.jsp">
                                                <span class="icon-content"><i class="bi bi-cart-plus fs-3"></i></span>
                                            </a>
                                        </div>
                                        <h4 class="entity-title">
                                            <a class="content-link" style="font-size: 1.6rem;"><%=bean2.getName()%></a>
                                        </h4>
                                        <div class="entity-category">
                                            <a class="content-link" style="font-size: 1.0rem;"><%=bean2.getDetail()%></a>
                                        </div>
                                        <div class="entity-info">
                                            <div class="info-lines">
                                                <div class="info info-short">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <span class="text-theme info-icon" style="font-size: 1.2rem;"><i class="fa-solid fa-coins"></i></span>
                                                    <span class="info-text" style="font-size: 1.2rem;"><%=UtilMgr.monFormat(bean2.getPrice())%> 원</span>                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        <% } %>
                        </div>
                        <div class="slick-arrows">
                            <div class="slick-arrow-prev">
                                <span class="th-dots th-arrow-left th-dots-animated">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                            </div>
                            <div class="slick-arrow-next">
                                <span class="th-dots th-arrow-right th-dots-animated">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
		<form name="movieFrm" method="post" action="moviedetail.jsp">
			<input type="hidden" name="title" value="">
		</form>
    </body>
    <%@include file = "footer.jsp" %>
</html>