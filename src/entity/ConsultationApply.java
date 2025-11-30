package entity;

import java.sql.Timestamp;

/**
 * 会诊申请实体类
 * 对应数据库中的 consultation_apply 表
 */
public class ConsultationApply {
    private String requestId;
    private String patientId;
    private String applyDoctor;
    private String targetDept;
    private String targetDoctor;
    private String description;
    private Timestamp applyTime;
    private String status;
    private String refuseReason;
    
    // 关联查询字段
    private String patientName;
    private String applyDoctorName;
    private String targetDeptName;
    private String targetDoctorName;
    
    // 构造函数
    public ConsultationApply() {}
    
    // Getters and Setters
    public String getRequestId() {
        return requestId;
    }
    
    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getApplyDoctor() {
        return applyDoctor;
    }
    
    public void setApplyDoctor(String applyDoctor) {
        this.applyDoctor = applyDoctor;
    }
    
    public String getTargetDept() {
        return targetDept;
    }
    
    public void setTargetDept(String targetDept) {
        this.targetDept = targetDept;
    }
    
    public String getTargetDoctor() {
        return targetDoctor;
    }
    
    public void setTargetDoctor(String targetDoctor) {
        this.targetDoctor = targetDoctor;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Timestamp getApplyTime() {
        return applyTime;
    }
    
    public void setApplyTime(Timestamp applyTime) {
        this.applyTime = applyTime;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getRefuseReason() {
        return refuseReason;
    }
    
    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getApplyDoctorName() {
        return applyDoctorName;
    }
    
    public void setApplyDoctorName(String applyDoctorName) {
        this.applyDoctorName = applyDoctorName;
    }
    
    public String getTargetDeptName() {
        return targetDeptName;
    }
    
    public void setTargetDeptName(String targetDeptName) {
        this.targetDeptName = targetDeptName;
    }
    
    public String getTargetDoctorName() {
        return targetDoctorName;
    }
    
    public void setTargetDoctorName(String targetDoctorName) {
        this.targetDoctorName = targetDoctorName;
    }
}

