package entity;

/**
 * 高校信息实体类
 * 对应数据库中的 university 表
 */
public class University {
    private String universityId;
    private String userId;
    private String universityName;
    private String contactPerson;
    private String contactPhone;
    private String address;
    private String majorField;
    private int status;
    
    // 关联查询字段
    private String userName;
    
    // 构造函数
    public University() {}
    
    // Getters and Setters
    public String getUniversityId() {
        return universityId;
    }
    
    public void setUniversityId(String universityId) {
        this.universityId = universityId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUniversityName() {
        return universityName;
    }
    
    public void setUniversityName(String universityName) {
        this.universityName = universityName;
    }
    
    public String getContactPerson() {
        return contactPerson;
    }
    
    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }
    
    public String getContactPhone() {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getMajorField() {
        return majorField;
    }
    
    public void setMajorField(String majorField) {
        this.majorField = majorField;
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

