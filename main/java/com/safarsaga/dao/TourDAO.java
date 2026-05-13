package com.safarsaga.dao;

import com.safarsaga.model.Tour;
import com.safarsaga.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {
    
    public List<Tour> getAllTours() {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public List<Tour> getToursByType(String tourType) {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE tour_type = ? AND is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tourType);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public List<Tour> getToursByState(String state) {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE state = ? AND is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, state);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public List<Tour> getToursByCountry(String country) {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE country = ? AND is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, country);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public List<Tour> getFeaturedTours() {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE is_featured = TRUE AND is_active = TRUE ORDER BY created_at DESC LIMIT 8";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public List<Tour> getTrendingTours() {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE is_trending = TRUE AND is_active = TRUE ORDER BY views_count DESC LIMIT 6";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    public Tour getTourById(int tourId) {
        String sql = "SELECT * FROM tours WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                incrementViewCount(tourId);
                return mapResultSetToTour(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addTour(Tour tour) {
        String sql = "INSERT INTO tours (tour_name, tour_type, category, state, country, destination_city, " +
                    "duration_days, duration_nights, description, detailed_itinerary, highlights, inclusions, " +
                    "exclusions, best_season, difficulty_level, image_url, gallery_images, is_featured, " +
                    "is_trending, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tour.getTourName());
            stmt.setString(2, tour.getTourType());
            stmt.setString(3, tour.getCategory());
            stmt.setString(4, tour.getState());
            stmt.setString(5, tour.getCountry());
            stmt.setString(6, tour.getDestinationCity());
            stmt.setInt(7, tour.getDurationDays());
            stmt.setInt(8, tour.getDurationNights());
            stmt.setString(9, tour.getDescription());
            stmt.setString(10, tour.getDetailedItinerary());
            stmt.setString(11, tour.getHighlights());
            stmt.setString(12, tour.getInclusions());
            stmt.setString(13, tour.getExclusions());
            stmt.setString(14, tour.getBestSeason());
            stmt.setString(15, tour.getDifficultyLevel());
            stmt.setString(16, tour.getImageUrl());
            stmt.setString(17, tour.getGalleryImages());
            stmt.setBoolean(18, tour.isFeatured());
            stmt.setBoolean(19, tour.isTrending());
            stmt.setInt(20, tour.getCreatedBy());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateTour(Tour tour) {
        String sql = "UPDATE tours SET tour_name = ?, tour_type = ?, category = ?, state = ?, country = ?, " +
                    "destination_city = ?, duration_days = ?, duration_nights = ?, description = ?, " +
                    "detailed_itinerary = ?, highlights = ?, inclusions = ?, exclusions = ?, best_season = ?, " +
                    "difficulty_level = ?, image_url = ?, gallery_images = ?, is_featured = ?, is_trending = ? " +
                    "WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tour.getTourName());
            stmt.setString(2, tour.getTourType());
            stmt.setString(3, tour.getCategory());
            stmt.setString(4, tour.getState());
            stmt.setString(5, tour.getCountry());
            stmt.setString(6, tour.getDestinationCity());
            stmt.setInt(7, tour.getDurationDays());
            stmt.setInt(8, tour.getDurationNights());
            stmt.setString(9, tour.getDescription());
            stmt.setString(10, tour.getDetailedItinerary());
            stmt.setString(11, tour.getHighlights());
            stmt.setString(12, tour.getInclusions());
            stmt.setString(13, tour.getExclusions());
            stmt.setString(14, tour.getBestSeason());
            stmt.setString(15, tour.getDifficultyLevel());
            stmt.setString(16, tour.getImageUrl());
            stmt.setString(17, tour.getGalleryImages());
            stmt.setBoolean(18, tour.isFeatured());
            stmt.setBoolean(19, tour.isTrending());
            stmt.setInt(20, tour.getTourId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteTour(int tourId) {
        String sql = "UPDATE tours SET is_active = FALSE WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Tour> searchTours(String keyword) {
        List<Tour> tours = new ArrayList<>();
        String sql = "SELECT * FROM tours WHERE (tour_name LIKE ? OR destination_city LIKE ? OR description LIKE ?) " +
                    "AND is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tours.add(mapResultSetToTour(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    private void incrementViewCount(int tourId) {
        String sql = "UPDATE tours SET views_count = views_count + 1 WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void incrementInquiryCount(int tourId) {
        String sql = "UPDATE tours SET inquiry_count = inquiry_count + 1 WHERE tour_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tourId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private Tour mapResultSetToTour(ResultSet rs) throws SQLException {
        Tour tour = new Tour();
        tour.setTourId(rs.getInt("tour_id"));
        tour.setTourName(rs.getString("tour_name"));
        tour.setTourType(rs.getString("tour_type"));
        tour.setCategory(rs.getString("category"));
        tour.setState(rs.getString("state"));
        tour.setCountry(rs.getString("country"));
        tour.setDestinationCity(rs.getString("destination_city"));
        tour.setDurationDays(rs.getInt("duration_days"));
        tour.setDurationNights(rs.getInt("duration_nights"));
        tour.setDescription(rs.getString("description"));
        tour.setDetailedItinerary(rs.getString("detailed_itinerary"));
        tour.setHighlights(rs.getString("highlights"));
        tour.setInclusions(rs.getString("inclusions"));
        tour.setExclusions(rs.getString("exclusions"));
        tour.setBestSeason(rs.getString("best_season"));
        tour.setDifficultyLevel(rs.getString("difficulty_level"));
        tour.setImageUrl(rs.getString("image_url"));
        tour.setGalleryImages(rs.getString("gallery_images"));
        tour.setFeatured(rs.getBoolean("is_featured"));
        tour.setTrending(rs.getBoolean("is_trending"));
        tour.setActive(rs.getBoolean("is_active"));
        tour.setViewsCount(rs.getInt("views_count"));
        tour.setInquiryCount(rs.getInt("inquiry_count"));
        tour.setCreatedBy(rs.getInt("created_by"));
        tour.setCreatedAt(rs.getTimestamp("created_at"));
        tour.setUpdatedAt(rs.getTimestamp("updated_at"));
        return tour;
    }
}
