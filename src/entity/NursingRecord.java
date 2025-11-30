package entity;

import java.sql.Timestamp;

/**
 * 护理记录实体类
 * 对应数据库中的 nursing_record 表
 */
public class NursingRecord {
    private String recordId;
    private String taskId;
    private String nurseId;
    private Timestamp executeTime;
    private String executeResult;
    private String patientCondition;
    private String signature;
    
    // 关联查询字段
    private String nurseName;
    private String taskContent;
    
    // 构造函数
    public NursingRecord() {}
    
    // Getters and Setters
    public String getRecordId() {
        return recordId;
    }
    
    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }
    
    public String getTaskId() {
        return taskId;
    }
    
    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }
    
    public String getNurseId() {
        return nurseId;
    }
    
    public void setNurseId(String nurseId) {
        this.nurseId = nurseId;
    }
    
    public Timestamp getExecuteTime() {
        return executeTime;
    }
    
    public void setExecuteTime(Timestamp executeTime) {
        this.executeTime = executeTime;
    }
    
    public String getExecuteResult() {
        return executeResult;
    }
    
    public void setExecuteResult(String executeResult) {
        this.executeResult = executeResult;
    }
    
    public String getPatientCondition() {
        return patientCondition;
    }
    
    public void setPatientCondition(String patientCondition) {
        this.patientCondition = patientCondition;
    }
    
    public String getSignature() {
        return signature;
    }
    
    public void setSignature(String signature) {
        this.signature = signature;
    }
    
    public String getNurseName() {
        return nurseName;
    }
    
    public void setNurseName(String nurseName) {
        this.nurseName = nurseName;
    }
    
    public String getTaskContent() {
        return taskContent;
    }
    
    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }
}

