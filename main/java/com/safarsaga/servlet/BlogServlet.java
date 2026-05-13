package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.dao.BlogDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.safarsaga.model.Blog;
import java.util.List;

@WebServlet("/blogs")
public class BlogServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String slug = request.getParameter("slug");
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        String blogIdParam = request.getParameter("id");
        
        BlogDAO blogDAO = new BlogDAO();
        
        if ("view".equals(action) && slug != null) {
            // View single blog by slug
            Blog blog = blogDAO.getBlogBySlug(slug);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
            
        } else if (blogIdParam != null) {
            // View single blog by ID
            int blogId = Integer.parseInt(blogIdParam);
            Blog blog = blogDAO.getBlogById(blogId);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
            
        } else if (search != null && !search.trim().isEmpty()) {
            // Search blogs
            List<Blog> blogs = blogDAO.searchBlogs(search);
            request.setAttribute("blogs", blogs);
            request.setAttribute("searchKeyword", search);
            request.getRequestDispatcher("blog.jsp").forward(request, response);
            
        } else if (category != null && !category.isEmpty()) {
            // Filter by category
            List<Blog> blogs = blogDAO.getBlogsByCategory(category);
            request.setAttribute("blogs", blogs);
            request.setAttribute("selectedCategory", category);
            request.getRequestDispatcher("blog.jsp").forward(request, response);
            
        } else {
            // All blogs
            List<Blog> blogs = blogDAO.getAllBlogs();
            List<Blog> featuredBlogs = blogDAO.getFeaturedBlogs();
            request.setAttribute("blogs", blogs);
            request.setAttribute("featuredBlogs", featuredBlogs);
            request.getRequestDispatcher("blog.jsp").forward(request, response);
        }
    }
}
