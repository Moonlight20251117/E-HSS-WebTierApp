package entity;

import java.sql.Timestamp;

/**
 * 电子病历实体类
 * 对应数据库中的 medical_record 表
 */
public class MedicalRecord {
    private String recordId;
    private String patientId;
    private String reservationId;
    private String deptId;
    private String doctorId;
    private Timestamp visitTime;
    private String mainComplaint;
    private String presentIllness;
    private String pastIllness;
    private String physicalExam;
    private String auxiliaryExam;
    private String examResult;
    private String diagnosis;
    private String treatment;
    private String notes;
    private String doctorSign;
    private Timestamp createTime;
    
    // 关联查询字段
    private String patientName;
    private String doctorName;
    private String deptName;
    
    // 构造函数
    public MedicalRecord() {}
    
    // Getters and Setters
    public String getRecordId() {
        return recordId;
    }
    
    public void setRecordId(String recordId) {
        this.recordId = recordId;
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
    
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public String getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }
    
    public Timestamp getVisitTime() {
        return visitTime;
    }
    
    public void setVisitTime(Timestamp visitTime) {
        this.visitTime = visitTime;
    }
    
    public String getMainComplaint() {
        return mainComplaint;
    }
    
    public void setMainComplaint(String mainComplaint) {
        this.mainComplaint = mainComplaint;
    }
    
    public String getPresentIllness() {
        return presentIllness;
    }
    
    public void setPresentIllness(String presentIllness) {
        this.presentIllness = presentIllness;
    }
    
    public String getPastIllness() {
        return pastIllness;
    }
    
    public void setPastIllness(String pastIllness) {
        this.pastIllness = pastIllness;
    }
    
    public String getPhysicalExam() {
        return physicalExam;
    }
    
    public void setPhysicalExam(String physicalExam) {
        this.physicalExam = physicalExam;
    }
    
    public String getAuxiliaryExam() {
        return auxiliaryExam;
    }
    
    public void setAuxiliaryExam(String auxiliaryExam) {
        this.auxiliaryExam = auxiliaryExam;
    }
    
    public String getExamResult() {
        return examResult;
    }
    
    public void setExamResult(String examResult) {
        this.examResult = examResult;
    }
    
    public String getDiagnosis() {
        return diagnosis;
    }
    
    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }
    
    public String getTreatment() {
        return treatment;
    }
    
    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getDoctorSign() {
        return doctorSign;
    }
    
    public void setDoctorSign(String doctorSign) {
        this.doctorSign = doctorSign;
    }
    
    public Timestamp getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}

