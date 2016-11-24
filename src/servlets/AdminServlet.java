package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import dao.AdminDao;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(AdminServlet.class);
	private static final long serialVersionUID = 1L;
	private AdminDao adminDao;
	private String login = "";
	private String pass = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		adminDao = new AdminDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start get method of AdminServlet");
		try {
			check(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start post method of AdminServlet");

		login = request.getParameter("login");
		pass = request.getParameter("pass");
		response.sendRedirect("AdminServlet");

	}

	private boolean check(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		HttpSession session = request.getSession();

		if (adminDao != null) {
			if (adminDao.getLogin().equals(login) & adminDao.getPass().equals(pass)) {

				session.setAttribute("admin", login);
				request.getRequestDispatcher("adminMenu.jsp").forward(request, response);
				return true;
			}
		}

		request.setAttribute("error", "!");
		request.getRequestDispatcher("admin.jsp").forward(request, response);
		return false;
	}
}
