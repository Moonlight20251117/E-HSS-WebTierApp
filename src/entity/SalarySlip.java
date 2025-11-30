package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 工资单实体类
 * 对应数据库中的 salary_slip 表
 */
public class SalarySlip {
    private String salaryId;
    private String userId;
    private String userType;
    private BigDecimal salaryAmount;
    private Timestamp issueTime;
    private String issuerId;
    private String status;
    private BigDecimal deduction;
    private BigDecimal tax;
    private String remark;
    
    // 关联查询字段
    private String userName;
    private String issuerName;
    
    // 构造函数
    public SalarySlip() {}
    
    // Getters and Setters
    public String getSalaryId() {
        return salaryId;
    }
    
    public void setSalaryId(String salaryId) {
        this.salaryId = salaryId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUserType() {
        return userType;
    }
    
    public void setUserType(String userType) {
        this.userType = userType;
    }
    
    public BigDecimal getSalaryAmount() {
        return salaryAmount;
    }
    
    public void setSalaryAmount(BigDecimal salaryAmount) {
        this.salaryAmount = salaryAmount;
    }
    
    public Timestamp getIssueTime() {
        return issueTime;
    }
    
    public void setIssueTime(Timestamp issueTime) {
        this.issueTime = issueTime;
    }
    
    public String getIssuerId() {
        return issuerId;
    }
    
    public void setIssuerId(String issuerId) {
        this.issuerId = issuerId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public BigDecimal getDeduction() {
        return deduction;
    }
    
    public void setDeduction(BigDecimal deduction) {
        this.deduction = deduction;
    }
    
    public BigDecimal getTax() {
        return tax;
    }
    
    public void setTax(BigDecimal tax) {
        this.tax = tax;
    }
    
    public String getRemark() {
        return remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getIssuerName() {
        return issuerName;
    }
    
    public void setIssuerName(String issuerName) {
        this.issuerName = issuerName;
    }
}

