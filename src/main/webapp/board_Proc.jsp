<%@page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="bBean" class="board.BoardBean" />
<jsp:setProperty name="bBean" property="*" />

<%
	//String id = (String)session.getAttribute("id");
	//if(id == null){
	//	response.sendRedirect("login.jsp");
		
	//}	


	String msg = "";
	String url = "";

	String requestStatus = (String)request.getParameter("requestStatus");

	String id = (String)request.getParameter("idKey");
	
	
	System.out.println("### id  : " + id);
	
	//비밀글을 체크를 안 한 경우
	if(bBean.getSecret()==null) bBean.setSecret("0");
	
	
	if(requestStatus.equals("read")){
		
		//System.out.println("read들어옴 !! -> Mgr :: read");
		
		
		url = "board_Read.jsp";
	
	}else if(requestStatus.equals("insert")){
		System.out.println("insert들어 올 필요 없는데..");
		 
		//boolean flag = bMgr.insertBord(bBean);
		
		// 문의게시글 등록
		//if(flag) msg = "문의글 등록이 완료되었습니다.";
		//else msg = "문의글 등록 오류";
		
		//url = "boardList.jsp";
		url = "BoardServlet";
		
	}else if(requestStatus.equals("update")){
	//	System.out.println("update들어옴 !! -> Mgr :: update");
		
		
		
		//게시글 수정
		boolean flag = bMgr.updateBord(bBean, bBean.getIdx());
		
		if(flag) msg = "문의글 수정이 완료되었습니다.";
		else msg = "문의글 수정 오류";
		
		url = "board_Read.jsp";
	}else if(requestStatus.equals("delete")){
	//	System.out.println("delete들어옴 !! -> Mgr :: delete");
		
		
		
		//게시글 수정
		boolean flag = bMgr.deleteBord(bBean, bBean.getIdx());
		
		if(flag) msg = "문의글 삭제가 완료되었습니다.";
		else msg = "문의글 삭제 오류";
		
		url = "board_List.jsp";
	}else if(requestStatus.equals("deleteAttachFile")){
	//	System.out.println("delete들어옴 !! -> Mgr :: delete");
		
		
		
		//게시글 수정
		boolean flag = bMgr.deleteAttachFile(bBean, bBean.getIdx());
		
		if(flag) msg = "첨부파일 삭제가 완료되었습니다.";
		else msg = "첨부파일 삭제 오류";
		
		url = "board_Read.jsp";
	}else if(requestStatus.equals("search")){
	//	System.out.println("search들어옴 !! -> Mgr :: search");
		
	//	System.out.println("@@");
		msg = "";
		
		url = "board_List.jsp";
	}

	
	session.setAttribute("idx", bBean.getIdx());
	session.setAttribute("id", id);
%>
<script>
	<% if(!msg.equals("")) { %> alert("<%=msg%>"); <%}%>
	location.href = "<%=url%>";
</script>

