package entity;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * 患者个人信息实体类
 * 对应数据库中的 patient_info 表
 */
public class PatientInfo {
    private String patientInfoId;
    private String patientId;
    private Integer age;
    private Date dateOfBirth;
    private String medicalCard;
    private String contactPhone;
    private String allergicHistory;
    private String familyHistory;
    private Timestamp createTime;
    private Timestamp updateTime;
    
    // 关联查询字段
    private String patientName;
    
    // 构造函数
    public PatientInfo() {}
    
    // Getters and Setters
    public String getPatientInfoId() {
        return patientInfoId;
    }
    
    public void setPatientInfoId(String patientInfoId) {
        this.patientInfoId = patientInfoId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public Integer getAge() {
        return age;
    }
    
    public void setAge(Integer age) {
        this.age = age;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public String getMedicalCard() {
        return medicalCard;
    }
    
    public void setMedicalCard(String medicalCard) {
        this.medicalCard = medicalCard;
    }
    
    public String getContactPhone() {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
    
    public String getAllergicHistory() {
        return allergicHistory;
    }
    
    public void setAllergicHistory(String allergicHistory) {
        this.allergicHistory = allergicHistory;
    }
    
    public String getFamilyHistory() {
        return familyHistory;
    }
    
    public void setFamilyHistory(String familyHistory) {
        this.familyHistory = familyHistory;
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
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
}

