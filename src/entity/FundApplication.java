package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 资金申请实体类
 * 对应数据库中的 fund_application 表
 */
public class FundApplication {
    private String applyId;
    private String applicantId;
    private String applicantDept;
    private Timestamp applyTime;
    private String fundType;
    private BigDecimal applyAmount;
    private String purpose;
    private String status;
    private String approverId;
    private Timestamp approveTime;
    private BigDecimal approveAmount;
    private String attachmentUrl;
    private String remark;
    
    // 关联查询字段
    private String applicantName;
    private String applicantDeptName;
    private String approverName;
    
    // 构造函数
    public FundApplication() {}
    
    // Getters and Setters
    public String getApplyId() {
        return applyId;
    }
    
    public void setApplyId(String applyId) {
        this.applyId = applyId;
    }
    
    public String getApplicantId() {
        return applicantId;
    }
    
    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }
    
    public String getApplicantDept() {
        return applicantDept;
    }
    
    public void setApplicantDept(String applicantDept) {
        this.applicantDept = applicantDept;
    }
    
    public Timestamp getApplyTime() {
        return applyTime;
    }
    
    public void setApplyTime(Timestamp applyTime) {
        this.applyTime = applyTime;
    }
    
    public String getFundType() {
        return fundType;
    }
    
    public void setFundType(String fundType) {
        this.fundType = fundType;
    }
    
    public BigDecimal getApplyAmount() {
        return applyAmount;
    }
    
    public void setApplyAmount(BigDecimal applyAmount) {
        this.applyAmount = applyAmount;
    }
    
    public String getPurpose() {
        return purpose;
    }
    
    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getApproverId() {
        return approverId;
    }
    
    public void setApproverId(String approverId) {
        this.approverId = approverId;
    }
    
    public Timestamp getApproveTime() {
        return approveTime;
    }
    
    public void setApproveTime(Timestamp approveTime) {
        this.approveTime = approveTime;
    }
    
    public BigDecimal getApproveAmount() {
        return approveAmount;
    }
    
    public void setApproveAmount(BigDecimal approveAmount) {
        this.approveAmount = approveAmount;
    }
    
    public String getAttachmentUrl() {
        return attachmentUrl;
    }
    
    public void setAttachmentUrl(String attachmentUrl) {
        this.attachmentUrl = attachmentUrl;
    }
    
    public String getRemark() {
        return remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public String getApplicantName() {
        return applicantName;
    }
    
    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }
    
    public String getApplicantDeptName() {
        return applicantDeptName;
    }
    
    public void setApplicantDeptName(String applicantDeptName) {
        this.applicantDeptName = applicantDeptName;
    }
    
    public String getApproverName() {
        return approverName;
    }
    
    public void setApproverName(String approverName) {
        this.approverName = approverName;
    }
}

