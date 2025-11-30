package entity;

/**
 * 就诊人信息实体类
 * 对应数据库中的 patient 表
 */
public class Patient {
    private String patientId;
    private String userId;
    private String realName;
    private String idCard;
    private String gender;
    private String phone;
    private String relationship;
    private String medicalCard;
    private int status;
    
    // 关联查询字段
    private String userName;
    
    // 构造函数
    public Patient() {}
    
    // Getters and Setters
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getRealName() {
        return realName;
    }
    
    public void setRealName(String realName) {
        this.realName = realName;
    }
    
    public String getIdCard() {
        return idCard;
    }
    
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getRelationship() {
        return relationship;
    }
    
    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }
    
    public String getMedicalCard() {
        return medicalCard;
    }
    
    public void setMedicalCard(String medicalCard) {
        this.medicalCard = medicalCard;
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

