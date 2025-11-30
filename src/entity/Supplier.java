package entity;

import java.sql.Timestamp;

/**
 * 供应商实体类
 * 对应数据库中的 supplier 表
 */
public class Supplier {
    private String supplierId;
    private String supplierName;
    private String contactPerson;
    private String contactPhone;
    private String address;
    private String businessLicense;
    private int isActive;
    private Timestamp cooperationTime;
    
    // 构造函数
    public Supplier() {}
    
    // Getters and Setters
    public String getSupplierId() {
        return supplierId;
    }
    
    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
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
    
    public String getBusinessLicense() {
        return businessLicense;
    }
    
    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }
    
    public int getIsActive() {
        return isActive;
    }
    
    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
    
    public Timestamp getCooperationTime() {
        return cooperationTime;
    }
    
    public void setCooperationTime(Timestamp cooperationTime) {
        this.cooperationTime = cooperationTime;
    }
}

