package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import dao.BlackListDao;

/**
 * Servlet implementation class BlackListServlet
 */
@WebServlet("/BlackListServlet")
public class BlackListServlet extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(BlackListServlet.class);
	private static final long serialVersionUID = 1L;
	private BlackListDao blackListDao;
	private String action;
	private int idClient;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BlackListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {

		super.init();
		LOG.info("BlackList servlet init");
		blackListDao = new BlackListDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (action != null) {
			if (action.equals("lock")) {
				
				blackListDao.lockClient(idClient);
				LOG.info("lock client with id = " + idClient);
			} else if (action.equals("unlock")) {
				
				blackListDao.unlockClient(idClient);
				LOG.info("unlock client with id = " + idClient);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		action = request.getParameter("action");
		idClient = Integer.parseInt(request.getParameter("id"));
		response.sendRedirect("BlackListServlet");
	}

}
