<%@page contentType="text/html; charset=UTF-8"%>
<%
	String id = (String) session.getAttribute("idKey");
    System.out.println("[registerBoard.jsp]  ###### idKey : " + id) ;

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>문의하기</title>
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<style>
	
html{
     /* 드래그 방지 */
     -ms-user-select: none;
     -moz-user-select: -moz-none;
     -webkit-user-select: none;
     -khtml-user-select: none;
     user-select: none;
}
	</style>
	
<%@include file="/navbar-white.jsp"%>



<script type="text/javascript">
	function cancleButton() {
		document.regForm.action = "board_List.jsp";
		document.regForm.submit();
	}
</script>


</head>



<body>
	<main>
		<div align="center">
			<br/><br/><br/>
			<h4>문의 등록</h4>
			<br/>
			<hr>
		</div>

		<div align="center">
			<form name="regForm" method="post" action="regBoardServlet"
				enctype="multipart/form-data">
<br/>
				<div class="col-12" style="text-align: left; width: 1200px;">
					<label for="title" class="form-label"><img src="img/list_icon.jpg">  <B>제목*</B></label> <input
						name="subject" type="text" class="form-control" id="title"
						placeholder="제목을 입력해 주세요" required>

				</div>
				<br />
				<div class="col-12" style="text-align: left; width: 1200px;">
					<label for="content" class="form-label"><img src="img/list_icon.jpg">  <B>내용*</B></span></label>
					<textarea name="content" rows="35" cols="50" class="form-control"
						aria-label="With textarea" placeholder="내용을 입력해 주세요" required style="height: 300px;"></textarea>

				</div>
				<br />

				<div class="form-check" style="text-align: left; width: 1200px;">
				&nbsp;&nbsp;&nbsp;
					<input name="secret" class="form-check-input" type="checkbox"
						value="1" id="secretCheck"> <label
						class="form-check-label" for="flexCheckDefault"> <B>비밀글</B>
					</label>
				</div>
				<br /> <br />
				<div style="text-align: left; width: 1180px;">
				
					<label for="title" class="form-label"><img src="img/list_icon.jpg">  <B>첨부파일</B></label> <br /> <input
						type="file" name="filename" class="form-control"
						id="inputGroupFile02">

				</div>
				<br /><br /><br />



				<div align="center">
					<input type="hidden" name="idKey" value="<%=id%>">
					<input type="hidden" name="requestStatus" value="insert">

					<button type="button" onClick="cancleButton()"
						class="btn btn-outline-dark">취소</button>
					<button type="submit" class="btn btn-dark">등록</button>

				</div>
				
				<br /><br />
				
			</form>
		</div>

		<br>
		<br>
		<br>




	</main>
</body>

<footer>
	<%-- <%@include file ="../outer_form/footer.jsp" %> --%>
	<%@include file="/footer.jsp"%>
</footer>
</html>
