package entity;

import java.sql.Timestamp;

/**
 * 护理任务实体类
 * 对应数据库表：nursing_task
 */
public class NursingTask {
    private String taskId;
    private String patientId;
    private String nurseId;
    private String doctorId;
    private String taskContent;
    private String taskType;
    private Timestamp planTime;
    private Timestamp actualTime;
    private String status;
    private String remark;
    
    // 关联查询字段（用于前端显示）
    private String patientName;  // 患者姓名
    private String bedNumber;    // 床号（从patient_info或其他表获取，暂时可为空）
    
    // 无参构造
    public NursingTask() {
    }
    
    // 全参构造
    public NursingTask(String taskId, String patientId, String nurseId, String doctorId,
                      String taskContent, String taskType, Timestamp planTime, 
                      Timestamp actualTime, String status, String remark) {
        this.taskId = taskId;
        this.patientId = patientId;
        this.nurseId = nurseId;
        this.doctorId = doctorId;
        this.taskContent = taskContent;
        this.taskType = taskType;
        this.planTime = planTime;
        this.actualTime = actualTime;
        this.status = status;
        this.remark = remark;
    }
    
    // Getters and Setters
    public String getTaskId() {
        return taskId;
    }
    
    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getNurseId() {
        return nurseId;
    }
    
    public void setNurseId(String nurseId) {
        this.nurseId = nurseId;
    }
    
    public String getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }
    
    public String getTaskContent() {
        return taskContent;
    }
    
    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }
    
    public String getTaskType() {
        return taskType;
    }
    
    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }
    
    public Timestamp getPlanTime() {
        return planTime;
    }
    
    public void setPlanTime(Timestamp planTime) {
        this.planTime = planTime;
    }
    
    public Timestamp getActualTime() {
        return actualTime;
    }
    
    public void setActualTime(Timestamp actualTime) {
        this.actualTime = actualTime;
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
    
    public String getBedNumber() {
        return bedNumber;
    }
    
    public void setBedNumber(String bedNumber) {
        this.bedNumber = bedNumber;
    }
    
    /**
     * 将状态转换为前端需要的数字格式
     * 已完成 -> 1, 其他 -> 0
     */
    public int getStatusAsInt() {
        if ("已完成".equals(status)) {
            return 1;
        }
        return 0;
    }
    
    /**
     * 获取格式化的时间字符串（用于前端显示）
     */
    public String getTimeString() {
        if (planTime != null) {
            // 格式化为 HH:mm
            return String.format("%02d:%02d", planTime.getHours(), planTime.getMinutes());
        }
        return "";
    }
}

