package entity;

public class Task {
    private int id;
    private String time;
    private String bed;
    private String name;
    private String content;
    private int status;

    // 构造方法
    public Task(int id, String time, String bed, String name, String content, int status) {
        this.id = id;
        this.time = time;
        this.bed = bed;
        this.name = name;
        this.content = content;
        this.status = status;
    }

    // Getters (生成JSON需要)
    public int getId() { return id; }
    public String getTime() { return time; }
    public String getBed() { return bed; }
    public String getName() { return name; }
    public String getContent() { return content; }
    public int getStatus() { return status; }
}

