package org.cloudserviceengineering.app.business;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 企业合作论坛Servlet
 */
@WebServlet("/servlet/enterprise/CooperationForumServlet_enterprise")
public class CooperationForumServlet_enterprise extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_enterprise() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("企业合作论坛功能");
	}
}

