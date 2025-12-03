package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 高校合作论坛Servlet
 */
@WebServlet("/servlet/university/CooperationForumServlet_university")
public class CooperationForumServlet_university extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_university() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("高校合作论坛功能");
	}
}

