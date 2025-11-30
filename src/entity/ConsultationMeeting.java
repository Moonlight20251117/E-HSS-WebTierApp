package entity;

import java.sql.Timestamp;

/**
 * 会诊会议实体类
 * 对应数据库中的 consultation_meeting 表
 */
public class ConsultationMeeting {
    private String meetingId;
    private String requestId;
    private Timestamp startTime;
    private Timestamp endTime;
    private String participants;
    private String diagnosis;
    private String treatmentSuggest;
    private String meetingRecord;
    
    // 关联查询字段
    private String patientName;
    
    // 构造函数
    public ConsultationMeeting() {}
    
    // Getters and Setters
    public String getMeetingId() {
        return meetingId;
    }
    
    public void setMeetingId(String meetingId) {
        this.meetingId = meetingId;
    }
    
    public String getRequestId() {
        return requestId;
    }
    
    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }
    
    public Timestamp getStartTime() {
        return startTime;
    }
    
    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }
    
    public Timestamp getEndTime() {
        return endTime;
    }
    
    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }
    
    public String getParticipants() {
        return participants;
    }
    
    public void setParticipants(String participants) {
        this.participants = participants;
    }
    
    public String getDiagnosis() {
        return diagnosis;
    }
    
    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }
    
    public String getTreatmentSuggest() {
        return treatmentSuggest;
    }
    
    public void setTreatmentSuggest(String treatmentSuggest) {
        this.treatmentSuggest = treatmentSuggest;
    }
    
    public String getMeetingRecord() {
        return meetingRecord;
    }
    
    public void setMeetingRecord(String meetingRecord) {
        this.meetingRecord = meetingRecord;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
}

