package org.web.servlet.university;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CooperationForumServlet
 */
@WebServlet("/servlet/university/CooperationForumServlet_university")
public class CooperationForumServlet_university extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_university() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("合作论坛内容（高校视角）：").append(request.getContextPath());
		response.getWriter().append("<br><br>测试内容1：医疗新技术研究合作项目");
		response.getWriter().append("<br>测试内容2：医学人才联合培养计划");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		doGet(request, response);
	}

}