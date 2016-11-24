package ua.nure.noormal.webStore.checkboxes;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;

import servlets.Checkboxes;

public class CheckboxesTest extends Checkboxes {

	private Checkboxes checkboxes;

	@Test
	public void testConstructor() throws ServletException, IOException {
		HttpServletRequest request = mock(HttpServletRequest.class);
		HttpServletResponse response = mock(HttpServletResponse.class);
		checkboxes = new Checkboxes();
		checkboxes.destroy();

		when(request.getParameter("prodBox")).thenReturn("1");
		doGet(request, response);
		doPost(request, response);
		updateValuesAmount(new String[] { "0, 500" });
		updateValuesRAM(new String[] { "0, 4" });
		values(new String[] { "0, 4" });
	}

}
