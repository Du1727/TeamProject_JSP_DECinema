<!-- nonmemPay.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
<head>
<title>비회원 결제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
</head>
<body style="background-color:#F7F5E6">
<div class="p-3 bg-white" style="height:5%"></div>
<div class="px-1">
<table>
	<tr>
		<table border = "0" width="995" height="35">
			<tr>
				<th width="100" class="text-center" style="color:white; background-color:#282828;">비회원 결제</th>
				<td width="600" class="text-left" style="color:white; font-size:10px; background-color:#282828">비회원 예매는 신용카드 결제만 가능합니다.</td>
				<td width="30"></td>
				<td style="background-color:white"></td>
			</tr>
		</table>
	</tr>
	<tr>
	<div class="px-3">
	<table border="0" width="980">
	<tr>
	<td>
		<table class="table table-sm">
		<tr>
			<th width="680" height="35">
				<div class="form-check">
  					<input class="form-check-input" type="radio" name="nonmemcardRadios1" id="nonmemcardRadios1" value="option1" checked>
  					<label class="form-check-label" for="nonmemcardRadios1">신용카드</label>
				</div>
			</th>
		</tr>
		<tr>
			<th height="35">
			<div class="px-4" style="font-size:14px">카드 종류
			<span class="mx-2"></span>
				<select class="form-select px-1" aria-label="card-select">
  				<option selected>카드 종류 선택</option>
  				<option value="1">현대카드</option>
  				<option value="2">신한카드</option>
  				<option value="3">삼성카드</option>
				</select>
			</div>
			</th>
		</tr>
		<tr>
			<th height="35">
			<div class="px-4" style="font-size:14px">
			<div class="form-check form-check-inline">
 				<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
  				<label class="form-check-label" for="inlineRadio1">앱카드</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
  				<label class="form-check-label" for="inlineRadio2">일반 신용카드(체크카드 포함)</label>
			</div>
			</div>
			</th>
		</tr>
		<tr><td height="100"></td></tr>
		</table>
	</td>
	<td width="30"></td>
	<td>
		<table width="265" height="222">
		<tr>
		<td style="background-color:white">
		
		</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	</div>
	</tr>
	<tr>
		<table border="0" width="700" bgcolor="#EDEBDC">
			<tr height="10"></tr>
			<tr><td width="20"></td>
			<td align="left" style="font-size:11px">* 신용카드 결제 가능 최소 금액은 1,000원 이상입니다.</td></tr>
			<tr><td width="20"></td>
			<td align="left" style="font-size:11px">뭐시기 포인트 적립 뭐시기 캐쉬백 적립</td></tr>
			<tr><td width="20"></td>
			<td align="left" style="font-size:11px">(뭐시기랑 뭐시기는 포인트 중복 적립 불가)</td></tr>
			<tr height="10"></tr>
		</table>
	</tr>
	<tr>
		<table width="700" height="250"><tr height="250"></tr></table>
	</tr>
</table>

</div>
</div>


<table border="0" width="1000" height="120" bgcolor="#282828" style="color:white; font-size:11px;">
	<tr height="10"></tr>
	<tr>
		<td width="10"></td>
		<td width="100" rowspan="6">
			<img src="./img/seat.JPG" width="120px" height="120px" alt=""/>
		</td>
		<td width="100" rowspan="6">
			<img src="./img/thefirstslamdunk.JPG" width="90px" height="120px" alt=""/>
		</td>
		<td width="125"></td>
		<td width="125"></td>
		<td width="120"></td>
		<td width="150" rowspan="6" class="text-center">
			<img src="./img/slash.JPG" width="200px" height="120px" alt=""/>
		</td>
	</tr>
	<tr>
		<td></td>
		<th>더퍼스트슬램덩크</th>
		<th>극장 CGV 건대입구</th>
		<th>좌석명 일반석</th>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<th>일시 얘도 db에서</th>
		<th>좌석번호 DB</th>
	</tr>
	<tr>
		<td></td>
		<th>2D(더빙)</th>
		<th>상영관 4관 4층</th>
	</tr>
	<tr>
		<td></td>
		<th>12세 관람가</th>
		<th>인원 일반 1명</th>
	</tr>
	<tr><td></td><td></td><td></td></tr><tr height="10"></tr>
</table>  
</body>

<footer>
	<%@include file="/footer.jsp"%>
</footer>
</html>