<%@page import="java.util.Vector"%>
<%@page import="store.UtilMgr"%>
<%@page import="store.storeBean"%>
<%@page import="java.util.Random"%>
<%@page import="movie.MovieBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="movieMgr" class="movie.MovieMgr"></jsp:useBean>
<jsp:useBean id="storeMgr" class="store.storeMgr"></jsp:useBean>

<%	

	request.setCharacterEncoding("UTF-8");
	int recommandMoive[] = new int[4];
	int recommandShop[] = new int[3];
	Random r = new Random();
	String id = (String)session.getAttribute("idKey");
	Vector<MovieBean> vlist = movieMgr.loadAllMovie();
	Vector<storeBean> vlist2 = storeMgr.productAll();
	MovieBean bean = null;
	MovieBean rbean[] = new MovieBean[3];
	storeBean sbean[] = new storeBean[3];
	String title = "브라더 베어";
	if(request.getParameter("title")!=null)
		title = request.getParameter("title");
	
	for(int i = 0; i < vlist.size(); i++) {
		if(vlist.get(i).getName().equals(title)) {
			bean = vlist.get(i);			
			recommandMoive[0] = i+1;
			break;
		}
	}
	//추천 영화 난수 생성
	for(int i=1; i<4; i++){
		recommandMoive[i] = r.nextInt(vlist.size()) + 1;
		for(int j=0; j<i; j++){
			if(recommandMoive[i] == recommandMoive[j]){
				i--;
			}
		}
	}
	//추천 상품 난수 생성
	for(int i=0; i<3; i++){
		recommandShop[i] = r.nextInt(vlist2.size());
		for(int j=0; j<i; j++){
			if(recommandShop[i] == recommandShop[j]){
				i--;
			}
		}
	}
	for(int i=0; i<3; i++){
		rbean[i] = vlist.get(recommandMoive[i+1]);	
		sbean[i] = vlist2.get(recommandShop[i]);
	}
%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	function search(t) {
		document.movieFrm.title.value=t; 
		document.movieFrm.submit();
	}
	function buy(t) {
		document.buyFrm.movieIdx.value=t; 
		document.buyFrm.submit();
	}
</script>
    <head>    	
		<%@include file ="navbar-white.jsp" %>	
    </head>
    <body class="body">
        <div class="container">
            <div class="sidebar-container">
                <div class="content" style="padding-top: 100px;">
                    <div class="section-line">
                        <div class="movie-info-entity">
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
                                <h2 class="section-title" class="entity-title" style="font-size: 3rem;"><%=bean.getName()%></h2>
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
                                <ul class="entity-list">
                                    <li>
                                        <span class="entity-list-title">개봉:</span><%=bean.getOpendt()%> ~ <%=bean.getEnddt()%></li>
                                    <li>
                                        <span class="entity-list-title">감독:</span><%=bean.getDirector()%>                                     </li>
                                    <li>
                                        <span class="entity-list-title">배우:</span><%=bean.getActor()%>
                                    </li>
                                    <li>
                                        <span class="entity-list-title">연령제한:</span><%=bean.getAgelimit().length()>2?"전체이용가":bean.getAgelimit()+"세 이용가"%>
                                    </li>
                                </ul>
                                <br><hr><br>
                                <a class="btn-theme btn" href="payHistory.jsp" style="  background-color: #74D36D;  border-color: rgba(255,255,255,0.1);
							color: #fff;"><i class="bi bi-cart-plus"></i>&nbsp;&nbsp;결제정보</a>
                                <a class="btn-theme btn" href="javascript:buy('<%=bean.getIdx()%>')" style="  background-color: #ff8a00;  border-color: rgba(255,255,255,0.1);
							color: #fff;"><i class="fas fa-ticket-alt"></i>&nbsp;&nbsp;예매하기</a>
                            </div>
                        </div>
                    </div>
                    <div class="section-line">
                        <div class="section-head" style="padding-left: 0;">
                            <h2 class="section-title"><i class="fa-solid fa-film"></i>&nbsp;줄거리</h2>
                        </div>
                        <div class="section-description">
                            <%for(int i = 0; i < bean.getIntro().split("[.]").length; i++ ) {%>
                             	<%for(int j = 0; j < bean.getIntro().split("[.]")[i].split(",").length; j++ ) {%>
                              <p class="lead">		                                
                              	<%=bean.getIntro().split("[.]")[i].split(",")[j]%>
                              </p>
                              <% } %>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="section-line">
                        <div class="section-head" style="padding-left: 0;">
                            <h2 class="section-title" style="padding-top: 50px;"><i class="fa-solid fa-clapperboard"></i>&nbsp;예고편</h2>
                        </div>                            
                        <div class="entity-preview" data-role="hover-wrap">
                            <iframe width="700" height="400" src="<%=bean.getTrailer().replace("watch?v=", "embed/")%>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            <br><br><br><br><br>
                        </div>
                    </div>
            </div>
            <div class="sidebar section-long order-lg-last">
                <section class="section-sidebar" style="padding-top: 0px;">
                    <div class="section-head" style="padding-left: 0;">
                        <h3 class="section-title"><i class="fa-solid fa-star"></i>&nbsp;이런 영화는 어때요? <i class="fa-thin fa-message-question"></i></h3>
                    </div>
                    <%for(int i = 0; i < 3; i++) { %>
                     <div class="movie-short-line-entity">
                         <a class="entity-preview" href="javascript:search('<%=rbean[i].getName()%>')">
                             <span class="embed-responsive embed-responsive-16by9"  style="width: 130px; height: 170px;">
                                 <img class="embed-responsive-item" src="<%=rbean[i].getPhoto()%>" alt=""/>
                             </span>
                         </a>
                         <div class="entity-content">
                             <h4 class="entity-title">
                                 <a class="content-link" href="javascript:search('<%=rbean[i].getName()%>')"><%=rbean[i].getName()%></a>
                             </h4>
                             <p class="entity-subtext"><%=rbean[i].getGenre()%></p>
                         </div>
                     </div>
                    <% } %>
                    <div class="section-head" style="padding-top: 65px; padding-left: 0px;">
                        <h3 class="section-title"><i class="fa-solid fa-store"></i>&nbsp;함께 주문하세요!</h3>
                    </div>
                    <%for(int i = 0; i < 3; i++) { %>
                     <div class="movie-short-line-entity">
                         <a class="entity-preview" href="store_main.jsp">
                             <span class="embed-responsive embed-responsive-16by9"  style="width: 130px; height: 170px;">
                                 <img class="embed-responsive-item" src="./assets/img/store/<%=sbean[i].getImage()%>" alt=""/>
                             </span>
                         </a>
                         <div class="entity-content">
                             <h4 class="entity-title">
                                 <a class="content-link" href="store_main.jsp"><%=sbean[i].getName()%></a>
                             </h4>
                             <p class="entity-subtext"><%=UtilMgr.monFormat(sbean[i].getPrice())%>&nbsp;원</p>
                         </div>
                     </div>
                    <% } %>
                    </section>   
                </div>
            </div>
        </div>
		<form name="movieFrm" method="post" action="moviedetail.jsp">
			<input type="hidden" name="title" value="">
		</form>
		<form name="buyFrm" method="post" action="TicketingSite.jsp">
			<input type="hidden" name="movieIdx" value="">
		</form>
    </body>    
    <%@include file ="footer.jsp" %>
</html>