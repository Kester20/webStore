package ua.nure.noormal.webStore.admin;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.AddLaptop;
import servlets.AdminServlet; 

public class AdminTest extends AdminServlet{

	private AdminServlet admin = mock(AdminServlet.class); 

	@Test
	public void test() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class); 
		admin = new AdminServlet();
		
		when(request.getParameter("action")).thenReturn("publish");
		when(request.getParameter("action")).thenReturn("lock");
		when(request.getParameter("idLaptop")).thenReturn("10");  
		when(request.getParameter("id")).thenReturn("10");  
		/*doGet(request, response);*/
		doPost(request, response);
	}

}
