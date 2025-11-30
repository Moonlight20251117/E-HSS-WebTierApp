package entity;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * 入库记录实体类
 * 对应数据库中的 stock_in_record 表
 */
public class StockInRecord {
    private String recordId;
    private String orderId;
    private String medicineId;
    private int inQuantity;
    private String batchNumber;
    private Date inDate;
    private String operatorId;
    private Date expireDate;
    private String remark;
    
    // 关联查询字段
    private String medicineName;
    private String operatorName;
    
    // 构造函数
    public StockInRecord() {}
    
    // Getters and Setters
    public String getRecordId() {
        return recordId;
    }
    
    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }
    
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    
    public String getMedicineId() {
        return medicineId;
    }
    
    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
    }
    
    public int getInQuantity() {
        return inQuantity;
    }
    
    public void setInQuantity(int inQuantity) {
        this.inQuantity = inQuantity;
    }
    
    public String getBatchNumber() {
        return batchNumber;
    }
    
    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }
    
    public Date getInDate() {
        return inDate;
    }
    
    public void setInDate(Date inDate) {
        this.inDate = inDate;
    }
    
    public String getOperatorId() {
        return operatorId;
    }
    
    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId;
    }
    
    public Date getExpireDate() {
        return expireDate;
    }
    
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }
    
    public String getRemark() {
        return remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public String getMedicineName() {
        return medicineName;
    }
    
    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }
    
    public String getOperatorName() {
        return operatorName;
    }
    
    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }
}

