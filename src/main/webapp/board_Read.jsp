<%@page import="board.BoardBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
// 내용 가져오기
int idx = Integer.parseInt(String.valueOf(session.getAttribute("idx")));
BoardBean rBean = bMgr.getOneBoardContent(idx);
String id = String.valueOf(session.getAttribute("idKey"));

String writer_id = bMgr.getBoardWriterId(idx);


String authority = bMgr.checkAuthority(id); // 권한종류 : admin/user 


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
#userfile {
	text-decoration: none;
	color: inherit;
}
</style>

<%@include file="/navbar-white.jsp"%>

<script type="text/javascript">
	function updateBoard(idx) {
		document.readForm.requestStatus.value = "update";
		document.readForm.idx.value = idx;
		document.readForm.action = "board_Proc.jsp";
		document.readForm.submit();
	}

	function deleteBoard(idx) {

		var result = confirm("게시글을 삭제 하시겠습니까?");
		if (result == true) {
			document.readForm.requestStatus.value = "delete";
			document.readForm.idx.value = idx;
			document.readForm.action = "board_Proc.jsp";
			document.readForm.submit();
		}

	}

	function deleteAttachFile(idx) {
		var result = confirm("첨부파일을 삭제 하시겠습니까?");
		if (result == true) {
			document.readForm.requestStatus.value = "deleteAttachFile";
			document.readForm.idx.value = idx;
			document.readForm.action = "board_Proc.jsp";
			document.readForm.submit();
		}
	}

	function boardList() {
		document.readForm.action = "board_List.jsp";
		document.readForm.submit();
	}

	function boardList_B() {
		document.grantCheckForm.action = "board_List.jsp";
		document.grantCheckForm.submit();
	}

	function down(filename) {
		document.downFrm.filename.value = filename;
		document.downFrm.submit();
	}
</script>


</head>


<body>

	<main>
		<div align="center">
			<br/><br/><br/>
			<!-- <h4><B>문의하기</B></h4>
			<br/>
			<hr> -->
		</div>

		<%
		if (rBean.getSecret().equals("0") || id.equals(writer_id) || authority.equals("admin")) {
		%>
	
	
	
			<div align="center">
			
			
	
				<form name="readForm" method="post" style="width: 1200px;">
	<br/>
	
	
	<hr>
					<h4><b>문의하기</b></h4>
					<hr>
					<br/>
					<br/><br/>
					<div class="col-12" style="text-align: left;">
						<label for="title" class="form-label" style="text-align: left;"><img src="img/list_icon.jpg">  <B>제목</B></label>
						<input value="<%=rBean.getSubject()%>" name="subject" type="text" class="form-control" <% if (!id.equals(writer_id)) {%> readonly style="caret-color: transparent ;" <%} %>>
					</div>
					<br />
					<div class="col-12" style="text-align: left;">
						<label for="content" class="form-label"><img src="img/list_icon.jpg">  <B>내용</B></label>
						<% if (!id.equals(writer_id)) {%>
						<textarea name="content" rows="35" cols="50" class="form-control" aria-label="With textarea"  readonly style="caret-color: transparent ; height: 300px;"> <%=rBean.getContent()%> </textarea>							
						<%}else{ %>
						<textarea name="content" rows="35" cols="50" class="form-control" aria-label="With textarea"  style=" height: 300px;"> <%=rBean.getContent()%></textarea>
						<%} %>
					</div>
					<br />
					<div class="form-check" style="text-align: left;">
					&nbsp;&nbsp;&nbsp;
						<% if (rBean.getSecret().equals("1") ) { %>
								<input checked value="1" name="secret" class="form-check-input" type="checkbox" id="secretcheck" <% if (!id.equals(writer_id)) {%> onclick="return false;" <%} %>> 
								<label class="form-check-label" for="flexCheckDefault"><B>비밀글</B></label>
						<%} else {%>
								<input value="1" name="secret" class="form-check-input" type="checkbox" id="secretcheck" <% if (!id.equals(writer_id)) {%> onclick="return false;" <%} %>> 
								<label class="form-check-label" for="flexCheckDefault"><B>비밀글</B></label>
						<%}%>
					</div>
					<br/><br/>
					<div style="text-align: left; width: 1180px;">
						<label for="title" class="form-label"><img src="img/list_icon.jpg">  <B>첨부파일</B></label> <br />
						<%if (rBean.getFilename() != null && !rBean.getFilename().equals("")) {%>
								<%=rBean.getFilename()%>
								&nbsp;  
								<a id="userfile" href="javascript:down('<%=rBean.getFilename()%>')" <% if (!id.equals(writer_id)) {%> onclick="return false;" <%} %>> 
									<img src="img/download_icon.jpg">
								</a> 
								<a href="javascript:deleteAttachFile('<%=idx%>')" <% if (!id.equals(writer_id)) {%> onclick="return false;" <%} %>> 
									<img src="img/delete_icon.jpg">
								</a>
			
	
						<%} else {%>
								<input type="file" name="filename" class="form-control" id="inputGroupFile02" <% if (!id.equals(writer_id)) {%> onclick="return false;" <%} %>> <br />
						<%}%>
					</div>
					<br /> <br /><br /> <br />
	
					<hr>
					<h4><b>답변내용</b></h4>
					<hr>
					<br />
					<div class="col-12" style="text-align: left; width: 1200px;">
						<!-- <label for="content" class="form-label"><B>Answer</B></span></label> -->
	
						<%
						   if (authority.equals("admin")) {
							   
							   if(rBean.getAnswer() == null) { %>
							   
								<textarea name="answer" rows="10" cols="50" class="form-control" aria-label="With textarea" 
								placeholder="답변을 입력해 주세요" style="height: 300px;"></textarea>
								
						   	 <%}else{ %>
						   
								<textarea name="answer" rows="10" cols="50" class="form-control" aria-label="With textarea" 
								placeholder="답변을 입력해 주세요" style="font-weight: bold; height: 300px;"><%=rBean.getAnswer()%></textarea>
								
						   <%} %>
						
	
						<% } else {
								   if(rBean.getAnswer() == null) { %>
										<textarea name="answer" rows="10" cols="50" class="form-control" aria-label="With textarea" 
										readonly  style="caret-color: transparent; color:gray; height: 300px;">답변이 등록되지 않았습니다.</textarea>
								   <%}else{ %>
										<textarea name="answer" rows="10" cols="50" class="form-control" aria-label="With textarea" 
										readonly  style="caret-color: transparent ;font-weight: bold; height: 300px;" ><%=rBean.getAnswer() %></textarea>
								   <%} %>
						
						<% } %>
	
	
					</div>
	
					<br /><br />
	
					<div align="center">
						
						
						<%if (id.equals(writer_id) || authority.equals("admin")) {%> 
							<button onclick="deleteBoard('<%=idx%>')" type="button"
							class="btn btn-outline-dark">삭제</button>
							<button onclick="updateBoard('<%=idx%>')"
							class="btn btn-outline-dark">저장</button>
						<%} %>
						<button onclick="boardList()" type="button" class="btn btn-dark">목록</button>
						
					</div>
					<input type="hidden" name="idKey" value="<%=id%>">
					<input type="hidden" name="idx"> 
					<input type="hidden" name="requestStatus">
	
	
	
	
				</form>
	
	
			</div>
	
			<form method="post" name="downFrm" action="download.jsp">
				<input type="hidden" name="filename">
			</form>





		




		<%
		} else {
		%>
			<form name="grantCheckForm" method="post">
				<br>
				<br> <br>
				<div class="px-4 py-5 my-5 text-center">
					<img class="d-block mx-auto mb-4" src="img/secret_icon.jpg" alt=""
						width="20" height="25">
					<h1 class="display-5 fw-bold">비공개 게시글</h1>
					<div class="col-lg-6 mx-auto">
						<p class="lead mb-4">작성자만 확인이 가능합니다.</p>
						<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
							<!-- <button type="button" class="btn btn-primary btn-lg px-4 gap-3">돌아가기</button> -->
							<button onclick="boardList_B()" type="button"
								class="btn btn-outline-secondary btn-lg px-4">돌아가기</button>
						</div>
					</div>
				</div>
				<br>
				<br>
			</form>
			
		<%
		}
		%>




		<br />
		<br />
		<br />
	</main>

	<br />
	<br />
	<br />
</body>

<footer>
	<%-- <%@include file ="../outer_form/footer.jsp" %> --%>
	<%@include file="/footer.jsp"%>
</footer>
</html>
