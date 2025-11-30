package entity;

/**
 * 护士实体类
 * 对应数据库中的 nurse 表
 */
public class Nurse {
    private String nurseId;
    private String userId;
    private String deptId;
    private String title;
    private String nurseIntro;
    private int status;
    
    // 关联查询字段
    private String deptName;
    private String userName;
    
    // 构造函数
    public Nurse() {}
    
    // Getters and Setters
    public String getNurseId() {
        return nurseId;
    }
    
    public void setNurseId(String nurseId) {
        this.nurseId = nurseId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getDeptId() {
        return deptId;
    }
    
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getNurseIntro() {
        return nurseIntro;
    }
    
    public void setNurseIntro(String nurseIntro) {
        this.nurseIntro = nurseIntro;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
}

