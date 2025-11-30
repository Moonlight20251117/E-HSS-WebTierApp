package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 预约记录实体类
 * 对应数据库中的 reservation 表
 */
public class Reservation {
    private String reservationId;
    private String userId;
    private String patientId;
    private String scheduleId;
    private String deptId;
    private String doctorId;
    private Timestamp reservationTime;
    private int reservationStatus;
    private Timestamp cancelTime;
    private String visitNo;
    private int payStatus;
    private Timestamp payTime;
    private BigDecimal payAmount;
    
    // 关联查询字段
    private String patientName;
    private String doctorName;
    private String deptName;
    
    // 构造函数
    public Reservation() {}
    
    // Getters and Setters
    public String getReservationId() {
        return reservationId;
    }
    
    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getPatientId() {
        return patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
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
    
    public Timestamp getReservationTime() {
        return reservationTime;
    }
    
    public void setReservationTime(Timestamp reservationTime) {
        this.reservationTime = reservationTime;
    }
    
    public int getReservationStatus() {
        return reservationStatus;
    }
    
    public void setReservationStatus(int reservationStatus) {
        this.reservationStatus = reservationStatus;
    }
    
    public Timestamp getCancelTime() {
        return cancelTime;
    }
    
    public void setCancelTime(Timestamp cancelTime) {
        this.cancelTime = cancelTime;
    }
    
    public String getVisitNo() {
        return visitNo;
    }
    
    public void setVisitNo(String visitNo) {
        this.visitNo = visitNo;
    }
    
    public int getPayStatus() {
        return payStatus;
    }
    
    public void setPayStatus(int payStatus) {
        this.payStatus = payStatus;
    }
    
    public Timestamp getPayTime() {
        return payTime;
    }
    
    public void setPayTime(Timestamp payTime) {
        this.payTime = payTime;
    }
    
    public BigDecimal getPayAmount() {
        return payAmount;
    }
    
    public void setPayAmount(BigDecimal payAmount) {
        this.payAmount = payAmount;
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

