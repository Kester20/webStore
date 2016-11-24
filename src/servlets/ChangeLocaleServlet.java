package servlets;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
/**
 * Servlet implementation class ChangeLocaleServlet
 */
@WebServlet("/ChangeLocaleServlet")
public class ChangeLocaleServlet extends HttpServlet {
	private static final Logger LOG = Logger.getLogger(ChangeLocaleServlet.class);
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangeLocaleServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		LOG.info("Start get method of ChangeLocaleServlet");
		
		String[] planguage = request.getParameter("language").split("_");
		String language = planguage[0];
		String country = planguage[1];
		Locale locale = new Locale(language, country);

		HttpSession session = request.getSession();

		session.setAttribute("country", locale.getDisplayCountry());
		session.setAttribute("language", request.getParameter("language"));
		
		
		
		LOG.info("End get method of ChangeLocaleServlet");
		response.getOutputStream().print(request.getHeader("referer"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
