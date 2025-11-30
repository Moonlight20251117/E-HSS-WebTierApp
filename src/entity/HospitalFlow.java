package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 医院流水实体类
 * 对应数据库中的 hospital_flow 表
 */
public class HospitalFlow {
    private String flowId;
    private String flowType;
    private String flowCategory;
    private BigDecimal amount;
    private String transactionMethod;
    private String deptId;
    private String relatedOrder;
    private Timestamp flowTime;
    private String description;
    private String status;
    private String remark;
    
    // 关联查询字段
    private String deptName;
    
    // 构造函数
    public HospitalFlow() {}
    
    // Getters and Setters
    public String getFlowId() {
        return flowId;
    }
    
    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }
    
    public String getFlowType() {
        return flowType;
    }
    
    public void setFlowType(String flowType) {
        this.flowType = flowType;
    }
    
    public String getFlowCategory() {
        return flowCategory;
    }
    
    public void setFlowCategory(String flowCategory) {
        this.flowCategory = flowCategory;
    }
    
    public BigDecimal getAmount() {
        return amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    
    public String getTransactionMethod() {
        return transactionMethod;
    }
    
    public void setTransactionMethod(String transactionMethod) {
        this.transactionMethod = transactionMethod;
    }
    
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public String getRelatedOrder() {
        return relatedOrder;
    }
    
    public void setRelatedOrder(String relatedOrder) {
        this.relatedOrder = relatedOrder;
    }
    
    public Timestamp getFlowTime() {
        return flowTime;
    }
    
    public void setFlowTime(Timestamp flowTime) {
        this.flowTime = flowTime;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
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
}

