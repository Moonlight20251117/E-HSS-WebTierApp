package entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * 号源实体类
 * 对应数据库中的 registration_source 表
 */
public class RegistrationSource {
    private String scheduleId;
    private String deptId;
    private String doctorId;
    private Date scheduleDate;
    private String schedulePeriod;
    private Time startTime;
    private Time stopTime;
    private int total;
    private int remain;
    private BigDecimal fee;
    private String status;
    private Timestamp createTime;
    
    // 关联查询字段
    private String deptName;
    private String doctorName;
    
    // 构造函数
    public RegistrationSource() {}
    
    // Getters and Setters
    public String getScheduleId() {
        return scheduleId;
    }
    
    public void setScheduleId(String scheduleId) {
        this.scheduleId = scheduleId;
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
    
    public Date getScheduleDate() {
        return scheduleDate;
    }
    
    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }
    
    public String getSchedulePeriod() {
        return schedulePeriod;
    }
    
    public void setSchedulePeriod(String schedulePeriod) {
        this.schedulePeriod = schedulePeriod;
    }
    
    public Time getStartTime() {
        return startTime;
    }
    
    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }
    
    public Time getStopTime() {
        return stopTime;
    }
    
    public void setStopTime(Time stopTime) {
        this.stopTime = stopTime;
    }
    
    public int getTotal() {
        return total;
    }
    
    public void setTotal(int total) {
        this.total = total;
    }
    
    public int getRemain() {
        return remain;
    }
    
    public void setRemain(int remain) {
        this.remain = remain;
    }
    
    public BigDecimal getFee() {
        return fee;
    }
    
    public void setFee(BigDecimal fee) {
        this.fee = fee;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
}

