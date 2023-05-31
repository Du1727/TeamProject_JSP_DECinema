<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
span {
	width: 60px;
	display: inline-block;
}
</style>
</head>
<body>
	<h2>payForm</h2>
	<form action="payProc.jsp" method="post">
	<input name="name" value="홍길동"><br> 
		<span>name:</span><input name="name" value="홍길동"><br> 
		<span>이메일:</span><input name="email" value="simba222@naver.com"><br>
		<span>폰넘버:</span><input name="phone" value="010-3570-6996"><br>
		<span>주소:</span><input name="address" value="부산광역시 연제구 아시아드대로22번길 36 (거제동, 거제푸르지오)"><br>
		<span>총가격:</span><input name="totalPrice" value="100"><br> 
		<input type="submit" value="결제하기"> 
		<input type="reset" value="취소하기">
	</form>
</body>
</html>