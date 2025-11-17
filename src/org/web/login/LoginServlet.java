package org.web.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 处理GET请求（如果需要）
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		// 获取登录表单中的角色参数
		String role = request.getParameter("role");
		String redirectPath = "";
		
		// 根据角色确定跳转路径
		switch (role) {
			case "patient":
				// 患者首页
				redirectPath = "/patient/index.html";
				break;
			case "doctor":
				// 医生首页
				redirectPath = "/hospital/doctor/index.html";
				break;
			case "nurse":
				// 护士首页
				redirectPath = "/hospital/nurse/index.html";
				break;
			case "finance":
				// 财务首页
				redirectPath = "/hospital/finance/index.html";
				break;
			case "executive":
				// 高管首页
				redirectPath = "/hospital/executive/index.html";
				break;
			case "enterprise":
				// 医疗相关企业首页
				redirectPath = "/enterprise/index.html";
				break;
			case "university":
				// 医疗相关高校首页
				redirectPath = "/university/index.html";
				break;
			case "admin":
				// 管理员首页
				redirectPath = "/admin/index.html";
				break;
			default:
				// 默认跳转回登录页
				redirectPath = "/index.html";
		}
		
		// 执行重定向
		response.sendRedirect(request.getContextPath() + redirectPath);
	}
}