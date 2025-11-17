package org.web.servlet.enterprise;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CooperationForumServlet
 */
@WebServlet("/servlet/enterprise/CooperationForumServlet_enterprise")
public class CooperationForumServlet_enterprise extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_enterprise() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("合作论坛内容（企业视角）：").append(request.getContextPath());
		response.getWriter().append("<br><br>测试内容1：新型医疗设备合作推广");
		response.getWriter().append("<br>测试内容2：与医院共建产学研基地提议");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		doGet(request, response);
	}

}