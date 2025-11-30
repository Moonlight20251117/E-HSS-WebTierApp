package entity;

import java.sql.Timestamp;

/**
 * 病例附件实体类
 * 对应数据库中的 consultation_attachment 表
 */
public class ConsultationAttachment {
    private String fileId;
    private String requestId;
    private String uploadUser;
    private Timestamp uploadTime;
    private String fileUri;
    private String fileType;
    private String fileName;
    private String description;
    
    // 关联查询字段
    private String uploadUserName;
    
    // 构造函数
    public ConsultationAttachment() {}
    
    // Getters and Setters
    public String getFileId() {
        return fileId;
    }
    
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }
    
    public String getRequestId() {
        return requestId;
    }
    
    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }
    
    public String getUploadUser() {
        return uploadUser;
    }
    
    public void setUploadUser(String uploadUser) {
        this.uploadUser = uploadUser;
    }
    
    public Timestamp getUploadTime() {
        return uploadTime;
    }
    
    public void setUploadTime(Timestamp uploadTime) {
        this.uploadTime = uploadTime;
    }
    
    public String getFileUri() {
        return fileUri;
    }
    
    public void setFileUri(String fileUri) {
        this.fileUri = fileUri;
    }
    
    public String getFileType() {
        return fileType;
    }
    
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getUploadUserName() {
        return uploadUserName;
    }
    
    public void setUploadUserName(String uploadUserName) {
        this.uploadUserName = uploadUserName;
    }
}

