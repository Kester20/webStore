package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import dao.WishListDao;

/**
 * Servlet implementation class WishListServlet
 */
@WebServlet("/WishListServlet")
public class WishListServlet extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(WishListServlet.class);
	private WishListDao wishListDao;
	private static final long serialVersionUID = 1L;
	private String action;
	private int idClient;
	private int idLaptop;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WishListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		wishListDao = new WishListDao();
	}



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if (action.equals("addToWish")) {
			
			wishListDao.addToWish(idClient, idLaptop);
			response.sendRedirect("laptop.jsp?id=" + idLaptop);
		} else if (action.equals("deleteFromWish")) {
			
			wishListDao.deleteFromWish(idClient, idLaptop);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		action = request.getParameter("action");
		idLaptop = Integer.parseInt(request.getParameter("idLaptop"));
		String id = request.getParameter("idClient");
		if (id == "") {
			response.sendRedirect("laptop.jsp?id=" + idLaptop + "#logIn");
			return;
		} else {
			idClient = Integer.parseInt(id);
		}
		response.sendRedirect("WishListServlet");
	}

}
