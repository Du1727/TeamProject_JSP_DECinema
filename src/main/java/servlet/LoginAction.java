package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberMgr;

@WebServlet("/LoginAction")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberMgr Mgr = new MemberMgr();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String checkbox = request.getParameter("checkId");

		Cookie cookie = new Cookie("userId", id);
		if(id!=null && Mgr.loginMember(id,pw)){
			request.getSession().setAttribute("idKey", id);
			if (checkbox != null) {				
				response.addCookie(cookie);
			} else {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		} else {			
			response.sendRedirect("/project/login.jsp");			
			return;
		}
		response.sendRedirect("/project/index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
