package org.web.servlet.hospital.nurse;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DiseaseManagementServlet
 */
@WebServlet("/servlet/hospital/nurse/DiseaseManagementServlet")
public class DiseaseManagementServlet_Nurse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DiseaseManagementServlet_Nurse() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("中文内容测试：").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		doGet(request, response);
	}

}