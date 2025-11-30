package entity;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * 论坛帖子实体类
 * 对应数据库中的 forum_post 表
 */
public class ForumPost {
    private String postId;
    private String sectionId;
    private String userId;
    private String postTitle;
    private String postContent;
    private String postType;
    private String relatedOrg;
    private int viewCount;
    private int replyCount;
    private String status;
    private Timestamp createTime;
    private Timestamp updateTime;
    
    // 关联查询字段
    private String sectionName;
    private String userName;
    
    // 构造函数
    public ForumPost() {}
    
    // Getters and Setters
    public String getPostId() {
        return postId;
    }
    
    public void setPostId(String postId) {
        this.postId = postId;
    }
    
    public String getSectionId() {
        return sectionId;
    }
    
    public void setSectionId(String sectionId) {
        this.sectionId = sectionId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getPostTitle() {
        return postTitle;
    }
    
    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }
    
    public String getPostContent() {
        return postContent;
    }
    
    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }
    
    public String getPostType() {
        return postType;
    }
    
    public void setPostType(String postType) {
        this.postType = postType;
    }
    
    public String getRelatedOrg() {
        return relatedOrg;
    }
    
    public void setRelatedOrg(String relatedOrg) {
        this.relatedOrg = relatedOrg;
    }
    
    public int getViewCount() {
        return viewCount;
    }
    
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    
    public int getReplyCount() {
        return replyCount;
    }
    
    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
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
    
    public String getSectionName() {
        return sectionName;
    }
    
    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    /**
     * 格式化创建时间为字符串
     */
    public String getCreateTimeString() {
        if (createTime != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            return sdf.format(createTime);
        }
        return "";
    }
    
    /**
     * 格式化更新时间为字符串
     */
    public String getUpdateTimeString() {
        if (updateTime != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            return sdf.format(updateTime);
        }
        return "";
    }
}

