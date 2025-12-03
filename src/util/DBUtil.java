package util;

import java.sql.*;

public class DBUtil {
    // 数据库配置 - 使用新的数据库 smart_medical_system
    // 注意：characterEncoding 使用 utf8，但数据库和表使用 utf8mb4 字符集
    private static final String URL = "jdbc:mysql://localhost:3306/smart_medical_system?useSSL=false&serverTimezone=UTC&characterEncoding=utf8&useUnicode=true";
    private static final String USER = "root"; 
    private static final String PASSWORD = "1234";

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

