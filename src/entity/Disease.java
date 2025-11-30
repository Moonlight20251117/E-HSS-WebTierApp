package entity;

/**
 * 疾病实体类
 * 对应数据库中的 disease 表
 */
public class Disease {
    private String diseaseId;
    private String diseaseName;
    private String diseaseCode;
    private String diseaseType;
    private String infectLevel;
    private String diseaseDesc;
    
    // 构造函数
    public Disease() {}
    
    // Getters and Setters
    public String getDiseaseId() {
        return diseaseId;
    }
    
    public void setDiseaseId(String diseaseId) {
        this.diseaseId = diseaseId;
    }
    
    public String getDiseaseName() {
        return diseaseName;
    }
    
    public void setDiseaseName(String diseaseName) {
        this.diseaseName = diseaseName;
    }
    
    public String getDiseaseCode() {
        return diseaseCode;
    }
    
    public void setDiseaseCode(String diseaseCode) {
        this.diseaseCode = diseaseCode;
    }
    
    public String getDiseaseType() {
        return diseaseType;
    }
    
    public void setDiseaseType(String diseaseType) {
        this.diseaseType = diseaseType;
    }
    
    public String getInfectLevel() {
        return infectLevel;
    }
    
    public void setInfectLevel(String infectLevel) {
        this.infectLevel = infectLevel;
    }
    
    public String getDiseaseDesc() {
        return diseaseDesc;
    }
    
    public void setDiseaseDesc(String diseaseDesc) {
        this.diseaseDesc = diseaseDesc;
    }
}

