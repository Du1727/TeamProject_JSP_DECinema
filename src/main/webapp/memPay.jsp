<!-- memPay.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device width, initial-scale=1.0">

<style>
	div.box{
		width:800px;
		box-align:center middle;
		margin:10px;
		padding:10px;
		display:none;
	}	
	div.box2{
		width:800px;
		box-align:center middle;
		margin:10px;
		padding:10px;
		display:none;
	}
	
	div.step1{
		width:570px;
		box-align:center middle;
		margin:10px;
		padding:10px;
		dispaly:none;
	}
	div.step2{
		width:570px;
		box-align:center middle;
		margin:10px;
		padding:10px;
		dispaly:none;
	}
	div.step3{
		width:570px;
		box-align:center middle;
		margin:10px;
		padding:10px;
		dispaly:none;
	}
</style>

<title>회원 결제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script type="text/javascript" src="/js/bootstrap.js"></script>

<script>
function showDiv(element){
	var tag = document.getElementsByClassName("box");
	
	for(var i=0; i<tag.length; i++){
		if(element.id+"Pay" == tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}

function showPay(element){
	var tag = document.getElementsByClassName("box2");
	
	for(var i=0; i<tag.length; i++){
		if(element.id+"Pay" == tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}

function showStep1(element){
	var tag = document.getElementsByClassName("step1");
	
	for(var i=0; i<tag.length; i++){
		if(element.id+"Step1" == tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}

function showStep2(element){
	var tag = document.getElementsByClassName("step2");
	
	for(var i=0; i<tag.length; i++){
		if(element.id+"Step2" == tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}

function showStep3(element){
	var tag = document.getElementsByClassName("step3");
	
	for(var i=0; i<tag.length; i++){
		if(element.id+"Step3" == tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}

</script>

</head>
    <div class="section-title"
         style="color: white; background-color: rgb(255, 255, 255);">
         <div class="container" align="right">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
            <i class="bi bi-person-fill" style="font-size: 1.2rem; color: rgb(0, 0, 0);"></i>
            <a href=""
               style="color: rgb(50, 50, 50); text-decoration-line: none;">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style="color: rgb(50, 50, 50);">|</a>&nbsp;&nbsp;&nbsp;         
            <i class="bi bi-person-plus-fill" style="font-size: 1.2rem; color: rgb(0, 0, 0);"></i>
            &nbsp;<a href=""
               style="color: rgb(50, 50, 50); text-decoration-line: none;">회원가입</a>
         </div>
      </div>  
        <nav class="navbar navbar-expand-lg navbar-dark" id="mainNav">
            <div class="container" align="right" >
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav navbar-nav justify-content-end flex-grow-1 pe-3">
                        <li class="nav-item"><a class="nav-link" href="#buy" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-right: 25px">예매</a></li>
                        <li class="nav-item"><a class="nav-link" href="#move" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-right: 25px">영화</a></li>
                        <li class="nav-item"><a class="nav-link" href="#move2" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-right: 50px">영화관</a></li>
                        </ul>                        
                        </div>
                       <a class="navbar-brand" href="#page-top"><img src='https://ifh.cc/g/RWFm8K.png' border='0' width=100% height=100% alt="..." /></a>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-1">
                        <li class="nav-item"><a class="nav-link" href="#store" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-left: 45px;">스토어</a></li>
                        <li class="nav-item"><a class="nav-link" href="#event" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-left: 25px">이벤트</a></li>
                        <li class="nav-item"><a class="nav-link" href="#call" style="color: rgb(30,30,30); font-size: 1.05em; font-family: 배달의민족 도현; padding-left: 25px">문의사항</a></li>
                    </ul>
                </div>
            </div>
        </nav>
	<!-- 상단 헤더 네비바 -->
<body>
	
	<div class="container">
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid justify-content-end">
				<button type="button" class="btn" style="background-color:#F7F5E6"
					onmousedown="javascript:logClick('옵션/ENGLISH');"
					onclick="switchLanguage(); return false;">
					<span>ENGLISH</span>
				</button>
				<span class="px-1"></span>
				<button type="button" class="btn" style="background-color:#F7F5E6"
					onmousedown="javascript:logClick('옵션/상영시간표');"
					onclick="openSchedulPopup(); return false;" title="새창열기">
					<span>상영시간표</span>
				</button>
				<span class="px-1"></span>
				<button type="button" class="btn" style="background-color:#F7F5E6"
					onmousedown="javascript:logClick('옵션/예매다시하기');"
					onclick="ticketRestart(); return false;">
					<span>예매 다시하기</span>
				</button>
			</div>
		</nav>
		<div class="container" style="background-color:#F7F5E6; display:block;">
			<div class="flex-wrap" id="memPay">
			<div class="row">
				<div class="col-8">
					<div class="d-block p-1 bg-dark text-white font-weight-bold" style="text-indent:1em;">STEP 1.</div>
				</div>
	
				</div>
			</div>
			<div class="row">
			<div class="col-8">
				<div class="accordion accordion-flush" id="accordionFlushExample">
	  				<div class="accordion-item">
	    				<h2 class="accordion-header" id="flush-headingOne">
	      					<button class="accordion-button collapsed" style="background-color:#DEDCCD;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
	        				할인쿠폰
	      					</button>
	    				</h2>
	    				<div id="flush-collapseOne" style="background-color:#F7F5E6; border-style:solid;"
	    				class="accordion-collapse collapse border border-top-0" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
	      					<div class="accordion-body">
	      						<div class="row">
	      							<div class="col-3">
	      								<table>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30; width:300;" onclick="showStep1(this);" id="dec">DEC 할인쿠폰</td>
	      									</tr>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30;" onclick="showStep1(this);" id="credit">신용카드 할인쿠폰</td>
	      									</tr>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30;" onclick="showStep1(this);" id="final">최종결제 할인쿠폰</td>
	      									</tr>
	      									<tr class="border border-start-0"><td style="height:150;"></td></tr>
	      								</table>      						
	      							</div>
	      							<div class="col">
	      								<div id="decStep1" class="step1" style="display:block;"><form action="">
	      									<span>DEC 할인쿠폰</span>
	      									<div class="border-bottom"></div>
	      									<div class="text-center" style="height:150;">DEC 할인쿠폰 적용 페이지</div>
	      									<div class="border-top"></div>
	      									<p class="text-right">할인금액 :	1000원</p>
	      								</form></div>
	      								
	      								<div id="creditStep1" class="step1" style="display:none;"><form action="">
	      									<span>신용카드 할인쿠폰</span>
	      									<div class="border-bottom"></div>
	      									<div class="text-center" style="height:150;">신용카드 할인쿠폰 적용 페이지</div>
	      									<div class="border-top"></div>
	      									<p class="text-right">할인금액 :	10000원</p>
	      								</form></div>
	      								
	      								<div id="finalStep1" class="step1" style="display:none;"><form action="">
	      									<span>최종결제 할인쿠폰</span>
	      									<div class="border-bottom"></div>
	      									<div class="text-center" style="height:150;">최종결제 할인 적용 페이지</div>
	      									<div class="border-top"></div>
	      									<p class="text-right">할인금액 :	2원</p>
	      								</form></div>
	      							</div>
	      						</div>
	      					</div>
	    				</div>
	  				</div>
	  			</div>
			</div>
			</div>
			<br>
			<div class="row">
				<div class="col-8">
					<div class="d-block p-1 bg-dark text-white font-weight-bold" style="text-indent:1em;">STEP 2.</div>
				</div>
			</div>
			<div class="row">
			<div class="col-8">
				<div class="accordion accordion-flush" id="accordionFlushExample">
	  				<div class="accordion-item">
	    				<h2 class="accordion-header" id="flush-headingTwo">
	      					<button class= "accordion-button collapsed" style="background-color:#DEDCCD;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
	        				관람권/기프티콘
	      					</button>
	    				</h2>
	    				<div id="flush-collapseTwo" style="background-color:#F7F5E6; border-style:solid;"
	    				class="accordion-collapse collapse border border-top-0" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
	      					<div class="accordion-body">
	      						<div class="row">
	      							<div class="col-3">
	      								<table>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30; width:300;" onclick="showStep2(this);" id="movie">DEC 영화관람권</td>
	      									</tr>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30;" onclick="showStep2(this);" id="gift">DEC 기프트콘</td>
	      									</tr>
	      									<tr class="border border-start-0"><td style="height:150;"></td></tr>
	      								</table>      						
	      							</div>
	      							<div class="col">     							
	      								<div id="movieStep2" class="step2" style="display:block;"><form action="">
	      									<span>DEC 영화관람권</span>
	      									<div class="border-bottom"></div>
	      									<div class="text-center" style="height:150;">적용 가능한 관람권이 없습니다.</div>
	      									<div class="border-top"></div>
	      									<p class="text-right">할인금액 :	0원</p>
	      								</form></div>
	      								
	      								<div id="giftStep2" class="step2" style="display:none;"><form action="">
	      									<span>DEC 기프트콘</span>
	      									<div class="border-bottom"></div>
	      									<div class="text-center" style="height:150;">
	      										사용 가능한 기프트콘이 없습니다.<br>
	      										등록하시겠습니까?
	      									</div>
	      									<div class="border-top"></div>
	      									<p class="text-right">할인금액 :	0원</p>
	      								</form></div>
	      							</div>
	      						</div>
	      					</div>
	    				</div>
	  				</div>
	  			</div>
			</div>
			</div>
			<br>
			<div class="row">
				<div class="col-8">
					<div class="d-block p-1 bg-dark text-white font-weight-bold" style="text-indent:1em;">STEP 3.</div>
				</div>
			</div>
			<div class="row">
			<div class="col-8">
				<div class="accordion accordion-flush" id="accordionFlushExample">
	  				<div class="accordion-item">
	    				<h2 class="accordion-header" id="flush-headingThree">
	      					<button class= "accordion-button collapsed" style="background-color:#DEDCCD;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
	        				마일리지 및 기타 결제 수단
	      					</button>
	    				</h2>
	    				<div id="flush-collapseThree" style="background-color:#F7F5E6; border-style:solid;"
	    				class="accordion-collapse collapse border border-top-0" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
	      					<div class="accordion-body">
	      						<div class="row">
	      							<div class="col-3">
	      								<table>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30; width:300;" onclick="showStep3(this);" id="mileage">DEC 마일리지</td>
	      									</tr>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30;" onclick="showStep3(this);" id="culture">문화상품권/컬쳐캐쉬</td>
	      									</tr>
	      									<tr class="border border-start-0">
	      										<td style="font-size:14px; height:30;" onclick="showStep3(this);" id="etc">뭔가의 기타 결제 수단</td>
	      									</tr>
	      									<tr class="border border-start-0"><td style="height:150;"></td></tr>
	      								</table>      						
	      							</div>
	      							<div class="col">
	      								<div class="step3" id="mileageStep3" style="display:block;"><form action="">
	      									<span>DEC 마일리지</span>
	      									<div class="border-bottom"></div><br>
	      									<div class="row">
	      										<div class="col-1"></div>
	      										<div class="col-auto">보유 마일리지 : 10000원</div>
	      										<div class="col-auto">사용할 마일리지</div>
	      										<div class="col-auto text-right" style="border:3px solid #DEDCCD; width:100;">0</div>
	      										<span class="col">원</span>
	      									</div>
	      									<br><br>
	      									<div style="border:2px solid #DEDCCD; height:55;">
	      										<div class="p-3 font-weight-bold" style="font-size:13px;">
	      										이용 안내 <span class="p-1"></span><div class="vr"></div><span class="p-1"></span>
	      										마일리지 이용안내 뭐시기
	      										</div>
	      									</div>
	      								</form></div>
	      								
	      								<div class="step3" id="cultureStep3" style="display:none;"><form action="">
	      									<span>문화상품권 / 컬쳐캐쉬</span>
	      									<div class="border-bottom"></div><br>
	      									<div class="row">
	      										<div class="col-1"></div>
	      										<div class="col-auto">보유 컬쳐캐쉬 : 10000원</div>
	      										<div class="col-auto">사용할 컬쳐캐쉬</div>
	      										<div class="col-auto text-right" style="border:3px solid #DEDCCD; width:100;">0</div>
	      										<span class="col">원</span>
	      									</div>
	      									<br><br>
	      									<div style="border:2px solid #DEDCCD; height:55;">
	      										<div class="p-3 font-weight-bold" style="font-size:13px;">
	      										이용 안내 <span class="p-1"></span><div class="vr"></div><span class="p-1"></span>
	      										컬쳐랜드 이용안내 뭐시기
	      										</div>
	      									</div>
	      								</form></div>
	      								
	      								<div class="step3" id="etcStep3" style="display:none;"><form action="">
	      									<span>기타 결제수단</span>
	      									<div class="border-bottom"></div><br>
	      									<div class="row">
	      										<div class="col-1"></div>
	      										<div class="col-auto">보유 마일리지 : 10000원</div>
	      										<div class="col-auto">사용할 마일리지</div>
	      										<div class="col-auto text-right" style="border:3px solid #DEDCCD; width:100;">0</div>
	      										<span class="col">원</span>
	      									</div>
	      									<br><br>
	      									<div style="border:2px solid #DEDCCD; height:55;">
	      										<div class="p-3 font-weight-bold" style="font-size:13px;">
	      										이용 안내 <span class="p-1"></span><div class="vr"></div><span class="p-1"></span>
	      										마일리지 이용안내 뭐시기
	      										</div>
	      									</div>
	      								</form></div>
	      							</div>
	      						</div>
	      					</div>
	    				</div>
	  				</div>
	  			</div>
			</div>
			</div>
			<br>
			<div class="row">
				<div class="col-8">
					<div class="d-block p-1 bg-dark text-white font-weight-bold" style="text-indent:1em;">STEP 4.
					<span style="font-size:13px;">최종 결제 수단</span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-8">
					<div class="my-1" style="height:300px; border:2px solid #DEDCCD;" id=creditbox>
						<div class="row my-2 px-3"><div class="col">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="card" value="option1" onclick="showDiv(this);" checked>
							<label class="form-check-label" for="card">신용카드</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="phone" value="option2" onclick="showDiv(this);">
							<label class="form-check-label" for="phone">휴대폰 결제</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="simple" value="option3" onclick="showDiv(this);">
							<label class="form-check-label" for="simple">간편결제</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="bank" value="option4" onclick="showDiv(this);">
							<label class="form-check-label" for="bank">내통장결제</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="toss" value="option5" onclick="showDiv(this);">
							<label class="form-check-label" for="toss">토스</label>
						</div>
						</div></div><div style="border:1px solid #DEDCCD;"></div>				
						
						<!-- 신용카드 -->
						<div id="cardPay" class="box" style="display:block;">
						<form action="">
						<div class="row my-2">
							<div class="col-auto">
								<div class="px-3 my-1 align-text-bottom fw-bold" style="font-size:14px;">카드종류</div>
							</div>
							<div class="col-6">
								<select class="form-select px-1" style="width:150; font-size:14px;" aria-label="card-select">
								<option selected>카드 종류 선택</option>
								<option value="1">현대카드</option>
	  							<option value="2">신한카드</option>
	  							<option value="3">삼성카드</option>
								</select>
							</div>
						</div>
						<br><br><br><br>
						<a class="text-danger text-decoration-underline fw-bold" style="font-size:12px;">* 신용카드 결제는 최소 1000원 부터 가능합니다.
							<br>뭐시기 포인트 적립 뭐시기 캐쉬백 적립
							<br>(뭐시기랑 뭐시기는 포인트 중복 적립 불가)
						</a>
						</form>
						</div>
						
						<!-- 휴대폰 결제 -->
						<div id="phonePay" class="box">
						<form action="">
						<div class="row">
							<div class="col-auto">
								<div class="px-3 my-1 align-text-bottom" style="font-size:14px;">결제 금액</div>&nbsp;
							</div>
							<div class="col-6" style="font-size:18px">
							<a class="align-text-bottom fw-bold" style="font-size:18px;">18,000</a> &nbsp;
							<a class="align-text-top" style="font-size:14px;">원</a>
							</div>
							<div style="border:1px solid #DEDCCD;"></div>
							<a class="my-2 px-5 align-text-top" style="font-size:14px;">상품명 &nbsp;
							영화티켓 예매</a>
							<div style="border:1px solid #DEDCCD;"></div>
						</div>
						<br><br><br>
						<a class="text-danger fw-bold" style="font-size:12px;">* 휴대폰 결제 진행시 원할한 사용을 위하여 다음 사항을 꼭 확인하세요.<br></a>
						<a style="font-size:12px;">* 팝업 차단 설정을 꼭 해제하셔야 합니다. (도구->팝업 차단 끄기)
						<br>* 팝업 차단 해제 시, 웹 브라우저 새로고침으로 인하여 최대 10분 동안 동일 좌석 선택이 제한 될 수 있습니다.
						</a>
						</form>
						</div>
						
						<!-- 간편결제 -->
						<div id="simplePay" class="box">
						<div class="row"><div class="col">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="simpay" id="naver" onclick="showPay(this);" checked>
							<label class="form-check-label" for="naver">네이버페이</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="simpay" id="smile" onclick="showPay(this);">
							<label class="form-check-label" for="smile">스마일페이</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="simpay" id="ssg" onclick="showPay(this);">
							<label class="form-check-label" for="ssg">SSGPAY</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="simpay" id="kakao" onclick="showPay(this);">
							<label class="form-check-label" for="kakao">카카오페이</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="simpay" id="payco" onclick="showPay(this);">
							<label class="form-check-label" for="payco">PAYCO</label>
						</div>
						</div></div><div style="border:1px solid #DEDCCD;"></div>
						
							<!-- 간편결제 안의 radio -->
							<div id="naverPay" class="box2" style="display:block;">
							<form action="">
							<div class="row">
								<div class="px-5">
								<div class="align-text-bottom fw-bold" style="font-size:16px;">네이버페이 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 우측 하단에 있는 "결제하기" 버튼을 클릭해주세요. <br>
									2. 예매내역 확인 후 결제하기 버튼 클릭 시 "네이버페이" 결제 인증창이 뜹니다. <br>
									3. "네이버페이" 결제 인증창에서 정보를 입력하신 후 결제해주세요.
								</a>
								<br>
								<div class="my-3"></div>
								<a class="text-danger fw-bold" style="font-size:12px;">
								'네이버페이'는 결제시, 기본 1% 네이버페이 포인트가 적립됩니다.<br>
								'네이버페이'는 신용카드 선할인과 카드사 포인트는 이용이 불가능하며,<br>
								신용카드별 청구할인은 이용이 가능합니다.</a>
								</div>
							</div>	
							</form>
							</div>
							
							<div id="smilePay" class="box2">
							<form action="">
							<div class="row">
								<div class="px-5">
								<div class="align-text-top fw-bold" style="font-size:16px;">스마일페이 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 아래 결제하기 버튼 클릭 후 다음 단계로 이동 <br>
									2. 결제내역 확인 후 결제하기 버튼 클릭 시, 팝업창이 뜸 <br>
									3. 해당 '스마일페이' 팝업에서 원하는 카드를 선택 후 정보를 입력하시면 됩니다.
								</a>
								<br>
								<div class="my-3"></div>
								<a class="text-danger fw-bold" style="font-size:12px;">
								'스마일페이' 결제시, 기본 0.5% 스마일캐시가 적립되며,<br>
								스마일카드로 결제 시, 기본 0.5% + 추가 2.0% 적립되어 최대 2.5% 적립됩니다.<br>
								'스마일페이'는 즉시할인 신용카드, 카드사 포인트는 이용이 불가능하며,<br>
								신용카드별 청구할인은 이용이 가능합니다.</a>
								</div>
							</div>	
							</form>
							</div>
							
							<div id="ssgPay" class="box2">
							<form action="">
							<div class="row">
								<div class="px-5">
								<div class="align-text-top fw-bold" style="font-size:16px;">SSGPAY 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 우측 하단에 있는 '결제하기' 버튼을 클릭해주세요. <br>
									2. 예매내역 확인 후 결제하기 버튼 클릭 시 'SGGPAY' 결제 인증창이 뜹니다. <br>
									3. 'SSGPAY' 결제 인증창에서 정보를 입력하신 후 결제해주세요.
								</a>
								<br><br>
								<div class="my-3"></div>
								<a class="text-danger fw-bold" style="font-size:12px;">
								'SSGPAY'는 결제 시 신용카드 선할인과 카드사 포인트는<br>
								이용이 불가능하며, 신용카드 별 청구할인은 이용이 가능합니다.</a>
								</div>
							</div>	
							</form>
							</div>
							
							<div id="kakaoPay" class="box2">
							<form action="">
							<div class="row">
								<div class="px-5">
								<div class="align-text-top fw-bold" style="font-size:16px;">카카오페이 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 우측 하단에 있는 '결제하기' 버튼을 클릭해주세요. <br>
									2. 예매내역 확인 후 결제하기 버튼 클릭 시 '카카오페이' 결제 인증창이 뜹니다. <br>
									3. '카카오페이' 결제 인증창에서 정보를 입력하신 후 결제해주세요.
								</a>
								<br><br>
								<div class="my-3"></div>
								<a class="text-danger fw-bold" style="font-size:12px;">
								* '카카오페이'는 결제 시 신용카드 선할인과 카드사 포인트는 이용이 불가능하며,<br>
								신용카드 별 청구할인은 이용이 가능합니다.</a>
								</div>
							</div>	
							</form>
							</div>
							
							<div id="paycoPay" class="box2">
							<form action="">
							<div class="row">
								<div class="px-5">
								<div class="align-text-top fw-bold" style="font-size:16px;">PAYCO 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 우측 하단에 있는 '결제하기' 버튼을 클릭해주세요.<br>
									2. 상품 확인 후 결제하기 버튼 클릭 시 'PAYCO'결제 인증창이 뜹니다.<br>
									3. 'PAYCO' 결제 인증창에서 정보를 입력하신 후 결제해주세요.
								</a>
								<br>
								<div class="my-3"></div>
								<a class="text-danger fw-bold" style="font-size:12px;">
								'PAYCO'는 씨티카드와 즉시할인 신용카드, 카드사 포인트는 이용이 불가능하며,<br>
								신용카드 별 청구할인은 이용이 가능합니다.<br>
								'PAYCO' 할인쿠폰 사용 금액에 대해서는 CJONE 포인트 적립이 불가합니다.</a>
								</div>
							</div>	
							</form>
							</div>
						
						</div>
						
						<!-- 내통장결제 -->
						<div id="bankPay" class="box">
						<form action="">
						<div class="row">
							<div class="col-auto my-1 px-10">
								<div class="px-5 my-2">
								<div class="align-text-bottom fw-bold" style="font-size:16px;">내통장결제 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 아래 결제하기 버튼 클릭 후 다음 단계로 이동 <br>
									2. 결제내역 확인 후 결제하기 버튼 클릭 시, 팝업창 노출 <br>
									3. 해당 팝업창을 통해 본인명의의 계좌 1회 등록 <br>
									4. 계좌등록 시, 비밀번호만으로 현금 간편결제 서비스 이용
								</a>
								</div>
							</div>
						</div>
						<br><br>
						<a class="text-danger fw-bold" style="font-size:12px;">'내통장결제'는 CGV내 본인명의 계좌 등록 후 비밀번호만으로 결제할 수 있는 간편 결제 서비스입니다.<br>
						은행 점검시간인 경우 내통장결제 서비스 이용이 불가합니다.</a>
						</form>
						</div>
						
						<!-- 토스 -->
						<div id="tossPay" class="box">
						<form action="">
						<div class="row">
							<div class="col-auto my-1 px-10">
								<div class="px-5 my-2">
								<div class="align-text-bottom fw-bold" style="font-size:16px;">토스 결제 순서</div>
								<div class="my-2"></div>
								<a class="align-text-bottom" style="font-size:12px;">
									1. 우측 하단에 있는 "결제하기"버튼을 클릭해주세요. <br>
									2. 예매내역 확인 후 결제하기 버튼 클릭 시 '토스'결제 인증창이 뜹니다.1 <br>
									3. '토스'결제 인증창에서 정보를 입력하신 후 결제해주세요.
								</a>
								</div>
							</div>
						</div>
						<br><br>
						<a class="text-danger fw-bold" style="font-size:12px;">'토스'는 신용카드 선할인과 카드사 포인트는 이용이 불가능하며,<br>
						신용카드별 청구할인은 이용이 가능합니다.</a>
						</form>
						</div>
						
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>

<footer>
	<%@include file="/footer.jsp"%>
</footer>


</html>