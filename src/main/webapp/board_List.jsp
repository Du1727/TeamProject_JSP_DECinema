<%@page import="board.UtilMgr"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
 <jsp:useBean id="bMgr" class="board.BoardMgr" />
 <jsp:useBean id="bBean" class="board.BoardBean" />
 <jsp:setProperty name="bBean" property="*" />

<%
String id = (String) session.getAttribute("idKey");


int totalRecord = 0;
int numPerPage = 10;
int pagePerBlock = 15;
int totalPage = 0;
int totalBlock = 0;
int nowPage = 1;
int nowBlock = 1;

//요청된 numPerPage처리
if (request.getParameter("numPerPage") != null) {
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
}

// 검색에 필요한 변수
String keyField = "", keyWord = "";
if (request.getParameter("keyWord") != null) {
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

// 검색 후에 다시 reset 요청
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyField = "";
	keyWord = "";
}

totalRecord = bMgr.getBoardTotalCount(keyField, keyWord);
/* out.println("####### totalRecord : " + totalRecord); */

if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

// sql문에 들어가는 start, cnt 선언
int start = (nowPage * numPerPage) - numPerPage;
int cnt = numPerPage;

// 전체 페이지 개수
totalPage = (int) Math.ceil((double) totalRecord / numPerPage);

// 전체 블럭 개수
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);

// 현재 블럭 개수
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
/* 
 out.println("totalRecord : " + totalRecord + "<br>");
out.println("numPerPage : " + numPerPage + "<br>");
out.println("pagePerBlock : " + pagePerBlock + "<br>");
out.println("totalPage : " + totalPage + "<br>");
out.println("totalBlock : " + totalBlock + "<br>");
out.println("nowPage : " + nowPage + "<br>");
out.println("nowBlock : " + nowBlock + "<br>"); */
%>



<!DOCTYPE html>
<html>
<head>
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
#sj {
	text-decoration: none;
	color: inherit;
}

#paging {
	text-decoration: none;
	color: inherit;
}

#underline {
	/*  text-decoration-line: underline;
   text-decoration-thickness: 3px; */
	text-decoration: none;
	color: inherit;
}

#no_underline {
	text-decoration: none;
	color: gray;
}
</style>


<script type="text/javascript">
	function read(idx, id) {
		
		document.readFrm.requestStatus.value = "read";
		document.readFrm.idx.value = idx;
		document.readFrm.idKey.value = id;
		document.readFrm.action = "board_Proc.jsp";
		document.readFrm.submit();
	}

	function searchBtn() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}

	function paging(page) {

		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function block(block) {
		document.readFrm.nowPage.value =
<%=pagePerBlock%>
	* (block - 1) + 1;
		document.readFrm.submit();
	}

	function numPerFn(numPerPage) {
		// alert(numPerPage);
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}
	
	function registerCheck(id) {
		
		if(id == 'null') {
			document.sendRegisterBoard.action = "login.jsp";
		}else {
			document.sendRegisterBoard.action = "board_Regist.jsp";
		}
		
		document.sendRegisterBoard.submit();
	}
	
</script>

      <%@include file ="/navbar-white.jsp" %>   

</head>


<body>

<br>
<br>
	<div>
	
	
	<br><br>
		<h2 align = "center"><b>문의 게시판</b></h2>
		
		<br><br>
	<div align="center" >


		<form class="card p-2" name="searchFrm" method="post" style="width:850px; height: 75px; "   >
			
		 <div class="row gy-3"  style="padding: 10px; ">
			&nbsp;&nbsp;&nbsp;
			 <select class="form-select" name="keyField" style="width:100px" >
               <option value="name">작성자</option>
					<option value="subject">제 목</option>
              </select>
              
				&nbsp;
			
				<input type="text" class="form-control" name="keyWord" style="width:600px"
					placeholder="검색어를 입력하세요.">
			&nbsp;&nbsp;
				<button type="button" onClick="javascript:searchBtn()" style="width:80px"
					class="btn btn-secondary">찾기</button>
					
			</div>
		</form>
		</div>
		<br><br>
		<%-- 
		<form  name="searchFrm" method="post">
				<table align="center" width="600" cellpadding="4" cellspacing="0">
			 		<tr>
			  			<td align="center" valign="bottom">
			   				<select name="keyField" size="1" >
			    				<option value="name"> 작성자 </option>
			    				<option value="subject"> 제 목</option>
			    				
			   				</select>
			   				<input size="16" name="keyWord">
			   				<button type="button" onClick="javascript:searchBtn()" class="btn btn-outline-dark">찾기</button>
			   				
			   				
			   				<!-- <input type="hidden" name="nowPage" value="1"> -->
			   				
			   				
			   				<input type="hidden" name="idx">
							
							<input type="hidden" name="nowPage" value="<%=nowPage%>">
							<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
							
			  			</td>
			  			
			 		</tr>
				</table>
		</form> --%>

<div align="center" >
		<table class="table table-hover" style="width:1200px;">
			<thead>
				<tr align="center">
					<th scope="col" width="80px" >번호</th>
					<th scope="col" width="640px">제목</th>
					<th scope="col" width="150px">작성자</th>
					<th scope="col" width="250px">작성일</th>
					<th scope="col" width="80px">조회수</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">

				<%
				Vector<BoardBean> vlist = bMgr.getBoardList(keyField, keyWord, start, cnt);
				for (int i = 0; i < vlist.size(); i++) {
					BoardBean bean = vlist.get(i);
				%>

				<tr>
					<%-- <td scope="row"><b><%=bean.getIdx()%></b></td> --%>
					<td align="center"><b><%=bean.getIdx()%></b></td>
					<td align="left"><a id="sj" href="javascript:read('<%=bean.getIdx()%>','<%=id%>')">
							<%=bean.getSubject()%> <%
 if (bean.getSecret().equals("1")) {
 %> <img src="img/secret_icon.jpg"> <%
 }
 %>
 </a>
					</td>

					<td align="center"><%=bean.getName()%></td>
					<td align="center"><%=bean.getRegdt()%></td>
					<td align="center"><%=bean.getCount()%></td>
				</tr>

				<%
				}
				%>
			</tbody>

		</table>
</div>
<div  align="center">
		<table>
			<tr>
				<td>
					<!-- 이전블럭 --> <%
 if (nowBlock > 1) {
 %> <a href="javascript:block('<%=nowBlock - 1%>')">prev...</a> <%
 }
 %> <!-- 페	이징 --> <%
 int pageStart = (nowBlock - 1) * pagePerBlock + 1;
 int pageEnd = (pageStart + pagePerBlock) < totalPage ? pageStart + pagePerBlock : totalPage + 1;
 for (; pageStart < pageEnd; pageStart++) {
 %> <a href="javascript:paging('<%=pageStart%>')" id="paging"> <%
 if (nowPage == pageStart) {
 %> <font size="5px" id="underline"> <%
 } else {
 %> <font size="5px" id="no_underline"> <%
 }
 %><%=pageStart%> <%
 if (nowPage == pageStart) {
 %>
						</font> <%
 } else {
 %>
					</font> <%
 }
 %>
				</a> <%
 }
 %> <!-- 다음블럭 --> <%
 if (totalBlock > nowBlock) {
 %> <a href="javascript:block('<%=nowBlock + 1%>')">...next</a> <%
 }
 %>
				</td>

			</tr>
		</table>
		</div>
		<br>
		
	 <div align="center">
	 
		
		<!-- 
		<form action="board_Regist.jsp" >
			
			<table style="width:1200px;">
		<tr align="right"> 
		<td>
	
					<button type="submit" class="btn btn-secondary">글쓰기</button> <a href="javascript:list()">[처음으로]</a>
					</td>
					</tr>
			 </table>
		</form> -->
		
		
		
		<form name="sendRegisterBoard" >
			
			<table style="width:1200px;">
		<tr align="right"> 
		<td>
	
					<button onclick="javascript:registerCheck('<%=id%>')" class="btn btn-secondary">글쓰기</button> <!-- <a href="javascript:list()">[처음으로]</a> -->
					</td>
					</tr>
			 </table>
		</form>
</div>
<br><br><br>
		<form name="readFrm" method="post">
			<input type="hidden" name="idx"> 
			<input type="hidden" name="idKey"> 
			<input type="hidden" name="requestStatus">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> <input
				type="hidden" name="numPerPage" value="<%=numPerPage%>"> <input
				type="hidden" name="keyField" value="<%=keyField%>"> <input
				type="hidden" name="keyWord" value="<%=keyWord%>">

		</form>
	</div>
</body>

   
       
        <%-- <%@include file ="../outer_form/footer.jsp" %> --%>
<%@include file="footer.jsp"%>
         
       