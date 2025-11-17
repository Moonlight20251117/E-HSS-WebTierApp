package org.web.servlet.hospital.executive;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CooperationForumServlet
 */
@WebServlet("/servlet/hospital/executive/CooperationForumServlet_executive")
public class CooperationForumServlet_executive extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CooperationForumServlet_executive() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("合作论坛内容（高管视角）：").append(request.getContextPath());
		response.getWriter().append("<br><br>测试内容1：医疗设备更新合作项目讨论");
		response.getWriter().append("<br>测试内容2：与医学院校共建研究中心方案");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		doGet(request, response);
	}

}