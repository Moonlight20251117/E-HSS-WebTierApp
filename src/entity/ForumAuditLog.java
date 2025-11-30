package entity;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * 论坛审核日志实体类
 * 对应数据库中的 forum_audit_log 表
 */
public class ForumAuditLog {
    private String logId;
    private String postId;
    private String auditorId;
    private Timestamp auditTime;
    private String beforeStatus;
    private String afterStatus;
    private String auditOpinion;
    
    // 关联查询字段
    private String auditorName;
    
    // 构造函数
    public ForumAuditLog() {}
    
    // Getters and Setters
    public String getLogId() {
        return logId;
    }
    
    public void setLogId(String logId) {
        this.logId = logId;
    }
    
    public String getPostId() {
        return postId;
    }
    
    public void setPostId(String postId) {
        this.postId = postId;
    }
    
    public String getAuditorId() {
        return auditorId;
    }
    
    public void setAuditorId(String auditorId) {
        this.auditorId = auditorId;
    }
    
    public Timestamp getAuditTime() {
        return auditTime;
    }
    
    public void setAuditTime(Timestamp auditTime) {
        this.auditTime = auditTime;
    }
    
    public String getBeforeStatus() {
        return beforeStatus;
    }
    
    public void setBeforeStatus(String beforeStatus) {
        this.beforeStatus = beforeStatus;
    }
    
    public String getAfterStatus() {
        return afterStatus;
    }
    
    public void setAfterStatus(String afterStatus) {
        this.afterStatus = afterStatus;
    }
    
    public String getAuditOpinion() {
        return auditOpinion;
    }
    
    public void setAuditOpinion(String auditOpinion) {
        this.auditOpinion = auditOpinion;
    }
    
    public String getAuditorName() {
        return auditorName;
    }
    
    public void setAuditorName(String auditorName) {
        this.auditorName = auditorName;
    }
    
    /**
     * 格式化审核时间为字符串
     */
    public String getAuditTimeString() {
        if (auditTime != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            return sdf.format(auditTime);
        }
        return "";
    }
}

