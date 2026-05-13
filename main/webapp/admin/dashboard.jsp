<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin, com.safarsaga.dao.*" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) { response.sendRedirect(request.getContextPath() + "/admin-login.jsp"); return; }

    TourDAO tourDAO = new TourDAO();
    BlogDAO blogDAO = new BlogDAO();
    InquiryDAO inquiryDAO = new InquiryDAO();
    VisitorAnalyticsDAO analyticsDAO = new VisitorAnalyticsDAO();

    int totalTours    = tourDAO.getAllTours().size();
    int totalBlogs    = blogDAO.getAllBlogsForAdmin().size();
    int totalInq      = inquiryDAO.getInquiryCount();
    int newInq        = inquiryDAO.getNewInquiryCount();
    int totalVis      = analyticsDAO.getTotalVisitors();
    int todayVis      = analyticsDAO.getTodayVisitors();
    int monthVis      = analyticsDAO.getThisMonthVisitors();

    java.util.List<com.safarsaga.model.Tour> popularTours = tourDAO.getFeaturedTours();
    java.util.List<com.safarsaga.model.Blog> featuredBlogs = blogDAO.getFeaturedBlogs();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SafarSaga</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #1a8a7a; --accent2: #27ae60; }
        * { box-sizing: border-box; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; margin: 0; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .page-header { background: linear-gradient(135deg, #1a1a2e, #16213e); border-radius: 16px; padding: 1.5rem 2rem; color: white; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between; }
        .page-header h2 { margin: 0; font-size: 1.6rem; font-weight: 800; }
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.2rem; margin-bottom: 2rem; }
        .stat-card { border-radius: 16px; padding: 1.4rem 1.6rem; color: white; box-shadow: 0 6px 20px rgba(0,0,0,0.12); position: relative; overflow: hidden; }
        .stat-card .bg-icon { position: absolute; right: -10px; top: 50%; transform: translateY(-50%); font-size: 4rem; opacity: 0.15; }
        .stat-card h3 { font-size: 2.4rem; font-weight: 900; margin: 0 0 4px 0; }
        .stat-card p { margin: 0; font-size: 0.8rem; opacity: 0.85; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-card .stat-link { display: inline-block; margin-top: 0.8rem; font-size: 0.78rem; color: rgba(255,255,255,0.75); text-decoration: none; border-top: 1px solid rgba(255,255,255,0.2); padding-top: 0.6rem; width: 100%; }
        .stat-card .stat-link:hover { color: white; }
        .s1 { background: linear-gradient(135deg, #3b82f6, #1d4ed8); }
        .s2 { background: linear-gradient(135deg, #22c55e, #15803d); }
        .s3 { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .s4 { background: linear-gradient(135deg, #06b6d4, #0e7490); }
        .content-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem; }
        .panel { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.07); overflow: hidden; }
        .panel-header { padding: 1rem 1.4rem; font-weight: 700; font-size: 0.95rem; display: flex; align-items: center; gap: 8px; }
        .ph-blue { background: #eff6ff; color: #1d4ed8; border-bottom: 2px solid #dbeafe; }
        .ph-green { background: #f0fdf4; color: #15803d; border-bottom: 2px solid #dcfce7; }
        .panel table { width: 100%; border-collapse: collapse; }
        .panel table thead th { background: #f8f9fa; font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.5px; color: #666; padding: 0.6rem 1.2rem; font-weight: 700; border-bottom: 1px solid #f0f0f0; }
        .panel table tbody td { padding: 0.7rem 1.2rem; border-bottom: 1px solid #f5f5f5; font-size: 0.85rem; }
        .panel table tbody tr:last-child td { border-bottom: none; }
        .quick-actions { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.07); padding: 1.4rem; margin-bottom: 1.5rem; }
        .qa-title { font-weight: 700; font-size: 1rem; color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 8px; }
        .qa-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.9rem; }
        .qa-btn { display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 6px; padding: 1rem; border-radius: 12px; text-decoration: none; font-size: 0.8rem; font-weight: 700; transition: all 0.2s; border: 2px solid transparent; }
        .qa-btn:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .qa-btn i { font-size: 1.4rem; }
        .qa-a { background: #eff6ff; color: #1d4ed8; border-color: #dbeafe; }
        .qa-b { background: #f0fdf4; color: #15803d; border-color: #dcfce7; }
        .qa-c { background: #fffbeb; color: #d97706; border-color: #fef3c7; }
        .qa-d { background: #ecfdf5; color: #0e7490; border-color: #cffafe; }
        .badge-sm { padding: 0.2rem 0.6rem; border-radius: 50px; font-size: 0.68rem; font-weight: 700; }
        @media (max-width: 992px) { .stats-grid { grid-template-columns: 1fr 1fr; } .content-row { grid-template-columns: 1fr; } .qa-grid { grid-template-columns: 1fr 1fr; } }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">

        <!-- Header -->
        <div class="page-header">
            <div>
                <h2><i class="fas fa-tachometer-alt me-2" style="color:#27ae60;"></i>Dashboard Overview</h2>
                <p class="mb-0" style="opacity:0.55; font-size:0.82rem; margin-top:4px;">
                    Welcome back, <strong><%= admin.getFullName() %></strong>
                </p>
            </div>
            <div style="font-size:0.8rem; color:rgba(255,255,255,0.45);">
                <i class="fas fa-calendar me-1"></i> <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card s1">
                <i class="fas fa-plane bg-icon"></i>
                <p>Total Tours</p>
                <h3><%= totalTours %></h3>
                <a href="<%=request.getContextPath()%>/tourManagement" class="stat-link">Manage Tours <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="stat-card s2">
                <i class="fas fa-blog bg-icon"></i>
                <p>Total Blogs</p>
                <h3><%= totalBlogs %></h3>
                <a href="<%=request.getContextPath()%>/admin/blogManagement" class="stat-link">Manage Blogs <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="stat-card s3">
                <i class="fas fa-envelope bg-icon"></i>
                <p>New Inquiries</p>
                <h3><%= newInq %></h3>
                <a href="<%=request.getContextPath()%>/admin/inquiryManagement" class="stat-link">View All (<%= totalInq %>) <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
            <div class="stat-card s4">
                <i class="fas fa-users bg-icon"></i>
                <p>Total Visitors</p>
                <h3><%= totalVis %></h3>
                <span class="stat-link" style="cursor:default;">Today: <%= todayVis %> · Month: <%= monthVis %></span>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <div class="qa-title"><i class="fas fa-bolt"></i> Quick Actions</div>
            <div class="qa-grid">
                <a href="<%=request.getContextPath()%>/admin/add-tour.jsp" class="qa-btn qa-a">
                    <i class="fas fa-plus-circle"></i> Add New Tour
                </a>
                <a href="<%=request.getContextPath()%>/admin/addBlog.jsp" class="qa-btn qa-b">
                    <i class="fas fa-feather-alt"></i> Write Blog
                </a>
                <a href="<%=request.getContextPath()%>/admin/inquiryManagement" class="qa-btn qa-c">
                    <i class="fas fa-envelope-open"></i> View Inquiries
                    <% if (newInq > 0) { %><span class="badge-sm" style="background:#d97706;color:white;"><%= newInq %> new</span><% } %>
                </a>
                <a href="<%=request.getContextPath()%>/index.jsp" class="qa-btn qa-d" target="_blank">
                    <i class="fas fa-external-link-alt"></i> View Website
                </a>
            </div>
        </div>

        <!-- Tables Row -->
        <div class="content-row">
            <!-- Popular Tours -->
            <div class="panel">
                <div class="panel-header ph-blue">
                    <i class="fas fa-star"></i> Popular Tours
                </div>
                <% if (popularTours.isEmpty()) { %>
                <p class="text-center text-muted py-4 mb-0" style="font-size:0.85rem;">No tours added yet.</p>
                <% } else { %>
                <table>
                    <thead><tr><th>Tour Name</th><th>Views</th><th>Inquiries</th></tr></thead>
                    <tbody>
                    <% for (int i = 0; i < Math.min(6, popularTours.size()); i++) {
                        com.safarsaga.model.Tour t = popularTours.get(i); %>
                    <tr>
                        <td style="font-weight:600;">
                            <%= t.getTourName().length() > 28 ? t.getTourName().substring(0,28)+"…" : t.getTourName() %>
                            <div style="font-size:0.72rem;color:#aaa;"><%= t.getTourType() %></div>
                        </td>
                        <td><span class="badge-sm" style="background:#dbeafe;color:#1d4ed8;"><%= t.getViewsCount() %></span></td>
                        <td><span class="badge-sm" style="background:#dcfce7;color:#15803d;"><%= t.getInquiryCount() %></span></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } %>
            </div>

            <!-- Featured Blogs -->
            <div class="panel">
                <div class="panel-header ph-green">
                    <i class="fas fa-fire"></i> Featured Blogs
                </div>
                <% if (featuredBlogs.isEmpty()) { %>
                <p class="text-center text-muted py-4 mb-0" style="font-size:0.85rem;">No featured blogs yet.</p>
                <% } else { %>
                <table>
                    <thead><tr><th>Blog Title</th><th>Views</th><th>Category</th></tr></thead>
                    <tbody>
                    <% for (com.safarsaga.model.Blog b : featuredBlogs) { %>
                    <tr>
                        <td style="font-weight:600;">
                            <%= b.getTitle().length() > 28 ? b.getTitle().substring(0,28)+"…" : b.getTitle() %>
                        </td>
                        <td><span class="badge-sm" style="background:#cffafe;color:#0e7490;"><%= b.getViewsCount() %></span></td>
                        <td><span class="badge-sm" style="background:#f1f5f9;color:#475569;"><%= b.getCategory() != null ? b.getCategory() : "–" %></span></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } %>
            </div>
        </div>

    </div><!-- /main-content -->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
