package servlets;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import dao.BlackListDao;
import dao.ClientDao;
import dao.OrderDao;
import mail.Mail;

/**
 * Servlet implementation class ClientServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(ClientServlet.class);
	private static final long serialVersionUID = 1L;
	private ClientDao clientDao;
	private OrderDao orderDao;
	private String name, login, email, town, street, house, password;
	private Long phone;
	private String action;
	private int idClient;
	private String date;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ClientServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {
		clientDao = new ClientDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		LOG.info("Start get method of ClientServlet");
		if (action != null) {
			switch (action) {
			case "logIn": {

				logIn(request, response);
				break;
			}

			case "toOrder": {

				toOrder(request, response);
				break;
			}

			case "logOut": {

				logOut(request, response);
				break;
			}

			case "deleteOrder": {
				
				orderDao = new OrderDao();
				orderDao.deleteOrder(idClient, date);
				response.sendRedirect("clientMenu.jsp#orderList");
				break;
			}

			default:
				break;
			}
		} else {
			registr();
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		LOG.info("Start post method of ClientServlet");
		action = request.getParameter("action");

		if (action != null) {

			if (action.equals("update")) {

				String value = request.getParameter("value");
				String variable = request.getParameter("variable");
				int id = Integer.parseInt(request.getParameter("id"));

				clientDao.updateValue(value, variable, id);
				Mail.send(clientDao.getMail(id), "info");
				response.setContentType("text/html;charset=UTF-8");
				response.sendRedirect("clientMenu.jsp");

			} else if (action.equals("deleteOrder")) {

				idClient = Integer.parseInt(request.getParameter("idClient"));
				date = request.getParameter("date");
				response.sendRedirect("ClientServlet");
			}

			else {

				login = request.getParameter("login");
				password = request.getParameter("pass");

				response.sendRedirect("ClientServlet");
			}
		} else {
			login = request.getParameter("login");

			if (clientDao.getLogin(login)) {
				response.getOutputStream().print(true);
				return;
			} else {
				response.getOutputStream().print(false);
			}

			name = request.getParameter("name");
			email = request.getParameter("mail");
			town = request.getParameter("town");
			street = request.getParameter("street");
			house = request.getParameter("house");
			phone = 0L;
			if (request.getParameter("phone") != null) {
				phone = Long.parseLong(request.getParameter("phone"));
			}
			password = request.getParameter("pass");

			response.sendRedirect("ClientServlet");
		}

	}

	private void logIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			if (BlackListDao.checkBlackList(login)) {
				response.sendRedirect("index.jsp#blackListMessage");
			} else {
				if (clientDao.logIn(login, password)) {
					HttpSession session = request.getSession();
					session.setAttribute("client", login);
					session.setAttribute("clientId", clientDao.getIdClient(login));
					request.getRequestDispatcher("clientMenu.jsp").forward(request, response);

				} else {
					response.sendRedirect(request.getHeader("referer") + "#logIn");
				}
			}
		} catch (NoSuchAlgorithmException e) {
			LOG.error("ERROR");
		}
	}

	private void registr() {
		try {
			if (name != null & email != null & town != null & street != null & house != null & phone != null
					& password != null) {

				clientDao.addClient(name, login, email, town, street, house, phone, password);
				Mail.send(email, "registr");
			}
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {

			LOG.error("ERROR");
		}
	}

	private void toOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			if (BlackListDao.checkBlackList(login)) {
				response.sendRedirect("index.jsp#blackListMessage");
			} else {
				if (clientDao.logIn(login, password)) {
					HttpSession session = request.getSession();
					session.setAttribute("client", login);
					session.setAttribute("clientId", clientDao.getIdClient(login));
					request.getRequestDispatcher("clientMenu.jsp?goToOrder=true").forward(request, response);

				}
			}
		} catch (NoSuchAlgorithmException e) {
			LOG.error("ERROR");
		}
	}

	private void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("client", null);
		session.setAttribute("clientId", null);
		request.getRequestDispatcher("index.jsp").forward(request, response);

	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

}
