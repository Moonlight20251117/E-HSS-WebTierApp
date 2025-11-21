package com.medical.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.medical.entity.Task;
import com.medical.util.DBUtil;

public class TaskDAO {

    // 1. 获取所有任务
    public List<Task> getAllTasks() {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT * FROM nursing_tasks ORDER BY time ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new Task(
                    rs.getInt("id"),
                    rs.getString("time"),
                    rs.getString("bed"),
                    rs.getString("name"),
                    rs.getString("content"),
                    rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 更新状态 (完成=1, 待办=0)
    public boolean updateStatus(int id, int newStatus) {
        String sql = "UPDATE nursing_tasks SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newStatus);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}