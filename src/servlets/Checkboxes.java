package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Servlet implementation class Checkboxes
 */
@WebServlet("/Checkboxes")
public class Checkboxes extends HttpServlet {

	private static final Logger LOG = Logger.getLogger(Checkboxes.class);
	private static final long serialVersionUID = 1L;

	private String selectProd[];
	private String selectCPU[];
	private String[] selectRAM;
	private String selectVideoCard[];
	private String selectAmount[];
	private String selectPrice;
	private String selectAmountPriceFirst;
	private String selectAmountPriceSecond;
	private String nextPage;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Checkboxes() {
		super();

	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start get method of CheckboxesServlet");
		this.work(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		LOG.info("Start post method of CheckboxesServlet");

		selectProd = request.getParameterValues("prodBox");
		selectCPU = request.getParameterValues("CPUBox");
		selectRAM = request.getParameterValues("RAMBox");
		selectVideoCard = request.getParameterValues("videoCardBox");
		selectAmount = request.getParameterValues("amountHardDriveBox");
		selectPrice = request.getParameter("expen");
		selectAmountPriceFirst = request.getParameter("amount");
		selectAmountPriceSecond = request.getParameter("amount1");
		nextPage = request.getParameter("nextPage");

		response.sendRedirect("Checkboxes");
	}

	/**
	 * Метод формрует запрос по фильтрам
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void work(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean prod = false, CPU = false, RAM = false, videoC = false, amountHard = false;
		// StringBuilder query = new StringBuilder("select * from laptop ");
		StringBuilder query = new StringBuilder(
				"SELECT laptop.id,producer.producer,CPU.CPU,laptop.screen, screenResolution.screenRes,laptop.RAM,laptop.amountHardDrive,laptop.color,laptop.weight, videoCard.video,laptop.guarantee,laptop.price,laptop.image,laptop.model FROM `laptop` INNER JOIN producer ON laptop.producer = producer.id INNER JOIN CPU ON laptop.CPU = CPU.id INNER JOIN screenResolution ON laptop.screenResolution = screenResolution.id INNER JOIN videoCard ON laptop.videoCard = videoCard.id");

		// 1 этап
		if (selectProd != null && selectProd.length != 0) {
			prod = true;
		}
		if (selectCPU != null && selectCPU.length != 0) {
			CPU = true;
		}
		if (selectRAM != null && selectRAM.length != 0) {
			RAM = true;
		}
		if (selectVideoCard != null && selectVideoCard.length != 0) {
			videoC = true;
		}
		if (selectAmount != null && selectAmount.length != 0) {
			amountHard = true;
		}

		query.append(" WHERE (");
		// }

		// 2 этап
		if (prod) {
			query.append(" producer.producer ");
			if (selectProd.length > 1) {

				for (String string : selectProd) {
					query.append("= '" + string + "' or producer.producer ");
				}
			} else {
				for (String string : selectProd) {
					query.append("= '" + string + "' ");
				}
			}

			query.append(" ) ");
		}

		if (CPU) {
			if (prod) {
				query.append(" AND (");
			}
			query.append(" CPU.CPU ");
			if (selectCPU.length > 1) {
				for (String string : selectCPU) {
					query.append("= '" + string + "' or CPU.CPU ");
				}
			} else {
				for (String string : selectCPU) {
					query.append("= '" + string + "' ");
				}
			}

			query.append(" ) ");
		}

		if (RAM) {
			if (prod || CPU) {
				query.append(" AND (");
			}
			query.append(" laptop.RAM ");

			for (int i = 0; i < selectRAM.length; i++) {
				String str[] = selectRAM[i].split(",");
				query.append("BETWEEN " + str[0] + " and " + str[1] + " or laptop.RAM ");
			}
			query.delete(query.length() - 15, query.length());

			query.append(" ) ");
		}

		if (videoC)

		{
			if (prod || CPU || RAM) {
				query.append(" AND (");
			}
			query.append(" videoCard.video ");
			if (selectVideoCard.length > 1) {
				for (String string : selectVideoCard) {
					query.append("= '" + string + "' or videoCard.video ");
				}
			} else {
				for (String string : selectVideoCard) {
					query.append("= '" + string + "' ");
				}
			}

			query.append(" ) ");
		}

		if (amountHard) {
			if (prod || CPU || RAM || videoC) {
				query.append(" AND (");
			}
			query.append(" laptop.amountHardDrive ");
			for (int i = 0; i < selectAmount.length; i++) {
				String str[] = selectAmount[i].split(",");
				query.append("BETWEEN " + str[0] + " and " + str[1] + " or laptop.amountHardDrive ");
			}
			query.delete(query.length() - 27, query.length());

			query.append(" ) ");
		}

		if (prod || CPU || RAM || videoC || amountHard) {
			query.append(" AND (");
		}
		query.append(
				" laptop.price >= " + selectAmountPriceFirst + " AND laptop.price <= " + selectAmountPriceSecond + ")");

		if (selectPrice != null && selectPrice.length() != 0) {
			if (selectPrice.equals("less")) {
				query.append(" order by laptop.price ;");
			} else if (selectPrice.equals(">")) {
				query.append(" order by laptop.price DESC ;");
			}
		}

		if (prod || CPU || RAM || videoC || amountHard) {

			StringBuilder att = new StringBuilder();
			if (prod) {
				att.append(" | " + values(selectProd));
			}
			if (CPU) {
				att.append(" | " + values(selectCPU));
			}

			if (RAM) {
				att.append(" | " + updateValuesRAM(selectRAM));
			}

			if (videoC) {
				att.append(" | " + values(selectVideoCard));
			}
			if (amountHard) {
				att.append(" | " + updateValuesAmount(selectAmount));
			}
			request.setAttribute("f",  att.toString());
		}
		request.setAttribute("query", query.toString());
		RequestDispatcher d = request.getRequestDispatcher("laptops.jsp?nextPage=" + nextPage);
		if (d != null) {
			d.forward(request, response);
		}
	}

	/**Мето возвращает значения массива в ввиде строки
	 * @param mas
	 * @return
	 */
	public String values(String[] mas) {

		StringBuilder result = new StringBuilder("");
		if (mas != null) {

			for (String string : mas) {
				result.append(string + ", ");
			}
			result.deleteCharAt(result.length() - 2);
		}

		return result.toString();
	}

	/**Метод преобразует значения массива
	 * @param mas
	 * @return
	 */
	public String updateValuesRAM(String[] mas) {

		StringBuilder result = new StringBuilder("");
		if (mas != null) {

			for (String string : mas) {
				if (string.equals("0, 4")) {
					result.append("< 4 GB" + ", ");
				}
				if (string.equals("4, 6")) {
					result.append("4-6 GB" + ", ");
				}
				if (string.equals("8,10")) {
					result.append("8-10 GB" + ", ");
				}
				if (string.equals("12,192")) {
					result.append("> 12 GB" + ", ");
				}
			}
			result.deleteCharAt(result.length() - 2);
		}

		return result.toString();
	}

	/**Метод преобразует значения массива
	 * @param mas
	 * @return
	 */
	public String updateValuesAmount(String[] mas) {

		StringBuilder result = new StringBuilder("");
		if (mas != null) {

			for (String string : mas) {
				if (string.equals("0, 500")) {
					result.append("< 500 GB" + ", ");
				}
				if (string.equals("500, 750")) {
					result.append("500-750 GB" + ", ");
				}
				if (string.equals("1000, 2000")) {
					result.append("1-2 TB" + ", ");
				}
				if (string.equals("2000, 10000")) {
					result.append("> 2 TB" + ", ");
				}
			}
			result.deleteCharAt(result.length() - 2);
		}

		return result.toString();
	}
}
