package entity;

import java.sql.Timestamp;

/**
 * 论坛板块实体类
 * 对应数据库中的 forum_section 表
 */
public class ForumSection {
    private String sectionId;
    private String sectionName;
    private String sectionDesc;
    private int sortOrder;
    private int status;
    private Timestamp createTime;
    
    // 构造函数
    public ForumSection() {}
    
    // Getters and Setters
    public String getSectionId() {
        return sectionId;
    }
    
    public void setSectionId(String sectionId) {
        this.sectionId = sectionId;
    }
    
    public String getSectionName() {
        return sectionName;
    }
    
    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }
    
    public String getSectionDesc() {
        return sectionDesc;
    }
    
    public void setSectionDesc(String sectionDesc) {
        this.sectionDesc = sectionDesc;
    }
    
    public int getSortOrder() {
        return sortOrder;
    }
    
    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public Timestamp getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
}

