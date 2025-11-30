package entity;

import java.sql.Timestamp;

/**
 * 医疗资讯实体类
 * 对应数据库中的 medical_news 表
 */
public class MedicalNews {
    private String newsId;
    private String newsTitle;
    private String newsContent;
    private String newsType;
    private String publisherId;
    private String publisherType;
    private String coverImg;
    private int viewCount;
    private String status;
    private Timestamp createTime;
    private Timestamp updateTime;
    
    // 关联查询字段
    private String publisherName;
    
    // 构造函数
    public MedicalNews() {}
    
    // Getters and Setters
    public String getNewsId() {
        return newsId;
    }
    
    public void setNewsId(String newsId) {
        this.newsId = newsId;
    }
    
    public String getNewsTitle() {
        return newsTitle;
    }
    
    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }
    
    public String getNewsContent() {
        return newsContent;
    }
    
    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }
    
    public String getNewsType() {
        return newsType;
    }
    
    public void setNewsType(String newsType) {
        this.newsType = newsType;
    }
    
    public String getPublisherId() {
        return publisherId;
    }
    
    public void setPublisherId(String publisherId) {
        this.publisherId = publisherId;
    }
    
    public String getPublisherType() {
        return publisherType;
    }
    
    public void setPublisherType(String publisherType) {
        this.publisherType = publisherType;
    }
    
    public String getCoverImg() {
        return coverImg;
    }
    
    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }
    
    public int getViewCount() {
        return viewCount;
    }
    
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
    
    public Timestamp getUpdateTime() {
        return updateTime;
    }
    
    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }
    
    public String getPublisherName() {
        return publisherName;
    }
    
    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }
}

