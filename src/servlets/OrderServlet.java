package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import dao.OrderDao;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OrderServlet.class);
	private OrderDao orderDao;
	private String action;
	private String status;
	private int idOrder;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		orderDao = new OrderDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start get method of OrderServlet");
		if (action.equals("updateStatusOrder")) {

			try {
				updateStatusOrder(status, idOrder);
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start post method of OrderServlet");
		action = request.getParameter("action");
		if (action != null) {
			if (action.equals("updateStatusOrder")) {

				status = request.getParameter("status");
				idOrder = Integer.parseInt(request.getParameter("id"));
				response.sendRedirect("OrderServlet");
			}
		} else {

			HttpSession session = request.getSession();
			Double cost = Double.parseDouble(request.getParameter("cost"));
			String typePayment = request.getParameter("typePayment");
			String typeReceipt = request.getParameter("typeReceipt");
			int idClient = Integer.parseInt(request.getParameter("id"));

			HashMap<Integer, Integer> list = new HashMap<>();
			String lists[] = request.getParameter("list").split(",");
			lists[0] = removeScobaFirst(lists[0]);
			lists[lists.length - 1] = removeScobaLast(lists[lists.length - 1]);

			for (int i = 0; i < lists.length; i++) {
				lists[i] = lists[i].trim();
			}

			for (int i = 0; i < lists.length; i++) {
				String pair = lists[i];
				String[] keyValue = pair.split("=");
				list.put(Integer.parseInt(keyValue[0]), Integer.parseInt(keyValue[1]));
			}

			orderDao.addOrder(cost, typePayment, typeReceipt, idClient, list);
			session.setAttribute("list", null);
			response.sendRedirect("doneOrder.jsp");
		}

	}

	/**
	 * @param status
	 * @param idOrder
	 * @return
	 * @throws SQLException
	 */
	private boolean updateStatusOrder(String status, int idOrder) throws SQLException {

		return orderDao.updateStatusOrder(status, idOrder);
	}

	/**
	 * Метод удаляет лишнюю скобку из строки
	 * 
	 * @param s
	 * @return
	 */
	private String removeScobaLast(String s) {

		StringBuilder result = new StringBuilder(s);
		result.deleteCharAt(result.length() - 1);

		return result.toString();
	}

	/**
	 * Метод удаляет лишнюю скобку из строки
	 * 
	 * @param s
	 * @return
	 */
	private String removeScobaFirst(String s) {

		StringBuilder result = new StringBuilder(s);
		result.deleteCharAt(0);

		return result.toString();
	}
}
