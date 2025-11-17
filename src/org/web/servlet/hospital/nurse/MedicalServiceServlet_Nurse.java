package org.web.servlet.hospital.nurse;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MedicalServiceServlet_Nurse
 */
@WebServlet("/servlet/hospital/nurse/MedicalServiceServlet_Nurse")
public class MedicalServiceServlet_Nurse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MedicalServiceServlet_Nurse() {
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