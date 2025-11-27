package servlet.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录Servlet
 */
@WebServlet("/servlet/login/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		// 获取登录表单中的角色参数
		String role = request.getParameter("role");
		String redirectPath = "";
		
		// 获取context path
		String contextPath = request.getContextPath();
		
		// 根据角色确定跳转路径
		if (role != null) {
			switch (role) {
				case "patient":
					redirectPath = contextPath + "/home/patient/patient-home.html";
					break;
				case "doctor":
					redirectPath = contextPath + "/home/hospital/doctor-home.html";
					break;
				case "nurse":
					redirectPath = contextPath + "/home/hospital/nurse-home.html";
					break;
				case "finance":
					redirectPath = contextPath + "/home/hospital/finance-home.html";
					break;
				case "executive":
					redirectPath = contextPath + "/home/hospital/executive-home.html";
					break;
				case "enterprise":
					redirectPath = contextPath + "/home/enterprise/enterprise-home.html";
					break;
				case "university":
					redirectPath = contextPath + "/home/university/university-home.html";
					break;
				case "admin":
					redirectPath = contextPath + "/home/admin/index.html";
					break;
				default:
					redirectPath = contextPath + "/portal/index.html";
			}
		} else {
			redirectPath = contextPath + "/portal/index.html";
		}
		
		// 执行重定向
		response.sendRedirect(redirectPath);
	}
}
