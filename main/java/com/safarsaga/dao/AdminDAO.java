package com.safarsaga.dao;

import com.safarsaga.model.Admin;
import com.safarsaga.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    
    public Admin authenticate(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ? AND is_active = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                updateLastLogin(rs.getInt("admin_id"));
                return mapResultSetToAdmin(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Admin getAdminById(int adminId) {
        String sql = "SELECT * FROM admin WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToAdmin(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addAdmin(Admin admin) {
        String sql = "INSERT INTO admin (username, password, email, full_name, phone, role) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getUsername());
            stmt.setString(2, admin.getPassword());
            stmt.setString(3, admin.getEmail());
            stmt.setString(4, admin.getFullName());
            stmt.setString(5, admin.getPhone());
            stmt.setString(6, admin.getRole());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateAdmin(Admin admin) {
        String sql = "UPDATE admin SET email = ?, full_name = ?, phone = ?, role = ? WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getEmail());
            stmt.setString(2, admin.getFullName());
            stmt.setString(3, admin.getPhone());
            stmt.setString(4, admin.getRole());
            stmt.setInt(5, admin.getAdminId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean changePassword(int adminId, String newPassword) {
        String sql = "UPDATE admin SET password = ? WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, adminId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private void updateLastLogin(int adminId) {
        String sql = "UPDATE admin SET last_login = NOW() WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void logActivity(int adminId, String actionType, String description, String ipAddress) {
        String sql = "INSERT INTO admin_activity_log (admin_id, action_type, action_description, ip_address) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            stmt.setString(2, actionType);
            stmt.setString(3, description);
            stmt.setString(4, ipAddress);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private Admin mapResultSetToAdmin(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setAdminId(rs.getInt("admin_id"));
        admin.setUsername(rs.getString("username"));
        admin.setPassword(rs.getString("password"));
        admin.setEmail(rs.getString("email"));
        admin.setFullName(rs.getString("full_name"));
        admin.setPhone(rs.getString("phone"));
        admin.setRole(rs.getString("role"));
        admin.setCreatedAt(rs.getTimestamp("created_at"));
        admin.setLastLogin(rs.getTimestamp("last_login"));
        admin.setActive(rs.getBoolean("is_active"));
        return admin;
    }
}
