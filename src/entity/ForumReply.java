package entity;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * 论坛回复实体类
 * 对应数据库中的 forum_reply 表
 */
public class ForumReply {
    private String replyId;
    private String postId;
    private String userId;
    private String replyContent;
    private String replyType;
    private String relatedOrg;
    private String status;
    private Timestamp createTime;
    
    // 关联查询字段
    private String userName;
    
    // 构造函数
    public ForumReply() {}
    
    // Getters and Setters
    public String getReplyId() {
        return replyId;
    }
    
    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }
    
    public String getPostId() {
        return postId;
    }
    
    public void setPostId(String postId) {
        this.postId = postId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getReplyContent() {
        return replyContent;
    }
    
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }
    
    public String getReplyType() {
        return replyType;
    }
    
    public void setReplyType(String replyType) {
        this.replyType = replyType;
    }
    
    public String getRelatedOrg() {
        return relatedOrg;
    }
    
    public void setRelatedOrg(String relatedOrg) {
        this.relatedOrg = relatedOrg;
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
}

