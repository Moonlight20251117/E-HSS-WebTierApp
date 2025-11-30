package entity;

import java.sql.Timestamp;

/**
 * 患者疾病关联实体类
 * 对应数据库中的 patient_disease 表
 */
public class PatientDisease {
    private String relationId;
    private String patientId;
    private String diseaseId;
    private Timestamp diagnosisTime;
    private String diagnosisDoctor;
    private String treatmentStatus;
    private int followUpNeeded;
    
    // 关联查询字段
    private String patientName;
    private String diseaseName;
    private String doctorName;
    
    // 构造函数
    public PatientDisease() {}
    
    // Getters and Setters
    public String getRelationId() {
        return relationId;
    }
    
    public void setRelationId(String relationId) {
        this.relationId = relationId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getDiseaseId() {
        return diseaseId;
    }
    
    public void setDiseaseId(String diseaseId) {
        this.diseaseId = diseaseId;
    }
    
    public Timestamp getDiagnosisTime() {
        return diagnosisTime;
    }
    
    public void setDiagnosisTime(Timestamp diagnosisTime) {
        this.diagnosisTime = diagnosisTime;
    }
    
    public String getDiagnosisDoctor() {
        return diagnosisDoctor;
    }
    
    public void setDiagnosisDoctor(String diagnosisDoctor) {
        this.diagnosisDoctor = diagnosisDoctor;
    }
    
    public String getTreatmentStatus() {
        return treatmentStatus;
    }
    
    public void setTreatmentStatus(String treatmentStatus) {
        this.treatmentStatus = treatmentStatus;
    }
    
    public int getFollowUpNeeded() {
        return followUpNeeded;
    }
    
    public void setFollowUpNeeded(int followUpNeeded) {
        this.followUpNeeded = followUpNeeded;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getDiseaseName() {
        return diseaseName;
    }
    
    public void setDiseaseName(String diseaseName) {
        this.diseaseName = diseaseName;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
}

