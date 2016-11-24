package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import dao.LaptopDao;



/**
 * Servlet implementation class AddImageLaptop
 */
@WebServlet("/AddImageLaptop")
public class AddImageLaptop extends HttpServlet {
	
	private static final Logger LOG = Logger.getLogger(AddImageLaptop.class);
	private static final long serialVersionUID = 1L;
	private LaptopDao laptopDao;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddImageLaptop() {
        super();
    }
    
    

	@Override
	public void init() throws ServletException {
		laptopDao = new LaptopDao();
	}
 
 

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LOG.info("Start get method of AddImageServlet");
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LOG.info("Start post method of AddImageServlet");
		try {
			loadImage(request, response);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

	public void loadImage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		PrintWriter out = response.getWriter();

		if (!ServletFileUpload.isMultipartContent(request)) {
			out.println("Nothing uploaded.");
			return;
		}

		FileItemFactory itemFactory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(itemFactory);

		try {
			List<FileItem> items = upload.parseRequest(request);

			for (FileItem item : items) {
				if (item.getName() != null) {
					
					String path = System.getProperty("user.dir") + "/web store/WebContent/images/" + item.getName();
					File uploadDir = new File(path);
					item.write(uploadDir); 
					laptopDao.setImage("/images/" + item.getName() );
					LOG.info("Upload image succesfull");
					response.sendRedirect("laptops.jsp?nextPage=laptop.jsp?id=");
				}
			}
		} catch (FileUploadException e) {
			LOG.error("Upload failed.");
			return;
		} catch (Exception ex) {
			ex.printStackTrace();
			LOG.error("Can't upload file");
			return;
		}
	} 
}
