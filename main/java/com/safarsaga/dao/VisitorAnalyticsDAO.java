package com.safarsaga.dao;

import com.safarsaga.model.VisitorAnalytics;
import com.safarsaga.util.DBConnection;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class VisitorAnalyticsDAO {
    
    public boolean trackVisitor(VisitorAnalytics visitor) {
        String sql = "INSERT INTO visitor_analytics (session_id, ip_address, country, city, device_type, " +
                    "browser, operating_system, referrer_url, landing_page, pages_visited, visit_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, visitor.getSessionId());
            stmt.setString(2, visitor.getIpAddress());
            stmt.setString(3, visitor.getCountry());
            stmt.setString(4, visitor.getCity());
            stmt.setString(5, visitor.getDeviceType());
            stmt.setString(6, visitor.getBrowser());
            stmt.setString(7, visitor.getOperatingSystem());
            stmt.setString(8, visitor.getReferrerUrl());
            stmt.setString(9, visitor.getLandingPage());
            stmt.setString(10, visitor.getPagesVisited());
            stmt.setDate(11, visitor.getVisitDate());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateVisitorActivity(String sessionId, String pagesVisited, int totalPageViews) {
        String sql = "UPDATE visitor_analytics SET pages_visited = ?, total_page_views = ? WHERE session_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pagesVisited);
            stmt.setInt(2, totalPageViews);
            stmt.setString(3, sessionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getTotalVisitors() {
        String sql = "SELECT COUNT(DISTINCT session_id) FROM visitor_analytics";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTodayVisitors() {
        String sql = "SELECT COUNT(DISTINCT session_id) FROM visitor_analytics WHERE visit_date = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getThisMonthVisitors() {
        String sql = "SELECT COUNT(DISTINCT session_id) FROM visitor_analytics WHERE MONTH(visit_date) = MONTH(CURDATE()) AND YEAR(visit_date) = YEAR(CURDATE())";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Map<String, Integer> getDeviceStats() {
        Map<String, Integer> deviceStats = new HashMap<>();
        String sql = "SELECT device_type, COUNT(*) as count FROM visitor_analytics GROUP BY device_type";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                deviceStats.put(rs.getString("device_type"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deviceStats;
    }
    
    public Map<String, Integer> getTopCountries(int limit) {
        Map<String, Integer> countries = new HashMap<>();
        String sql = "SELECT country, COUNT(*) as count FROM visitor_analytics WHERE country IS NOT NULL " +
                    "GROUP BY country ORDER BY count DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                countries.put(rs.getString("country"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return countries;
    }
}
