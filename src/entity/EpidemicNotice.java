package entity;

import java.sql.Timestamp;

/**
 * 疫情公告实体类
 * 对应数据库中的 epidemic_notice 表
 */
public class EpidemicNotice {
    private String noticeId;
    private String title;
    private String content;
    private String publisherId;
    private Timestamp publishTime;
    private int priority;
    private int status;
    
    // 关联查询字段
    private String publisherName;
    
    // 构造函数
    public EpidemicNotice() {}
    
    // Getters and Setters
    public String getNoticeId() {
        return noticeId;
    }
    
    public void setNoticeId(String noticeId) {
        this.noticeId = noticeId;
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
    
    public String getPublisherId() {
        return publisherId;
    }
    
    public void setPublisherId(String publisherId) {
        this.publisherId = publisherId;
    }
    
    public Timestamp getPublishTime() {
        return publishTime;
    }
    
    public void setPublishTime(Timestamp publishTime) {
        this.publishTime = publishTime;
    }
    
    public int getPriority() {
        return priority;
    }
    
    public void setPriority(int priority) {
        this.priority = priority;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public String getPublisherName() {
        return publisherName;
    }
    
    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }
}

