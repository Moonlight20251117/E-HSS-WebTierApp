package entity;

import java.math.BigDecimal;

/**
 * 采购订单明细实体类
 * 对应数据库中的 purchase_order_item 表
 */
public class PurchaseOrderItem {
    private String itemId;
    private String orderId;
    private String medicineId;
    private int purchaseQuantity;
    private BigDecimal unitPrice;
    private int receivedQuantity;
    private String remark;
    
    // 关联查询字段
    private String medicineName;
    private String specification;
    
    // 构造函数
    public PurchaseOrderItem() {}
    
    // Getters and Setters
    public String getItemId() {
        return itemId;
    }
    
    public void setItemId(String itemId) {
        this.itemId = itemId;
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
    
    public int getPurchaseQuantity() {
        return purchaseQuantity;
    }
    
    public void setPurchaseQuantity(int purchaseQuantity) {
        this.purchaseQuantity = purchaseQuantity;
    }
    
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
    
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    public int getReceivedQuantity() {
        return receivedQuantity;
    }
    
    public void setReceivedQuantity(int receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
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
    
    public String getSpecification() {
        return specification;
    }
    
    public void setSpecification(String specification) {
        this.specification = specification;
    }
}

