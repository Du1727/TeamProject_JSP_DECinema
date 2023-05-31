package store;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/RegProductServlet")
public class RegProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	storeMgr Mgr = new storeMgr();
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean flag = Mgr.insertProduct(request);
		if(flag)		 System.out.println("등록 완료 ");
		else 	 System.out.println("등록 실패 ");
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("store_insert.jsp");
		requestDispatcher.forward(request, response);
	
				
		
		
	}
	
}