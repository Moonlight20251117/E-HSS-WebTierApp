package com.medical.util;

import java.sql.*;

public class DBUtil {
    // 请修改这里的数据库名(medical_db)、账号和密码
    private static final String URL = "jdbc:mysql://localhost:3306/e-hss?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8";
    private static final String USER = "root"; 
    private static final String PASSWORD = "1234"; // 你的密码

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}