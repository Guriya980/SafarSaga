<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.safarsaga.model.Admin, com.safarsaga.model.Blog, com.safarsaga.dao.BlogDAO" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    List<Blog> blogs = (List<Blog>) request.getAttribute("blogs");
    if (blogs == null) {
        BlogDAO blogDAO = new BlogDAO();
        blogs = blogDAO.getAllBlogsForAdmin();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blogs | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; }
        .page-header { background: linear-gradient(135deg, #764ba2, #667eea); border-radius: 16px; padding: 1.5rem 2rem; color: white; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between; }
        .btn-add { background: white; color: #764ba2; border: 2px solid white; padding: 0.5rem 1.5rem; border-radius: 50px; font-weight: 700; text-decoration: none; font-size: 0.9rem; }
        .btn-add:hover { background: #764ba2; color: white; }
        .table-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .table thead th { background: #f8f9fa; font-weight: 700; font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px; color: #666; padding: 1rem 1.2rem; border-bottom: 2px solid #e9ecef; }
        .table tbody td { padding: 1rem 1.2rem; vertical-align: middle; border-bottom: 1px solid #f5f5f5; }
        .blog-img { width: 65px; height: 45px; object-fit: cover; border-radius: 8px; }
        .btn-icon { width: 34px; height: 34px; border-radius: 8px; border: none; display: inline-flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s; }
        .btn-edit { background: #fff3cd; color: #856404; }
        .btn-edit:hover { background: #ffc107; color: white; }
        .btn-del { background: #fde8e8; color: #c0392b; }
        .btn-del:hover { background: #e74c3c; color: white; }
        .search-box { background: white; border-radius: 50px; border: 2px solid #e0e0e0; padding: 0.5rem 1rem; width: 220px; font-size: 0.85rem; }
        .empty-state { text-align: center; padding: 4rem 2rem; color: #999; }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div>
                <h2 class="mb-0 fw-bold"><i class="fas fa-pen-to-square me-2"></i>Manage Blogs</h2>
                <p class="mb-0 opacity-75 small"><%= blogs.size() %> articles published</p>
            </div>
            <a href="addBlog.jsp" class="btn-add"><i class="fas fa-plus me-1"></i> Write New Blog</a>
        </div>

        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success rounded-3 mb-3 alert-dismissible"><i class="fas fa-check-circle me-2"></i>Blog saved successfully! <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger rounded-3 mb-3 alert-dismissible"><i class="fas fa-exclamation-circle me-2"></i>Failed to save blog. <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        <% } %>

        <div class="table-card">
            <div class="p-3 border-bottom d-flex align-items-center justify-content-between">
                <h6 class="mb-0 fw-bold text-muted">All Articles</h6>
                <input type="text" class="search-box" id="blogSearch" placeholder="🔍 Search...">
            </div>
            <% if (blogs.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-pen-nib fa-4x mb-3" style="color:#ddd;"></i>
                <h5>No blogs yet</h5>
                <p>Start writing your first travel story!</p>
                <a href="addBlog.jsp" class="btn btn-primary rounded-pill mt-2">Write Now</a>
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table" id="blogsTable">
                    <thead>
                        <tr>
                            <th>Article</th>
                            <th>Category</th>
                            <th>Author</th>
                            <th>Read Time</th>
                            <th>Status</th>
                            <th>Views</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Blog blog : blogs) {
                            String imgSrc = (blog.getFeaturedImage() != null && !blog.getFeaturedImage().isEmpty()) ? request.getContextPath() + "/" + blog.getFeaturedImage() : "https://via.placeholder.com/65x45?text=Blog";
                        %>
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="<%= imgSrc %>" class="blog-img" alt="" onerror="this.src='https://via.placeholder.com/65x45?text=Blog'">
                                    <div>
                                        <div style="font-weight:700; font-size:0.9rem; max-width:220px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;"><%= blog.getTitle() %></div>
                                        <div style="font-size:0.75rem; color:#888;">/blogs?action=view&slug=<%= blog.getSlug() != null ? blog.getSlug() : "" %></div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge" style="background:rgba(118,75,162,0.12);color:#764ba2;font-size:0.72rem;"><%= blog.getCategory() != null ? blog.getCategory() : "General" %></span></td>
                            <td style="font-size:0.85rem;"><%= blog.getAuthorName() != null ? blog.getAuthorName() : "–" %></td>
                            <td style="font-size:0.85rem;"><i class="fas fa-clock text-muted me-1"></i><%= blog.getReadingTime() %> min</td>
                            <td>
                                <% if (blog.isPublished()) { %><span class="badge bg-success" style="font-size:0.7rem;">Published</span>
                                <% } else { %><span class="badge bg-secondary" style="font-size:0.7rem;">Draft</span><% } %>
                                <% if (blog.isFeatured()) { %><span class="badge bg-warning text-dark ms-1" style="font-size:0.7rem;">Featured</span><% } %>
                            </td>
                            <td style="font-size:0.85rem;"><%= blog.getViewsCount() %></td>
                            <td>
                                <div class="d-flex gap-2">
                                    <a href="<%=request.getContextPath()%>/admin/blogManagement?action=edit&id=<%= blog.getBlogId() %>" class="btn-icon btn-edit" title="Edit">
                                        <i class="fas fa-pen" style="font-size:0.8rem;"></i>
                                    </a>
                                    <a href="<%=request.getContextPath()%>/admin/blogManagement?action=delete&id=<%= blog.getBlogId() %>" class="btn-icon btn-del" title="Delete"
                                       onclick="return confirm('Delete this blog post?')">
                                        <i class="fas fa-trash" style="font-size:0.8rem;"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('blogSearch')?.addEventListener('input', function() {
        const q = this.value.toLowerCase();
        document.querySelectorAll('#blogsTable tbody tr').forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    });
</script>
</body>
</html>
