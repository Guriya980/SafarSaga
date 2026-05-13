package com.safarsaga.dao;

import com.safarsaga.model.Inquiry;
import com.safarsaga.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InquiryDAO {
    
    public boolean addInquiry(Inquiry inquiry) {
        String sql = "INSERT INTO inquiries (full_name, email, phone, country_code, subject, message, " +
                    "inquiry_type, tour_id, preferred_travel_date, number_of_travelers, ip_address, user_agent) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, inquiry.getFullName());
            stmt.setString(2, inquiry.getEmail());
            stmt.setString(3, inquiry.getPhone());
            stmt.setString(4, inquiry.getCountryCode());
            stmt.setString(5, inquiry.getSubject());
            stmt.setString(6, inquiry.getMessage());
            stmt.setString(7, inquiry.getInquiryType());
            if (inquiry.getTourId() != null) {
                stmt.setInt(8, inquiry.getTourId());
            } else {
                stmt.setNull(8, Types.INTEGER);
            }
            stmt.setDate(9, inquiry.getPreferredTravelDate());
            if (inquiry.getNumberOfTravelers() != null) {
                stmt.setInt(10, inquiry.getNumberOfTravelers());
            } else {
                stmt.setNull(10, Types.INTEGER);
            }
            stmt.setString(11, inquiry.getIpAddress());
            stmt.setString(12, inquiry.getUserAgent());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Inquiry> getAllInquiries() {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM inquiries ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                inquiries.add(mapResultSetToInquiry(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    public List<Inquiry> getNewInquiries() {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM inquiries WHERE status = 'NEW' ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                inquiries.add(mapResultSetToInquiry(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    public Inquiry getInquiryById(int inquiryId) {
        String sql = "SELECT * FROM inquiries WHERE inquiry_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToInquiry(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updateInquiryStatus(int inquiryId, String status, String adminNotes, int repliedBy) {
        String sql = "UPDATE inquiries SET status = ?, admin_notes = ?, replied_by = ?, replied_at = NOW() WHERE inquiry_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, adminNotes);
            stmt.setInt(3, repliedBy);
            stmt.setInt(4, inquiryId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteInquiry(int inquiryId) {
        String sql = "DELETE FROM inquiries WHERE inquiry_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, inquiryId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getInquiryCount() {
        String sql = "SELECT COUNT(*) FROM inquiries";
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
    
    public int getNewInquiryCount() {
        String sql = "SELECT COUNT(*) FROM inquiries WHERE status = 'NEW'";
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
    
    private Inquiry mapResultSetToInquiry(ResultSet rs) throws SQLException {
        Inquiry inquiry = new Inquiry();
        inquiry.setInquiryId(rs.getInt("inquiry_id"));
        inquiry.setFullName(rs.getString("full_name"));
        inquiry.setEmail(rs.getString("email"));
        inquiry.setPhone(rs.getString("phone"));
        inquiry.setCountryCode(rs.getString("country_code"));
        inquiry.setSubject(rs.getString("subject"));
        inquiry.setMessage(rs.getString("message"));
        inquiry.setInquiryType(rs.getString("inquiry_type"));
        inquiry.setTourId(rs.getInt("tour_id"));
        inquiry.setPreferredTravelDate(rs.getDate("preferred_travel_date"));
        inquiry.setNumberOfTravelers(rs.getInt("number_of_travelers"));
        inquiry.setStatus(rs.getString("status"));
        inquiry.setAdminNotes(rs.getString("admin_notes"));
        inquiry.setRepliedBy(rs.getInt("replied_by"));
        inquiry.setRepliedAt(rs.getTimestamp("replied_at"));
        inquiry.setIpAddress(rs.getString("ip_address"));
        inquiry.setUserAgent(rs.getString("user_agent"));
        inquiry.setCreatedAt(rs.getTimestamp("created_at"));
        return inquiry;
    }
}
