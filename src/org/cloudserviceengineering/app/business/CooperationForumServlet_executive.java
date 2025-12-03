package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 医院高管合作论坛Servlet
 */
@WebServlet("/servlet/hospital/executive/CooperationForumServlet_executive")
public class CooperationForumServlet_executive extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_executive() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("医院高管合作论坛功能");
	}
}

