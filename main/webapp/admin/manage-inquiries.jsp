<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.safarsaga.model.Admin, com.safarsaga.model.Inquiry, com.safarsaga.dao.InquiryDAO" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    List<Inquiry> inquiries = (List<Inquiry>) request.getAttribute("inquiries");
    if (inquiries == null) {
        InquiryDAO inquiryDAO = new InquiryDAO();
        inquiries = inquiryDAO.getAllInquiries();
    }
    long newCount = inquiries.stream().filter(i -> "NEW".equals(i.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Inquiries | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #e67e22; --accent2: #f39c12; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .page-header { background: linear-gradient(135deg, var(--accent), var(--accent2)); border-radius: 16px; padding: 1.5rem 2rem; color: white; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between; }
        .table-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .table thead th { background: #f8f9fa; font-weight: 700; font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px; color: #666; padding: 1rem 1.2rem; border-bottom: 2px solid #e9ecef; }
        .table tbody td { padding: 0.85rem 1.2rem; vertical-align: middle; border-bottom: 1px solid #f5f5f5; font-size: 0.9rem; }
        .badge-new { background: #fff3cd; color: #856404; }
        .badge-in_progress { background: #cfe2ff; color: #084298; }
        .badge-replied { background: #d1e7dd; color: #0f5132; }
        .badge-closed { background: #e9ecef; color: #495057; }
        .badge-status { padding: 0.3rem 0.8rem; border-radius: 50px; font-size: 0.72rem; font-weight: 700; }
        .btn-icon { width: 32px; height: 32px; border-radius: 8px; border: none; display: inline-flex; align-items: center; justify-content: center; font-size: 0.8rem; cursor: pointer; transition: all 0.2s; text-decoration: none; }
        .btn-view { background: #e3f2fd; color: #1565c0; }
        .btn-view:hover { background: #1565c0; color: white; }
        .btn-del { background: #fde8e8; color: #c0392b; }
        .btn-del:hover { background: #e74c3c; color: white; }
        .stat-badge { background: white; color: var(--accent); padding: 0.3rem 1rem; border-radius: 50px; font-weight: 700; font-size: 0.85rem; }
        .search-box { background: white; border-radius: 50px; border: 2px solid #e0e0e0; padding: 0.5rem 1rem; width: 230px; font-size: 0.85rem; }
        .search-box:focus { border-color: var(--accent); outline: none; }
        .empty-state { text-align: center; padding: 4rem 2rem; color: #999; }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div>
                <h2 class="mb-0 fw-bold"><i class="fas fa-envelope-open-text me-2"></i>Inquiries</h2>
                <p class="mb-0 opacity-75 small"><%= inquiries.size() %> total &bull; <%= newCount %> new</p>
            </div>
            <% if (newCount > 0) { %>
            <span class="stat-badge"><i class="fas fa-bell me-1"></i><%= newCount %> New</span>
            <% } %>
        </div>

        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success rounded-3 mb-3 alert-dismissible"><i class="fas fa-check-circle me-2"></i>Inquiry updated successfully! <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        <% } %>

        <div class="table-card">
            <div class="p-3 border-bottom d-flex align-items-center justify-content-between">
                <h6 class="mb-0 fw-bold text-muted">All Inquiries</h6>
                <input type="text" class="search-box" id="inqSearch" placeholder="🔍 Search...">
            </div>
            <% if (inquiries.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-inbox fa-4x mb-3" style="color:#ddd;"></i>
                <h5>No inquiries yet</h5>
                <p>Inquiries from your contact form will appear here.</p>
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table" id="inqTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Subject</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Inquiry inq : inquiries) {
                        String statusLower = inq.getStatus() != null ? inq.getStatus().toLowerCase() : "new";
                        String dateStr = inq.getCreatedAt() != null ? inq.getCreatedAt().toString().substring(0, 10) : "N/A";
                    %>
                    <tr class="<%= "NEW".equals(inq.getStatus()) ? "table-warning" : "" %>">
                        <td class="text-muted" style="font-size:0.8rem;">#<%= inq.getInquiryId() %></td>
                        <td style="font-weight:600;"><%= inq.getFullName() %></td>
                        <td>
                            <div style="font-size:0.82rem;"><%= inq.getEmail() %></div>
                            <% if (inq.getPhone() != null && !inq.getPhone().isEmpty()) { %>
                            <div style="font-size:0.78rem; color:#888;"><%= inq.getPhone() %></div>
                            <% } %>
                        </td>
                        <td style="max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                            <%= inq.getSubject() != null ? inq.getSubject() : "–" %>
                        </td>
                        <td><span class="badge bg-secondary" style="font-size:0.7rem;"><%= inq.getInquiryType() != null ? inq.getInquiryType() : "GENERAL" %></span></td>
                        <td><span class="badge-status badge-<%= statusLower %>"><%= inq.getStatus() != null ? inq.getStatus().replace("_"," ") : "NEW" %></span></td>
                        <td style="font-size:0.82rem; color:#888;"><%= dateStr %></td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="<%=request.getContextPath()%>/admin/inquiryManagement?action=view&id=<%= inq.getInquiryId() %>" class="btn-icon btn-view" title="View & Reply">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="<%=request.getContextPath()%>/admin/inquiryManagement?action=delete&id=<%= inq.getInquiryId() %>" class="btn-icon btn-del" title="Delete"
                                   onclick="return confirm('Delete inquiry from <%= inq.getFullName().replace("'","\'") %>?')">
                                    <i class="fas fa-trash"></i>
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
    document.getElementById('inqSearch')?.addEventListener('input', function() {
        const q = this.value.toLowerCase();
        document.querySelectorAll('#inqTable tbody tr').forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    });
</script>
</body>
</html>
