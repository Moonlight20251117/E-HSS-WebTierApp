package entity;

/**
 * 企业信息实体类
 * 对应数据库中的 enterprise 表
 */
public class Enterprise {
    private String enterpriseId;
    private String userId;
    private String enterpriseName;
    private String contactPerson;
    private String contactPhone;
    private String address;
    private String businessScope;
    private int status;
    
    // 关联查询字段
    private String userName;
    
    // 构造函数
    public Enterprise() {}
    
    // Getters and Setters
    public String getEnterpriseId() {
        return enterpriseId;
    }
    
    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getEnterpriseName() {
        return enterpriseName;
    }
    
    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
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
    
    public String getBusinessScope() {
        return businessScope;
    }
    
    public void setBusinessScope(String businessScope) {
        this.businessScope = businessScope;
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

