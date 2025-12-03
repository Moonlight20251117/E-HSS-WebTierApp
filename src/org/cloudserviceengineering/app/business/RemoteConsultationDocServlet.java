package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 医生端远程干预Servlet
 */
@WebServlet("/servlet/hospital/doctor/RemoteConsultationDocServlet")
public class RemoteConsultationDocServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoteConsultationDocServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("远程干预服务");
	}
}

