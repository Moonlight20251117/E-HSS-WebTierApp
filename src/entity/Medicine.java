package entity;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * 药品信息实体类
 * 对应数据库中的 medicine 表
 */
public class Medicine {
    private String medicineId;
    private String medicineName;
    private String specification;
    private String manufacturer;
    private BigDecimal purchasePrice;
    private BigDecimal retailPrice;
    private int stockQuantity;
    private int minStock;
    private int isActive;
    private String medicineType;
    private Date expireDate;
    
    // 构造函数
    public Medicine() {}
    
    // Getters and Setters
    public String getMedicineId() {
        return medicineId;
    }
    
    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
    }
    
    public String getMedicineName() {
        return medicineName;
    }
    
    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }
    
    public String getSpecification() {
        return specification;
    }
    
    public void setSpecification(String specification) {
        this.specification = specification;
    }
    
    public String getManufacturer() {
        return manufacturer;
    }
    
    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }
    
    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }
    
    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }
    
    public BigDecimal getRetailPrice() {
        return retailPrice;
    }
    
    public void setRetailPrice(BigDecimal retailPrice) {
        this.retailPrice = retailPrice;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public int getMinStock() {
        return minStock;
    }
    
    public void setMinStock(int minStock) {
        this.minStock = minStock;
    }
    
    public int getIsActive() {
        return isActive;
    }
    
    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
    
    public String getMedicineType() {
        return medicineType;
    }
    
    public void setMedicineType(String medicineType) {
        this.medicineType = medicineType;
    }
    
    public Date getExpireDate() {
        return expireDate;
    }
    
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }
}

