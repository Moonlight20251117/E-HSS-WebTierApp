package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.ForumPost;
import util.DBUtil;

/**
 * 论坛帖子数据访问对象
 */
public class ForumPostDAO {
    
    /**
     * 获取所有帖子（关联查询板块和用户信息）
     * @return 帖子列表
     */
    public List<ForumPost> getAllPosts() {
        List<ForumPost> list = new ArrayList<>();
        String sql = "SELECT p.post_id, p.section_id, p.user_id, p.post_title, " +
                     "p.post_content, p.post_type, p.related_org, p.view_count, " +
                     "p.reply_count, p.status, p.create_time, p.update_time, " +
                     "s.section_name, u.real_name as user_name " +
                     "FROM forum_post p " +
                     "LEFT JOIN forum_section s ON p.section_id = s.section_id " +
                     "LEFT JOIN user u ON p.user_id = u.user_id " +
                     "ORDER BY p.create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ForumPost post = new ForumPost();
                post.setPostId(rs.getString("post_id"));
                post.setSectionId(rs.getString("section_id"));
                post.setUserId(rs.getString("user_id"));
                post.setPostTitle(rs.getString("post_title"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostType(rs.getString("post_type"));
                post.setRelatedOrg(rs.getString("related_org"));
                post.setViewCount(rs.getInt("view_count"));
                post.setReplyCount(rs.getInt("reply_count"));
                post.setStatus(rs.getString("status"));
                post.setCreateTime(rs.getTimestamp("create_time"));
                post.setUpdateTime(rs.getTimestamp("update_time"));
                post.setSectionName(rs.getString("section_name"));
                post.setUserName(rs.getString("user_name"));
                
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * 根据状态获取帖子列表
     * @param status 状态（待审核/已发布/已驳回/已删除）
     * @return 帖子列表
     */
    public List<ForumPost> getPostsByStatus(String status) {
        List<ForumPost> list = new ArrayList<>();
        String sql = "SELECT p.post_id, p.section_id, p.user_id, p.post_title, " +
                     "p.post_content, p.post_type, p.related_org, p.view_count, " +
                     "p.reply_count, p.status, p.create_time, p.update_time, " +
                     "s.section_name, u.real_name as user_name " +
                     "FROM forum_post p " +
                     "LEFT JOIN forum_section s ON p.section_id = s.section_id " +
                     "LEFT JOIN user u ON p.user_id = u.user_id " +
                     "WHERE p.status = ? " +
                     "ORDER BY p.create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ForumPost post = new ForumPost();
                post.setPostId(rs.getString("post_id"));
                post.setSectionId(rs.getString("section_id"));
                post.setUserId(rs.getString("user_id"));
                post.setPostTitle(rs.getString("post_title"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostType(rs.getString("post_type"));
                post.setRelatedOrg(rs.getString("related_org"));
                post.setViewCount(rs.getInt("view_count"));
                post.setReplyCount(rs.getInt("reply_count"));
                post.setStatus(rs.getString("status"));
                post.setCreateTime(rs.getTimestamp("create_time"));
                post.setUpdateTime(rs.getTimestamp("update_time"));
                post.setSectionName(rs.getString("section_name"));
                post.setUserName(rs.getString("user_name"));
                
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * 根据ID获取帖子
     * @param postId 帖子ID
     * @return 帖子对象
     */
    public ForumPost getPostById(String postId) {
        String sql = "SELECT p.post_id, p.section_id, p.user_id, p.post_title, " +
                     "p.post_content, p.post_type, p.related_org, p.view_count, " +
                     "p.reply_count, p.status, p.create_time, p.update_time, " +
                     "s.section_name, u.real_name as user_name " +
                     "FROM forum_post p " +
                     "LEFT JOIN forum_section s ON p.section_id = s.section_id " +
                     "LEFT JOIN user u ON p.user_id = u.user_id " +
                     "WHERE p.post_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, postId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ForumPost post = new ForumPost();
                post.setPostId(rs.getString("post_id"));
                post.setSectionId(rs.getString("section_id"));
                post.setUserId(rs.getString("user_id"));
                post.setPostTitle(rs.getString("post_title"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostType(rs.getString("post_type"));
                post.setRelatedOrg(rs.getString("related_org"));
                post.setViewCount(rs.getInt("view_count"));
                post.setReplyCount(rs.getInt("reply_count"));
                post.setStatus(rs.getString("status"));
                post.setCreateTime(rs.getTimestamp("create_time"));
                post.setUpdateTime(rs.getTimestamp("update_time"));
                post.setSectionName(rs.getString("section_name"));
                post.setUserName(rs.getString("user_name"));
                
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * 创建新帖子
     * @param post 帖子对象
     * @return 是否创建成功
     */
    public boolean createPost(ForumPost post) {
        String sql = "INSERT INTO forum_post (post_id, section_id, user_id, post_title, " +
                     "post_content, post_type, related_org, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, post.getPostId());
            ps.setString(2, post.getSectionId());
            ps.setString(3, post.getUserId());
            ps.setString(4, post.getPostTitle());
            ps.setString(5, post.getPostContent());
            ps.setString(6, post.getPostType());
            ps.setString(7, post.getRelatedOrg());
            ps.setString(8, post.getStatus());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 更新帖子状态
     * @param postId 帖子ID
     * @param newStatus 新状态（待审核/已发布/已驳回/已删除）
     * @return 是否更新成功
     */
    public boolean updateStatus(String postId, String newStatus) {
        String sql = "UPDATE forum_post SET status = ? WHERE post_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setString(2, postId);
            
            int rowsAffected = ps.executeUpdate();
            
            conn.commit();
            
            if (rowsAffected == 0) {
                System.err.println("警告：没有行被更新，可能postId不存在: " + postId);
            }
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("更新帖子状态失败 - postId: " + postId + ", newStatus: " + newStatus);
            e.printStackTrace();
            
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * 增加浏览次数
     * @param postId 帖子ID
     * @return 是否更新成功
     */
    public boolean incrementViewCount(String postId) {
        String sql = "UPDATE forum_post SET view_count = view_count + 1 WHERE post_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, postId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

