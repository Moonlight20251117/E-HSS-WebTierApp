package entity;

import java.sql.Timestamp;

/**
 * 医院资源实体类
 * 对应数据库中的 hospital_resource 表
 */
public class HospitalResource {
    private String resourceId;
    private String resourceName;
    private String resourceType;
    private String deptId;
    private int quantity;
    private String status;
    private String managerId;
    private Timestamp putInTime;
    private String remark;
    
    // 关联查询字段
    private String deptName;
    private String managerName;
    
    // 构造函数
    public HospitalResource() {}
    
    // Getters and Setters
    public String getResourceId() {
        return resourceId;
    }
    
    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }
    
    public String getResourceName() {
        return resourceName;
    }
    
    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
    
    public String getResourceType() {
        return resourceType;
    }
    
    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }
    
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getManagerId() {
        return managerId;
    }
    
    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }
    
    public Timestamp getPutInTime() {
        return putInTime;
    }
    
    public void setPutInTime(Timestamp putInTime) {
        this.putInTime = putInTime;
    }
    
    public String getRemark() {
        return remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getManagerName() {
        return managerName;
    }
    
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }
}

