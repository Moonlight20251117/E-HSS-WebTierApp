package servlet.patient;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 患者电子病历Servlet
 */
@WebServlet("/servlet/patient/ElectronicRecordServlet")
public class ElectronicRecordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ElectronicRecordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("电子病历功能");
	}
}

