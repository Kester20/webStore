package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import dao.LaptopDao;

/**
 * Servlet implementation class AddLaptop
 */
@WebServlet("/AddLaptop")
@MultipartConfig(maxFileSize = 16177215)
public class AddLaptop extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(AddLaptop.class);
	private static final long serialVersionUID = 1L;
	private LaptopDao laptopDao;
	private String action;
	private String producer;
	private String CPU;
	private String RAM;
	private String screen;
	private String screenResol;
	private String amountHardDrive;
	private String color;
	private int weight;
	private String videoCard;
	private int guarantee;
	private int price;
	private String model;
	private int id;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddLaptop() {
		super();
	}

	@Override
	public void init() throws ServletException {
		laptopDao = new LaptopDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start get method of AddLaptopServlet");

		if (action != null) {

			if (action.equals("update")) {
				laptopDao.update(id, producer, CPU, screen, screenResol, RAM, amountHardDrive, color, weight, videoCard,
						guarantee, price, model);

				response.sendRedirect("laptops.jsp?nextPage=updateLaptop.jsp?id=");
				action = null;
			}

			/*
			 * else if (action.equals("delete")) {
			 * 
			 * 
			 * }
			 */

			else if (action.equals("add")) {

				laptopDao.addLaptop(producer, CPU, screen, screenResol, RAM, amountHardDrive, color, weight, videoCard,
						guarantee, price, model);
				response.sendRedirect("loadImageLaptop.jsp");
				action = null;
			}
		} else {
			action = request.getParameter("action");
			id = Integer.parseInt(request.getParameter("id"));
			laptopDao.deleteLaptop(id);
			request.getRequestDispatcher("laptops.jsp?action=delete").forward(request, response);
			action = null;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start post method of AddLaptopServlet");
		action = request.getParameter("action");

		producer = request.getParameter("producer");
		CPU = request.getParameter("CPU");
		RAM = request.getParameter("RAM");
		screen = request.getParameter("screen");
		screenResol = request.getParameter("screenResolution");
		amountHardDrive = request.getParameter("amountHardDrive");
		color = request.getParameter("color");
		weight = Integer.parseInt(request.getParameter("weight"));
		videoCard = request.getParameter("videoCard");
		guarantee = Integer.parseInt(request.getParameter("guarantee"));
		price = Integer.parseInt(request.getParameter("price"));
		model = request.getParameter("model");

		if (action != null) {
			if (action.equals("update")) {

				id = Integer.parseInt(request.getParameter("id"));
			}
		}
		response.sendRedirect("AddLaptop");
	}

	public LaptopDao getLaptopDao() {
		return laptopDao;
	}

}
