package servlet.hospital.doctor;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 医生端远程诊断Servlet
 */
@WebServlet("/servlet/hospital/doctor/RemoteDiagnosisServlet")
public class RemoteDiagnosisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoteDiagnosisServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("远程诊断服务");
	}
}

