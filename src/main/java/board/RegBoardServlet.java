package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/regBoardServlet")
public class RegBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	BoardMgr bMgr = new BoardMgr();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean flag = bMgr.insertBoard(request);
		if(flag)		 System.out.println("등록 완료 ");
		else 	 System.out.println("등록 실패 ");
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("board_List.jsp");
		requestDispatcher.forward(request, response);
		
	}
	
}