package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 缴费单实体类
 * 对应数据库中的 payment_order 表
 */
public class PaymentOrder {
    private String paymentId;
    private String patientId;
    private String reservationId;
    private String medicalRecordId;
    private Timestamp paymentTime;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String cashierId;
    private String deptId;
    private String invoiceNo;
    private String status;
    private String remark;
    
    // 关联查询字段
    private String patientName;
    private String cashierName;
    private String deptName;
    
    // 构造函数
    public PaymentOrder() {}
    
    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getReservationId() {
        return reservationId;
    }
    
    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }
    
    public String getMedicalRecordId() {
        return medicalRecordId;
    }
    
    public void setMedicalRecordId(String medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }
    
    public Timestamp getPaymentTime() {
        return paymentTime;
    }
    
    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getCashierId() {
        return cashierId;
    }
    
    public void setCashierId(String cashierId) {
        this.cashierId = cashierId;
    }
    
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public String getInvoiceNo() {
        return invoiceNo;
    }
    
    public void setInvoiceNo(String invoiceNo) {
        this.invoiceNo = invoiceNo;
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
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getCashierName() {
        return cashierName;
    }
    
    public void setCashierName(String cashierName) {
        this.cashierName = cashierName;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}

