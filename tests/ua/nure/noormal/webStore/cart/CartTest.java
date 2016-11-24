package ua.nure.noormal.webStore.cart;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.Test;

import servlets.AddLaptop;
import servlets.CartServlet;

public class CartTest extends CartServlet  {

	private CartServlet cart = mock(CartServlet.class); 

	@Test
	public void testConstructor() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		HttpSession session = mock(HttpSession.class);
		
		cart = new CartServlet();
		cart.destroy();
		
		//doPost(request, response);
	}

}
