package com.safarsaga.dao;

import com.safarsaga.model.Blog;
import com.safarsaga.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {
    
    /** Used by admin – returns ALL blogs (published + drafts) */
    public List<Blog> getAllBlogsForAdmin() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE is_published = TRUE ORDER BY published_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
    
    public List<Blog> getFeaturedBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE is_featured = TRUE AND is_published = TRUE ORDER BY published_date DESC LIMIT 3";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
    
    public Blog getBlogById(int blogId) {
        String sql = "SELECT * FROM blogs WHERE blog_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                incrementViewCount(blogId);
                return mapResultSetToBlog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Blog getBlogBySlug(String slug) {
        String sql = "SELECT * FROM blogs WHERE slug = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, slug);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                incrementViewCount(rs.getInt("blog_id"));
                return mapResultSetToBlog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Blog> getBlogsByCategory(String category) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE category = ? AND is_published = TRUE ORDER BY published_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
    
    public boolean addBlog(Blog blog) {
        String sql = "INSERT INTO blogs (title, slug, excerpt, content, author_name, author_image, " +
                    "featured_image, category, tags, reading_time, is_featured, is_published, " +
                    "published_date, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getSlug());
            stmt.setString(3, blog.getExcerpt());
            stmt.setString(4, blog.getContent());
            stmt.setString(5, blog.getAuthorName());
            stmt.setString(6, blog.getAuthorImage());
            stmt.setString(7, blog.getFeaturedImage());
            stmt.setString(8, blog.getCategory());
            stmt.setString(9, blog.getTags());
            stmt.setInt(10, blog.getReadingTime());
            stmt.setBoolean(11, blog.isFeatured());
            stmt.setBoolean(12, blog.isPublished());
            stmt.setDate(13, blog.getPublishedDate());
            stmt.setInt(14, blog.getCreatedBy());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE blogs SET title = ?, slug = ?, excerpt = ?, content = ?, author_name = ?, " +
                    "author_image = ?, featured_image = ?, category = ?, tags = ?, reading_time = ?, " +
                    "is_featured = ?, is_published = ?, published_date = ? WHERE blog_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getSlug());
            stmt.setString(3, blog.getExcerpt());
            stmt.setString(4, blog.getContent());
            stmt.setString(5, blog.getAuthorName());
            stmt.setString(6, blog.getAuthorImage());
            stmt.setString(7, blog.getFeaturedImage());
            stmt.setString(8, blog.getCategory());
            stmt.setString(9, blog.getTags());
            stmt.setInt(10, blog.getReadingTime());
            stmt.setBoolean(11, blog.isFeatured());
            stmt.setBoolean(12, blog.isPublished());
            stmt.setDate(13, blog.getPublishedDate());
            stmt.setInt(14, blog.getBlogId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteBlog(int blogId) {
        String sql = "DELETE FROM blogs WHERE blog_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Blog> searchBlogs(String keyword) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE (title LIKE ? OR content LIKE ?) AND is_published = TRUE " +
                    "ORDER BY published_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
    
    private void incrementViewCount(int blogId) {
        String sql = "UPDATE blogs SET views_count = views_count + 1 WHERE blog_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setBlogId(rs.getInt("blog_id"));
        blog.setTitle(rs.getString("title"));
        blog.setSlug(rs.getString("slug"));
        blog.setExcerpt(rs.getString("excerpt"));
        blog.setContent(rs.getString("content"));
        blog.setAuthorName(rs.getString("author_name"));
        blog.setAuthorImage(rs.getString("author_image"));
        blog.setFeaturedImage(rs.getString("featured_image"));
        blog.setCategory(rs.getString("category"));
        blog.setTags(rs.getString("tags"));
        blog.setViewsCount(rs.getInt("views_count"));
        blog.setReadingTime(rs.getInt("reading_time"));
        blog.setFeatured(rs.getBoolean("is_featured"));
        blog.setPublished(rs.getBoolean("is_published"));
        blog.setPublishedDate(rs.getDate("published_date"));
        blog.setCreatedBy(rs.getInt("created_by"));
        blog.setCreatedAt(rs.getTimestamp("created_at"));
        blog.setUpdatedAt(rs.getTimestamp("updated_at"));
        return blog;
    }
}
