<!-- -->
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id = "mgr" class = "member.MemberMgr"/>
<jsp:useBean id = "bean" class = "member.MemberBean"/>
<jsp:setProperty property = "*" name = "bean"/>
<%
	request.setCharacterEncoding("UTF-8");
	mgr.insertMember(bean);
%>
<script>	
	location.href = "register3.jsp";
</script>