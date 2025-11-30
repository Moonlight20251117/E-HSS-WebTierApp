package servlet.hospital.executive;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ForumPostDAO;
import dao.ForumSectionDAO;
import dao.ForumAuditLogDAO;
import entity.ForumPost;
import entity.ForumSection;
import entity.ForumAuditLog;

/**
 * 论坛管理Servlet
 */
@WebServlet("/servlet/hospital/executive/ForumServlet")
public class ForumServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ForumPostDAO postDAO = new ForumPostDAO();
    private ForumSectionDAO sectionDAO = new ForumSectionDAO();
    private ForumAuditLogDAO auditLogDAO = new ForumAuditLogDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            // 获取帖子列表
            try {
                String statusFilter = request.getParameter("status");
                List<ForumPost> posts;
                
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    posts = postDAO.getPostsByStatus(statusFilter);
                } else {
                    posts = postDAO.getAllPosts();
                }
                
                StringBuilder json = new StringBuilder("[");
                boolean first = true;
                
                for (ForumPost post : posts) {
                    if (!first) json.append(",");
                    
                    json.append(String.format(
                        "{\"id\":\"%s\", \"title\":\"%s\", \"content\":\"%s\", " +
                        "\"author\":\"%s\", \"type\":\"%s\", \"section\":\"%s\", " +
                        "\"sectionId\":\"%s\", \"viewCount\":%d, \"replyCount\":%d, " +
                        "\"createTime\":\"%s\", \"status\":\"%s\"}",
                        escapeJson(post.getPostId()),
                        escapeJson(post.getPostTitle()),
                        escapeJson(post.getPostContent()),
                        escapeJson(post.getUserName() != null ? post.getUserName() : "未知用户"),
                        escapeJson(post.getPostType()),
                        escapeJson(post.getSectionName() != null ? post.getSectionName() : "未知板块"),
                        escapeJson(post.getSectionId()),
                        post.getViewCount(),
                        post.getReplyCount(),
                        post.getCreateTimeString(),
                        escapeJson(post.getStatus() != null ? post.getStatus() : "待审核")
                    ));
                    first = false;
                }
                json.append("]");
                out.write(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("[]");
            }
            
        } else if ("sections".equals(action)) {
            // 获取板块列表
            try {
                List<ForumSection> sections = sectionDAO.getAllSections();
                StringBuilder json = new StringBuilder("[");
                boolean first = true;
                
                for (ForumSection section : sections) {
                    if (!first) json.append(",");
                    
                    json.append(String.format(
                        "{\"id\":\"%s\", \"name\":\"%s\", \"desc\":\"%s\"}",
                        escapeJson(section.getSectionId()),
                        escapeJson(section.getSectionName()),
                        escapeJson(section.getSectionDesc() != null ? section.getSectionDesc() : "")
                    ));
                    first = false;
                }
                json.append("]");
                out.write(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("[]");
            }
            
        } else if ("create".equals(action)) {
            // 创建新帖子
            String sectionId = request.getParameter("sectionId");
            String userId = request.getParameter("userId");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String postType = request.getParameter("postType");
            String relatedOrg = request.getParameter("relatedOrg");
            
            try {
                ForumPost post = new ForumPost();
                post.setPostId("POST" + System.currentTimeMillis());
                post.setSectionId(sectionId);
                post.setUserId(userId);
                post.setPostTitle(title);
                post.setPostContent(content);
                post.setPostType(postType);
                post.setRelatedOrg(relatedOrg);
                post.setStatus("待审核");
                
                boolean success = postDAO.createPost(post);
                out.write(success ? "success" : "fail");
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("error");
            }
            
        } else if ("updateStatus".equals(action)) {
            // 更新帖子状态（审核）
            String postId = request.getParameter("postId");
            String newStatus = request.getParameter("status");
            String auditorId = request.getParameter("auditorId");
            String opinion = request.getParameter("opinion");
            
            try {
                // 获取当前状态
                ForumPost post = postDAO.getPostById(postId);
                if (post == null) {
                    out.write("post_not_found");
                    return;
                }
                
                String beforeStatus = post.getStatus();
                
                // 验证状态值是否有效
                if (newStatus == null || 
                    (!newStatus.equals("待审核") && !newStatus.equals("已发布") && 
                     !newStatus.equals("已驳回") && !newStatus.equals("已删除"))) {
                    out.write("invalid_status");
                    return;
                }
                
                // 更新状态
                boolean success = postDAO.updateStatus(postId, newStatus);
                
                if (success && auditorId != null) {
                    // 记录审核日志
                    ForumAuditLog log = new ForumAuditLog();
                    log.setLogId("AUDIT" + System.currentTimeMillis());
                    log.setPostId(postId);
                    log.setAuditorId(auditorId);
                    log.setBeforeStatus(beforeStatus);
                    log.setAfterStatus(newStatus);
                    log.setAuditOpinion(opinion);
                    auditLogDAO.createAuditLog(log);
                }
                
                out.write(success ? "success" : "fail");
                
            } catch (Exception e) {
                e.printStackTrace();
                out.write("error");
            }
        }
    }
    
    /**
     * 转义JSON字符串中的特殊字符
     */
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}

