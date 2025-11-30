package entity;

/**
 * 科室实体类
 * 对应数据库中的 department 表
 */
public class Department {
    private String deptId;
    private String deptName;
    private String deptCode;
    private String deptType;
    private String deptIntro;
    private String deptLocation;
    private String contact;
    private int status;
    
    // 构造函数
    public Department() {}
    
    // Getters and Setters
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getDeptCode() {
        return deptCode;
    }
    
    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }
    
    public String getDeptType() {
        return deptType;
    }
    
    public void setDeptType(String deptType) {
        this.deptType = deptType;
    }
    
    public String getDeptIntro() {
        return deptIntro;
    }
    
    public void setDeptIntro(String deptIntro) {
        this.deptIntro = deptIntro;
    }
    
    public String getDeptLocation() {
        return deptLocation;
    }
    
    public void setDeptLocation(String deptLocation) {
        this.deptLocation = deptLocation;
    }
    
    public String getContact() {
        return contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
}

