package com.medical.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/servlet/hospital/nurse/MedicalServiceServlet_Nurse")
public class TaskServlet extends HttpServlet {
    
    // 1. 修改数据库连接配置
    // 截图显示的数据库名是 e-hss，不是 medical_cloud
    private static final String DB_URL = "jdbc:mysql://localhost:3306/e-hss?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "1234"; // 你提供的密码

    // 加载驱动
    static {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); } catch (Exception e) { e.printStackTrace(); }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            // --- 获取任务列表 ---
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM nursing_tasks ORDER BY time ASC");
                 ResultSet rs = ps.executeQuery()) {
                
                StringBuilder json = new StringBuilder("[");
                boolean first = true;
                while (rs.next()) {
                    if (!first) json.append(",");
                    
                    // 2. 这里必须使用截图里真实的字段名 (bed, name, time)
                    json.append(String.format(
                        "{\"id\":%d, \"time\":\"%s\", \"bed\":\"%s\", \"name\":\"%s\", \"content\":\"%s\", \"status\":%d}",
                        rs.getInt("id"), 
                        rs.getString("time"),    // 截图里字段叫 time
                        rs.getString("bed"),     // 截图里字段叫 bed
                        rs.getString("name"),    // 截图里字段叫 name
                        rs.getString("content"), // 截图里字段叫 content
                        rs.getInt("status")      // 截图里字段叫 status
                    ));
                    first = false;
                }
                json.append("]");
                out.write(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("[]"); 
            }
            
        } else if ("update".equals(action)) {
            // --- 更新状态 ---
            String idStr = request.getParameter("id");
            String statusStr = request.getParameter("status");
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement("UPDATE nursing_tasks SET status = ? WHERE id = ?")) {
                
                ps.setInt(1, Integer.parseInt(statusStr));
                ps.setInt(2, Integer.parseInt(idStr));
                
                int row = ps.executeUpdate();
                out.write(row > 0 ? "success" : "fail");
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("error");
            }
        }
    }
}