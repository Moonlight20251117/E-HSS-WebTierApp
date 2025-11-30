package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.ForumSection;
import util.DBUtil;

/**
 * 论坛板块数据访问对象
 */
public class ForumSectionDAO {
    
    /**
     * 获取所有启用的板块
     * @return 板块列表
     */
    public List<ForumSection> getAllSections() {
        List<ForumSection> list = new ArrayList<>();
        String sql = "SELECT section_id, section_name, section_desc, sort_order, status, create_time " +
                     "FROM forum_section " +
                     "WHERE status = 1 " +
                     "ORDER BY sort_order ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ForumSection section = new ForumSection();
                section.setSectionId(rs.getString("section_id"));
                section.setSectionName(rs.getString("section_name"));
                section.setSectionDesc(rs.getString("section_desc"));
                section.setSortOrder(rs.getInt("sort_order"));
                section.setStatus(rs.getInt("status"));
                section.setCreateTime(rs.getTimestamp("create_time"));
                
                list.add(section);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * 根据ID获取板块
     * @param sectionId 板块ID
     * @return 板块对象
     */
    public ForumSection getSectionById(String sectionId) {
        String sql = "SELECT section_id, section_name, section_desc, sort_order, status, create_time " +
                     "FROM forum_section " +
                     "WHERE section_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sectionId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ForumSection section = new ForumSection();
                section.setSectionId(rs.getString("section_id"));
                section.setSectionName(rs.getString("section_name"));
                section.setSectionDesc(rs.getString("section_desc"));
                section.setSortOrder(rs.getInt("sort_order"));
                section.setStatus(rs.getInt("status"));
                section.setCreateTime(rs.getTimestamp("create_time"));
                
                return section;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

