package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import dao.CommentDao;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	
	private static final Logger LOG = Logger.getLogger(CommentServlet.class);
	private static final long serialVersionUID = 1L;
	private CommentDao commentDao;
	private String action;
	private int idLaptop;
	private String loginClient;
	private int idClient;
	private String date;
	private String text;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		commentDao = new CommentDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (action != null) {
			if (action.equals("publish") || action.equals("hide") || action.equals("delete")) {

				if (loginClient != null && date != null) {
					commentDao.actionComment(action, idLaptop, loginClient, date);
					LOG.info("comment action = " + action + ", idLaptop = "
					+ idLaptop + ", loginClient = " + loginClient);
				}
			}else if(action.equals("addComment")){
				
				commentDao.addComment(idClient, idLaptop, text);
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
		idLaptop = Integer.parseInt(request.getParameter("idLaptop"));
		loginClient = request.getParameter("loginClient");
		date = request.getParameter("date");
		text = request.getParameter("text");
		String id = request.getParameter("idClient");
		if(id != null){			
			idClient = Integer.parseInt(id);
		}
		response.sendRedirect("CommentServlet");
	}

}
