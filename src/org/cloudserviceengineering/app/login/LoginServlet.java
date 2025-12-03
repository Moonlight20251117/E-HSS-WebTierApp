package org.cloudserviceengineering.app.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DBUtil;

/**
 * 登录Servlet
 * 实现用户名密码验证和角色匹配
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
		
		// 获取登录表单参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String roleParam = request.getParameter("role"); // 前端传入的角色（可选，用于验证）
		
		// 验证必填字段
		if (username == null || username.trim().isEmpty() || 
			password == null || password.trim().isEmpty()) {
			response.getWriter().println("<script>alert('用户名和密码不能为空'); window.history.back();</script>");
			return;
		}
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBUtil.getConnection();
			
			// 查询用户信息（关联角色表）
			String loginSql = "SELECT u.user_id, u.username, u.password, u.real_name, u.phone, u.role_id, u.status, " +
							  "r.role_name, r.status as role_status " +
							  "FROM user u " +
							  "INNER JOIN role r ON u.role_id = r.role_id " +
							  "WHERE u.username = ?";
			
			pstmt = conn.prepareStatement(loginSql);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
			
			if (!rs.next()) {
				// 用户不存在
				response.getWriter().println("<script>alert('用户名或密码错误'); window.history.back();</script>");
				return;
			}
			
			// 验证密码（实际应用中应该使用加密后的密码比较）
			String dbPassword = rs.getString("password");
			if (!password.equals(dbPassword)) {
				response.getWriter().println("<script>alert('用户名或密码错误'); window.history.back();</script>");
				return;
			}
			
			// 检查用户状态
			int userStatus = rs.getInt("status");
			if (userStatus != 1) {
				response.getWriter().println("<script>alert('您的账号已被禁用，请联系管理员'); window.history.back();</script>");
				return;
			}
			
			// 检查角色状态
			int roleStatus = rs.getInt("role_status");
			if (roleStatus != 1) {
				response.getWriter().println("<script>alert('您的角色已被禁用，请联系管理员'); window.history.back();</script>");
				return;
			}
			
			// 如果前端传入了角色参数，验证角色是否匹配
			if (roleParam != null && !roleParam.trim().isEmpty()) {
				String dbRoleId = rs.getString("role_id");
				// 将前端的角色值转换为role_id格式
				String expectedRoleId = convertRoleToRoleId(roleParam);
				if (!dbRoleId.equals(expectedRoleId)) {
					response.getWriter().println("<script>alert('角色不匹配，请选择正确的登录入口'); window.history.back();</script>");
					return;
				}
			}
			
			// 登录成功，保存用户信息到Session
			HttpSession session = request.getSession();
			session.setAttribute("userId", rs.getString("user_id"));
			session.setAttribute("username", rs.getString("username"));
			session.setAttribute("realName", rs.getString("real_name"));
			session.setAttribute("phone", rs.getString("phone"));
			session.setAttribute("roleId", rs.getString("role_id"));
			session.setAttribute("roleName", rs.getString("role_name"));
			
			// 根据角色ID跳转到对应的首页
			String roleId = rs.getString("role_id");
			String contextPath = request.getContextPath();
			String redirectPath = getRedirectPathByRoleId(roleId, contextPath);
			
			// 执行重定向
			response.sendRedirect(redirectPath);
			
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println("<script>alert('登录失败：数据库错误'); window.history.back();</script>");
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 将前端传入的角色值转换为role_id格式
	 * @param role 前端传入的角色值（如：patient, doctor等）
	 * @return role_id（如：ROLE_PATIENT, ROLE_DOCTOR等）
	 */
	private String convertRoleToRoleId(String role) {
		if (role == null || role.trim().isEmpty()) {
			return null;
		}
		
		switch (role.toLowerCase()) {
			case "patient":
				return "ROLE_PATIENT";
			case "doctor":
				return "ROLE_DOCTOR";
			case "nurse":
				return "ROLE_NURSE";
			case "finance":
				return "ROLE_FINANCE";
			case "executive":
				return "ROLE_EXECUTIVE";
			case "admin":
				return "ROLE_ADMIN";
			case "enterprise":
				return "ROLE_ENTERPRISE";
			case "university":
				return "ROLE_UNIVERSITY";
			default:
				// 如果已经是ROLE_格式，直接返回
				if (role.startsWith("ROLE_")) {
					return role.toUpperCase();
				}
				return null;
		}
	}
	
	/**
	 * 根据角色ID获取跳转路径
	 * @param roleId 角色ID（如：ROLE_PATIENT）
	 * @param contextPath 上下文路径
	 * @return 跳转路径
	 */
	private String getRedirectPathByRoleId(String roleId, String contextPath) {
		if (roleId == null) {
			return contextPath + "/login/patient-login.html";
		}
		
		switch (roleId) {
			case "ROLE_PATIENT":
				return contextPath + "/home/patient/patient-home.jsp";
			case "ROLE_DOCTOR":
				return contextPath + "/home/hospital/doctor-home.jsp";
			case "ROLE_NURSE":
				return contextPath + "/home/hospital/nurse-home.jsp";
			case "ROLE_FINANCE":
				return contextPath + "/home/hospital/finance-home.jsp";
			case "ROLE_EXECUTIVE":
				return contextPath + "/home/hospital/executive-home.jsp";
			case "ROLE_ADMIN":
				return contextPath + "/home/admin/admin-home.jsp";
			case "ROLE_ENTERPRISE":
				return contextPath + "/home/enterprise/enterprise-home.jsp";
			case "ROLE_UNIVERSITY":
				return contextPath + "/home/university/university-home.jsp";
			default:
				return contextPath + "/login/patient-login.html";
		}
	}
}
