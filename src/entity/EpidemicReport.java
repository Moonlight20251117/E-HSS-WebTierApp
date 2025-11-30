package entity;

import java.sql.Timestamp;

/**
 * 疫情上报记录实体类
 * 对应数据库中的 epidemic_report 表
 */
public class EpidemicReport {
    private String reportId;
    private String patientId;
    private String doctorId;
    private String diseaseId;
    private String reportType;
    private String symptom;
    private Timestamp reportTime;
    private int status;
    private String remark;
    
    // 关联查询字段
    private String patientName;
    private String doctorName;
    private String diseaseName;
    
    // 构造函数
    public EpidemicReport() {}
    
    // Getters and Setters
    public String getReportId() {
        return reportId;
    }
    
    public void setReportId(String reportId) {
        this.reportId = reportId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }
    
    public String getDiseaseId() {
        return diseaseId;
    }
    
    public void setDiseaseId(String diseaseId) {
        this.diseaseId = diseaseId;
    }
    
    public String getReportType() {
        return reportType;
    }
    
    public void setReportType(String reportType) {
        this.reportType = reportType;
    }
    
    public String getSymptom() {
        return symptom;
    }
    
    public void setSymptom(String symptom) {
        this.symptom = symptom;
    }
    
    public Timestamp getReportTime() {
        return reportTime;
    }
    
    public void setReportTime(Timestamp reportTime) {
        this.reportTime = reportTime;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
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
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    
    public String getDiseaseName() {
        return diseaseName;
    }
    
    public void setDiseaseName(String diseaseName) {
        this.diseaseName = diseaseName;
    }
}

