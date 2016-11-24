package ua.nure.noormal.webStore.addLaptop;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.AddLaptop;

public class AddLaptopTest extends AddLaptop { 

	private AddLaptop addLaptop = mock(AddLaptop.class); 
 
	@Test
	public void test() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		
		when(request.getParameter("weight")).thenReturn("1");   
		when(request.getParameter("RAM")).thenReturn("4"); 
		when(request.getParameter("price")).thenReturn("4"); 
		when(request.getParameter("guarantee")).thenReturn("1"); 
		when(request.getParameter("returnAllow")).thenReturn("Да");
		when(request.getParameter("action")).thenReturn("qqq").thenReturn("www");
		when(request.getParameter("id")).thenReturn("1");
		
		addLaptop = new AddLaptop();  
		doGet(request, response);
		doPost(request, response);
	}

}
