package servlets;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;



/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(CartServlet.class);
	private static final long serialVersionUID = 1L;
	private HashMap<Integer,Integer> list;
	private int id;
	private String action = "";
	private String loginClient;
	private int cost;
	private int quantity;
	private int idLaptop;
	private int value;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/** 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		LOG.info("Start get method of CartServlet");
		
		if(action != null){			
			if(action.equals("delete")){
				
				delete(request, response, id);
				return;
			}else if(action.equals("setCostToSession")){
				
				setCostToSession(request, response, cost,quantity);
				response.sendRedirect("order.jsp");
				return;
			}else if(action.equals("setKeyValue")){
				
				setKeyValue(request, response, idLaptop, value);
				return;
			}
		}
		
		HttpSession session = request.getSession();

		list = (HashMap<Integer,Integer>) session.getAttribute("list");
 
		if (list == null) {
			list = new HashMap<>();
		}

		response.setContentType("text/html;charset=UTF-8");
		if (!list.containsKey(id)) {
			list.put(id, 1);
		}

		session.setAttribute("list", list);
		response.getOutputStream().print("#cart");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		LOG.info("Start post method of CartServlet");
		action = request.getParameter("action");

		if (action != null) {
			if(action.equals("delete")){
				id = Integer.parseInt(request.getParameter("id"));
				response.sendRedirect("CartServlet");
				
				
			}else if(action.equals("setCostToSession")){
				
				HttpSession session = request.getSession();
				loginClient = (String) session.getAttribute("client");
				if(loginClient == null){
					response.sendRedirect("laptops.jsp?nextPage=laptop.jsp?id=#logInToOrder");
				}else{
					
					cost = Integer.parseInt(request.getParameter("cost"));
					quantity = Integer.parseInt(request.getParameter("quantity"));
					response.sendRedirect("CartServlet");
				}
			}else if(action.equals("setKeyValue")){
				 idLaptop = Integer.parseInt(request.getParameter("idLaptop"));
				value = Integer.parseInt(request.getParameter("value"));
				
				response.sendRedirect("CartServlet");
				
			}
		} else {			
			id = Integer.parseInt(request.getParameter("id"));
			response.sendRedirect("CartServlet");
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response, int id)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		list = (HashMap<Integer,Integer>) session.getAttribute("list");

		if (list == null) {
			return;
		}

		response.setContentType("text/html;charset=UTF-8");
		if(list.containsKey(id)){
			list.remove(id);
		}

		session.setAttribute("list", list);
	}
	
	private void setCostToSession(HttpServletRequest request, HttpServletResponse response, int cost, int quantity){
		
		HttpSession session = request.getSession();
		session.setAttribute("cost", cost);
		session.setAttribute("quantity", quantity);
	}
	
	private void setKeyValue(HttpServletRequest request, HttpServletResponse response, int idLaptop, int value)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		list = (HashMap<Integer,Integer>) session.getAttribute("list");

		if (list == null) {
			return;
		}

		response.setContentType("text/html;charset=UTF-8");
		list.put(idLaptop, value);

		session.setAttribute("list", list);
	}
}
