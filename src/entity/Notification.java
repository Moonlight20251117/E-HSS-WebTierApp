package entity;

import java.sql.Timestamp;

/**
 * 通知信息实体类
 * 对应数据库中的 notification 表
 */
public class Notification {
    private String notificationId;
    private String userId;
    private String notificationType;
    private String title;
    private String content;
    private Timestamp sendTime;
    private int readStatus;
    private Timestamp readTime;
    private String relatedId;
    private int status;
    
    // 关联查询字段
    private String userName;
    
    // 构造函数
    public Notification() {}
    
    // Getters and Setters
    public String getNotificationId() {
        return notificationId;
    }
    
    public void setNotificationId(String notificationId) {
        this.notificationId = notificationId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getNotificationType() {
        return notificationType;
    }
    
    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public Timestamp getSendTime() {
        return sendTime;
    }
    
    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }
    
    public int getReadStatus() {
        return readStatus;
    }
    
    public void setReadStatus(int readStatus) {
        this.readStatus = readStatus;
    }
    
    public Timestamp getReadTime() {
        return readTime;
    }
    
    public void setReadTime(Timestamp readTime) {
        this.readTime = readTime;
    }
    
    public String getRelatedId() {
        return relatedId;
    }
    
    public void setRelatedId(String relatedId) {
        this.relatedId = relatedId;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
}

