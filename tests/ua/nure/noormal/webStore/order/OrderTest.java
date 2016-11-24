package ua.nure.noormal.webStore.order;

import static org.mockito.Mockito.mock;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.OrderServlet;

public class OrderTest extends OrderServlet{

	@Test
	public void testConstructor() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		OrderTest orderTest = new OrderTest();
		
		doGet(request, response);
	}

}
