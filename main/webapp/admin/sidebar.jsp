<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin" %>
<%
    String cp = request.getContextPath();
    String uri = request.getRequestURI();
    Admin sidebarAdmin = (Admin) session.getAttribute("admin");
    String adminName = sidebarAdmin != null ? sidebarAdmin.getFullName() : "Admin";
    char adminInitial = adminName.length() > 0 ? adminName.charAt(0) : 'A';
%>
<style>
    .admin-sidebar {
        width: 240px; min-height: 100vh; flex-shrink: 0;
        background: linear-gradient(180deg, #1a1a2e 0%, #16213e 55%, #0f3460 100%);
        display: flex; flex-direction: column;
        box-shadow: 4px 0 20px rgba(0,0,0,0.2);
        position: sticky; top: 0; height: 100vh; overflow-y: auto;
    }
    .sidebar-brand {
        padding: 1.5rem 1.2rem 1rem;
        border-bottom: 1px solid rgba(255,255,255,0.07);
    }
    .brand-text { font-size: 1.3rem; font-weight: 800; color: white; }
    .brand-text .green { color: #27ae60; }
    .brand-sub { font-size: 0.68rem; color: rgba(255,255,255,0.35); margin-top: 2px; }
    .sidebar-label {
        font-size: 0.62rem; text-transform: uppercase; letter-spacing: 2px;
        color: rgba(255,255,255,0.3); padding: 1.2rem 1.2rem 0.4rem; font-weight: 700;
    }
    .sidebar-nav { padding: 0.3rem 0; flex: 1; }
    .sidebar-link {
        display: flex; align-items: center; gap: 10px;
        padding: 0.7rem 1.2rem; color: rgba(255,255,255,0.62);
        text-decoration: none; font-size: 0.875rem; font-weight: 500;
        transition: all 0.2s; border-left: 3px solid transparent;
    }
    .sidebar-link:hover { color: white; background: rgba(255,255,255,0.06); }
    .sidebar-link.active {
        color: white; background: rgba(39,174,96,0.15);
        border-left-color: #27ae60;
    }
    .sidebar-link .icon-wrap {
        width: 32px; height: 32px; border-radius: 9px;
        display: flex; align-items: center; justify-content: center;
        font-size: 0.85rem; background: rgba(255,255,255,0.05);
        transition: background 0.2s; flex-shrink: 0;
    }
    .sidebar-link:hover .icon-wrap, .sidebar-link.active .icon-wrap {
        background: rgba(39,174,96,0.22); color: #27ae60;
    }
    .sidebar-footer {
        padding: 1rem 1.2rem; border-top: 1px solid rgba(255,255,255,0.07);
    }
    .admin-badge {
        background: rgba(255,255,255,0.05); border-radius: 10px;
        padding: 0.7rem 0.9rem; display: flex; align-items: center; gap: 10px;
    }
    .admin-avatar {
        width: 34px; height: 34px; border-radius: 9px;
        background: linear-gradient(135deg, #1a8a7a, #27ae60);
        display: flex; align-items: center; justify-content: center;
        color: white; font-weight: 800; font-size: 0.9rem; flex-shrink: 0;
    }
    .admin-info .name { font-size: 0.82rem; font-weight: 700; color: white; }
    .admin-info .role { font-size: 0.68rem; color: rgba(255,255,255,0.38); }
    .sidebar-link.logout-link { color: rgba(231,76,60,0.7); }
    .sidebar-link.logout-link:hover { color: #e74c3c; background: rgba(231,76,60,0.08); }
</style>

<aside class="admin-sidebar">
    <div class="sidebar-brand">
        <div class="brand-text">Safar<span class="green">Saga</span></div>
        <div class="brand-sub">Admin Dashboard</div>
    </div>

    <nav class="sidebar-nav">
        <div class="sidebar-label">Main Menu</div>
        <a href="<%=cp%>/admin/dashboard" class="sidebar-link <%=uri.contains("dashboard")?"active":""%>">
            <span class="icon-wrap"><i class="fas fa-tachometer-alt"></i></span> Dashboard
        </a>
        <a href="<%=cp%>/tourManagement" class="sidebar-link <%=uri.contains("tour")?"active":""%>">
            <span class="icon-wrap"><i class="fas fa-map-marked-alt"></i></span> Manage Tours
        </a>
        <a href="<%=cp%>/admin/blogManagement" class="sidebar-link <%=uri.contains("blog")?"active":""%>">
            <span class="icon-wrap"><i class="fas fa-pen-to-square"></i></span> Manage Blogs
        </a>
        <a href="<%=cp%>/admin/inquiryManagement" class="sidebar-link <%=uri.contains("inquiry")?"active":""%>">
            <span class="icon-wrap"><i class="fas fa-envelope-open-text"></i></span> Inquiries
        </a>

        <div class="sidebar-label">Quick Actions</div>
        <a href="<%=cp%>/admin/add-tour.jsp" class="sidebar-link">
            <span class="icon-wrap"><i class="fas fa-plus"></i></span> Add New Tour
        </a>
        <a href="<%=cp%>/admin/addBlog.jsp" class="sidebar-link">
            <span class="icon-wrap"><i class="fas fa-feather-alt"></i></span> Write Blog
        </a>

        <div class="sidebar-label">Website</div>
        <a href="<%=cp%>/index.jsp" class="sidebar-link" target="_blank">
            <span class="icon-wrap"><i class="fas fa-external-link-alt"></i></span> View Website
        </a>
        <a href="<%=cp%>/adminLogout" class="sidebar-link logout-link">
            <span class="icon-wrap"><i class="fas fa-sign-out-alt"></i></span> Logout
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="admin-badge">
            <div class="admin-avatar"><%=adminInitial%></div>
            <div class="admin-info">
                <div class="name"><%=adminName%></div>
                <div class="role">Administrator</div>
            </div>
        </div>
    </div>
</aside>
