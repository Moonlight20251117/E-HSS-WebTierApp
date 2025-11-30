package entity;

import java.sql.Time;

/**
 * 医生排班实体类
 * 对应数据库中的 doctor_schedule 表
 */
public class DoctorSchedule {
    private String ruleId;
    private String doctorId;
    private int week;
    private int morningStatus;
    private int afternoonStatus;
    private Time morningStart;
    private Time morningStop;
    private Time afternoonStart;
    private Time afternoonStop;
    
    // 关联查询字段
    private String doctorName;
    
    // 构造函数
    public DoctorSchedule() {}
    
    // Getters and Setters
    public String getRuleId() {
        return ruleId;
    }
    
    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }
    
    public String getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }
    
    public int getWeek() {
        return week;
    }
    
    public void setWeek(int week) {
        this.week = week;
    }
    
    public int getMorningStatus() {
        return morningStatus;
    }
    
    public void setMorningStatus(int morningStatus) {
        this.morningStatus = morningStatus;
    }
    
    public int getAfternoonStatus() {
        return afternoonStatus;
    }
    
    public void setAfternoonStatus(int afternoonStatus) {
        this.afternoonStatus = afternoonStatus;
    }
    
    public Time getMorningStart() {
        return morningStart;
    }
    
    public void setMorningStart(Time morningStart) {
        this.morningStart = morningStart;
    }
    
    public Time getMorningStop() {
        return morningStop;
    }
    
    public void setMorningStop(Time morningStop) {
        this.morningStop = morningStop;
    }
    
    public Time getAfternoonStart() {
        return afternoonStart;
    }
    
    public void setAfternoonStart(Time afternoonStart) {
        this.afternoonStart = afternoonStart;
    }
    
    public Time getAfternoonStop() {
        return afternoonStop;
    }
    
    public void setAfternoonStop(Time afternoonStop) {
        this.afternoonStop = afternoonStop;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
}

