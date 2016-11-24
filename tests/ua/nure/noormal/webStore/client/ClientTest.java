package ua.nure.noormal.webStore.client;

import static org.mockito.Mockito.mock;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.ClientServlet;
import servlets.CommentServlet;

public class ClientTest extends ClientServlet{
	
	private ClientServlet client;
	private CommentServlet commentServlet;
	private HttpServletRequest request;
	private HttpServletResponse response;

	@Test
	public void testConstructor() throws ServletException, IOException, SQLException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		
		client = new ClientServlet();
		client.getAction();
		client.setAction("action");
		client.destroy(); 
		doGet(request, response);

	}

}
