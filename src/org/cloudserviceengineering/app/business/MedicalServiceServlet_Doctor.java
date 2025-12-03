package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 医生端医疗服务Servlet
 */
@WebServlet("/servlet/hospital/doctor/MedicalServiceServlet_Doctor")
public class MedicalServiceServlet_Doctor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MedicalServiceServlet_Doctor() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("医生端医疗服务");
	}
}

