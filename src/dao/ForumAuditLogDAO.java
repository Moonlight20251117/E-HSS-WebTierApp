package dao;

import java.sql.*;
import entity.ForumAuditLog;
import util.DBUtil;

/**
 * 论坛审核日志数据访问对象
 */
public class ForumAuditLogDAO {
    
    /**
     * 创建审核日志
     * @param log 审核日志对象
     * @return 是否创建成功
     */
    public boolean createAuditLog(ForumAuditLog log) {
        String sql = "INSERT INTO forum_audit_log (log_id, post_id, auditor_id, " +
                     "before_status, after_status, audit_opinion) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, log.getLogId());
            ps.setString(2, log.getPostId());
            ps.setString(3, log.getAuditorId());
            ps.setString(4, log.getBeforeStatus());
            ps.setString(5, log.getAfterStatus());
            ps.setString(6, log.getAuditOpinion());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

