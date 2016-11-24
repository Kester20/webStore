package ua.nure.noormal.webStore.addImageLaptop;

import static org.mockito.Mockito.mock;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.AddImageLaptop;

public class AddImageLaptopTest extends AddImageLaptop { 
	
	private AddImageLaptop addImageLaptop; 
	
	@Test
	public void test() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		
		addImageLaptop = new AddImageLaptop();
		
		/*doGet(request, response);
		doPost(request, response);*/
	}
}
