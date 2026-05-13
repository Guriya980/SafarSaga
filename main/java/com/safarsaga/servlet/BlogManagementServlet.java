package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.*;
import java.sql.Date;
import java.util.List;
import com.safarsaga.dao.BlogDAO;
import com.safarsaga.model.Blog;

@WebServlet("/admin/blogManagement")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,
    maxRequestSize = 25 * 1024 * 1024
)
public class BlogManagementServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        BlogDAO blogDAO = new BlogDAO();

        if ("edit".equals(action)) {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.getBlogById(blogId);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("edit-blog.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int blogId = Integer.parseInt(request.getParameter("id"));
            blogDAO.deleteBlog(blogId);

            int adminId = (int) session.getAttribute("adminId");
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, "DELETE_BLOG", "Deleted blog ID: " + blogId, request.getRemoteAddr());

            response.sendRedirect("blogManagement");
        } else {
            List<Blog> blogs = blogDAO.getAllBlogsForAdmin();
            request.setAttribute("blogs", blogs);
            request.getRequestDispatcher("manage-blogs.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        BlogDAO blogDAO = new BlogDAO();
        int adminId = (int) session.getAttribute("adminId");

        Blog blog = new Blog();
        String title = request.getParameter("title");
        blog.setTitle(title);

        // Auto-generate slug from title
        String slug = request.getParameter("slug");
        if (slug == null || slug.trim().isEmpty()) {
            slug = title != null ? title.toLowerCase()
                    .replaceAll("[^a-z0-9\\s-]", "")
                    .replaceAll("\\s+", "-")
                    .replaceAll("-+", "-")
                    .trim() : "blog-" + System.currentTimeMillis();
        }
        blog.setSlug(slug);

        blog.setExcerpt(request.getParameter("excerpt"));
        blog.setContent(request.getParameter("content"));
        blog.setAuthorName(request.getParameter("authorName"));
        blog.setCategory(request.getParameter("category"));
        blog.setTags(request.getParameter("tags"));

        // Auto-calculate reading time (~200 words/min)
        String content = request.getParameter("content");
        int wordCount = content != null ? content.split("\\s+").length : 0;
        int readingTime = Math.max(1, wordCount / 200);
        blog.setReadingTime(readingTime);

        blog.setFeatured("on".equals(request.getParameter("isFeatured")));
        blog.setPublished("on".equals(request.getParameter("isPublished")));

        // Published date
        String pubDateStr = request.getParameter("publishedDate");
        if (pubDateStr != null && !pubDateStr.isEmpty()) {
            blog.setPublishedDate(Date.valueOf(pubDateStr));
        } else {
            blog.setPublishedDate(new Date(System.currentTimeMillis()));
        }

        // Featured image: file upload OR gallery URL
        String featuredImage = request.getParameter("featuredImage");
        try {
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                fileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
                String uploadDir = getServletContext().getRealPath("") + File.separator + "images";
                new File(uploadDir).mkdirs();
                try (InputStream is = filePart.getInputStream()) {
                    Files.copy(is, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
                }
                featuredImage = "images/" + fileName;
            }
        } catch (Exception ignored) {}
        
        blog.setFeaturedImage(featuredImage != null ? featuredImage : "");
        blog.setAuthorImage("images/default-author.jpg");

        boolean success = false;
        String logAction = "";

        if ("add".equals(action)) {
            blog.setCreatedBy(adminId);
            success = blogDAO.addBlog(blog);
            logAction = "ADD_BLOG";
        } else if ("update".equals(action)) {
            blog.setBlogId(Integer.parseInt(request.getParameter("blogId")));
            success = blogDAO.updateBlog(blog);
            logAction = "UPDATE_BLOG";
        }

        if (success) {
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, logAction, "Blog: " + blog.getTitle(), request.getRemoteAddr());
            response.sendRedirect("blogManagement?success=true");
        } else {
            response.sendRedirect("blogManagement?error=true");
        }
    }
}
