package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.NursingTask;
import util.DBUtil;

/**
 * 护理任务数据访问对象
 */
public class NursingTaskDAO {
    
    /**
     * 获取所有护理任务（关联查询患者信息）
     * @return 任务列表
     */
    public List<NursingTask> getAllTasks() {
        List<NursingTask> list = new ArrayList<>();
        // 关联查询患者表获取患者姓名
        String sql = "SELECT t.task_id, t.patient_id, t.nurse_id, t.doctor_id, " +
                     "t.task_content, t.task_type, t.plan_time, t.actual_time, " +
                     "t.status, t.remark, " +
                     "p.real_name as patient_name " +
                     "FROM nursing_task t " +
                     "LEFT JOIN patient p ON t.patient_id = p.patient_id " +
                     "ORDER BY t.plan_time ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                NursingTask task = new NursingTask();
                task.setTaskId(rs.getString("task_id"));
                task.setPatientId(rs.getString("patient_id"));
                task.setNurseId(rs.getString("nurse_id"));
                task.setDoctorId(rs.getString("doctor_id"));
                task.setTaskContent(rs.getString("task_content"));
                task.setTaskType(rs.getString("task_type"));
                task.setPlanTime(rs.getTimestamp("plan_time"));
                task.setActualTime(rs.getTimestamp("actual_time"));
                
                // 获取状态字段，确保是字符串类型
                String statusValue = rs.getString("status");
                
                // 如果status是null或空，设置为默认值
                if (statusValue == null || statusValue.trim().isEmpty()) {
                    statusValue = "待执行";
                }
                
                task.setStatus(statusValue);
                task.setRemark(rs.getString("remark"));
                String patientName = rs.getString("patient_name");
                task.setPatientName(patientName != null && !patientName.trim().isEmpty() ? patientName : "未知患者");
                
                // 床号暂时使用 patient_id 的后4位作为临时床号
                String patientId = rs.getString("patient_id");
                if (patientId != null && patientId.length() >= 4) {
                    task.setBedNumber(patientId.substring(patientId.length() - 4));
                } else {
                    task.setBedNumber("0000");
                }
                
                list.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * 更新任务状态
     * @param taskId 任务ID
     * @param newStatus 新状态（待执行/执行中/已完成/已取消）
     * @return 是否更新成功
     */
    public boolean updateStatus(String taskId, String newStatus) {
        String sql = "UPDATE nursing_task SET status = ?, actual_time = ? WHERE task_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            // 关闭自动提交，手动控制事务
            conn.setAutoCommit(false);
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            
            // 如果状态是已完成或执行中，更新实际执行时间
            if ("已完成".equals(newStatus) || "执行中".equals(newStatus)) {
                ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            } else {
                ps.setTimestamp(2, null);
            }
            ps.setString(3, taskId);
            
            int rowsAffected = ps.executeUpdate();
            
            // 提交事务
            conn.commit();
            
            // 验证更新是否成功
            if (rowsAffected == 0) {
                System.err.println("警告：没有行被更新，可能taskId不存在: " + taskId);
            }
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("=== 更新任务状态失败 ===");
            System.err.println("taskId: " + taskId);
            System.err.println("newStatus: " + newStatus);
            System.err.println("错误信息: " + e.getMessage());
            e.printStackTrace();
            
            // 回滚事务
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("事务已回滚");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            // 关闭资源
            try {
                if (ps != null) ps.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复自动提交
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * 根据任务ID获取任务
     * @param taskId 任务ID
     * @return 任务对象
     */
    public NursingTask getTaskById(String taskId) {
        String sql = "SELECT t.task_id, t.patient_id, t.nurse_id, t.doctor_id, " +
                     "t.task_content, t.task_type, t.plan_time, t.actual_time, " +
                     "t.status, t.remark, " +
                     "p.real_name as patient_name " +
                     "FROM nursing_task t " +
                     "LEFT JOIN patient p ON t.patient_id = p.patient_id " +
                     "WHERE t.task_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, taskId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                NursingTask task = new NursingTask();
                task.setTaskId(rs.getString("task_id"));
                task.setPatientId(rs.getString("patient_id"));
                task.setNurseId(rs.getString("nurse_id"));
                task.setDoctorId(rs.getString("doctor_id"));
                task.setTaskContent(rs.getString("task_content"));
                task.setTaskType(rs.getString("task_type"));
                task.setPlanTime(rs.getTimestamp("plan_time"));
                task.setActualTime(rs.getTimestamp("actual_time"));
                task.setStatus(rs.getString("status"));
                task.setRemark(rs.getString("remark"));
                
                String patientName = rs.getString("patient_name");
                task.setPatientName(patientName != null && !patientName.trim().isEmpty() ? patientName : "未知患者");
                
                String patientId = rs.getString("patient_id");
                if (patientId != null && patientId.length() >= 4) {
                    task.setBedNumber(patientId.substring(patientId.length() - 4));
                } else {
                    task.setBedNumber("0000");
                }
                
                return task;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

