<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin, com.safarsaga.model.Inquiry" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    Inquiry inquiry = (Inquiry) request.getAttribute("inquiry");
    if (inquiry == null) {
        response.sendRedirect("inquiryManagement");
        return;
    }
    String[] statusOptions = {"NEW","IN_PROGRESS","REPLIED","CLOSED"};
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Inquiry #<%= inquiry.getInquiryId() %> | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #e67e22; --accent2: #f39c12; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; }
        .page-header { background: linear-gradient(135deg, var(--accent), var(--accent2)); border-radius: 16px; padding: 2rem; color: white; margin-bottom: 2rem; }
        .info-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 2rem; margin-bottom: 1.5rem; }
        .info-label { font-size: 0.8rem; font-weight: 700; text-transform: uppercase; color: #888; margin-bottom: 0.2rem; }
        .info-value { font-size: 1rem; color: #333; }
        .section-title { font-size: 1rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent); border-left: 4px solid var(--accent); padding-left: 12px; margin-bottom: 1.5rem; }
        .form-control, .form-select { border-radius: 10px; border-color: #e0e0e0; }
        .form-control:focus, .form-select:focus { border-color: var(--accent); box-shadow: 0 0 0 0.2rem rgba(230,126,34,0.15); }
        .btn-update { background: linear-gradient(135deg, var(--accent), var(--accent2)); border: none; padding: 0.7rem 2rem; border-radius: 50px; font-weight: 700; color: white; }
        .btn-update:hover { color: white; opacity: 0.9; }
        .status-new { background: #fff3cd; color: #856404; }
        .status-in_progress { background: #cfe2ff; color: #084298; }
        .status-replied { background: #d1e7dd; color: #0f5132; }
        .status-closed { background: #e9ecef; color: #495057; }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-3">
                    <i class="fas fa-envelope-open-text fa-2x"></i>
                    <div>
                        <h2 class="mb-0 fw-bold">Inquiry #<%= inquiry.getInquiryId() %></h2>
                        <p class="mb-0 opacity-75">
                            Received: <%= inquiry.getCreatedAt() != null ? inquiry.getCreatedAt().toString().substring(0, 16) : "N/A" %>
                        </p>
                    </div>
                </div>
                <a href="inquiryManagement" class="btn btn-light rounded-pill px-4">
                    <i class="fas fa-arrow-left me-2"></i>Back to Inquiries
                </a>
            </div>
        </div>

        <div class="row g-4">
            <!-- Contact Info -->
            <div class="col-lg-6">
                <div class="info-card">
                    <div class="section-title">Contact Information</div>
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="info-label">Full Name</div>
                            <div class="info-value fw-bold"><%= inquiry.getFullName() %></div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">Email</div>
                            <div class="info-value">
                                <a href="mailto:<%= inquiry.getEmail() %>"><%= inquiry.getEmail() %></a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">Phone</div>
                            <div class="info-value">
                                <% if (inquiry.getPhone() != null && !inquiry.getPhone().isEmpty()) { %>
                                    <a href="tel:<%= inquiry.getPhone() %>"><%= inquiry.getPhone() %></a>
                                <% } else { %>N/A<% } %>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">Inquiry Type</div>
                            <div class="info-value">
                                <span class="badge bg-secondary"><%= inquiry.getInquiryType() != null ? inquiry.getInquiryType() : "GENERAL" %></span>
                            </div>
                        </div>
                        <% if (inquiry.getPreferredTravelDate() != null) { %>
                        <div class="col-6">
                            <div class="info-label">Preferred Travel Date</div>
                            <div class="info-value"><%= inquiry.getPreferredTravelDate() %></div>
                        </div>
                        <% } %>
                        <% if (inquiry.getNumberOfTravelers() != null && inquiry.getNumberOfTravelers() > 0) { %>
                        <div class="col-6">
                            <div class="info-label">Number of Travelers</div>
                            <div class="info-value"><%= inquiry.getNumberOfTravelers() %></div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Inquiry Details -->
            <div class="col-lg-6">
                <div class="info-card">
                    <div class="section-title">Inquiry Details</div>
                    <div class="mb-3">
                        <div class="info-label">Subject</div>
                        <div class="info-value fw-semibold"><%= inquiry.getSubject() != null ? inquiry.getSubject() : "No subject" %></div>
                    </div>
                    <div>
                        <div class="info-label">Message</div>
                        <div class="info-value" style="white-space: pre-wrap; background: #f8f9fa; padding: 1rem; border-radius: 10px; margin-top: 0.5rem;"><%
                            String msg = inquiry.getMessage();
                            if (msg != null) out.print(msg.replace("<", "&lt;").replace(">", "&gt;"));
                        %></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Status -->
        <div class="info-card">
            <div class="section-title">Update Status & Notes</div>
            <form action="<%=request.getContextPath()%>/admin/inquiryManagement" method="post">
                <input type="hidden" name="inquiryId" value="<%= inquiry.getInquiryId() %>">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Status</label>
                        <select name="status" class="form-select">
                            <% for (String s : statusOptions) { %>
                            <option value="<%= s %>" <%= s.equalsIgnoreCase(inquiry.getStatus()) ? "selected" : "" %>><%= s.replace("_"," ") %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Admin Notes / Reply</label>
                        <textarea name="adminNotes" class="form-control" rows="4" 
                                  placeholder="Add notes or reply to this inquiry..."><%= inquiry.getAdminNotes() != null ? inquiry.getAdminNotes() : "" %></textarea>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn-update">
                            <i class="fas fa-save me-2"></i>Update Inquiry
                        </button>
                        <a href="inquiryManagement?action=delete&id=<%= inquiry.getInquiryId() %>" 
                           class="btn btn-outline-danger rounded-pill ms-2"
                           onclick="return confirm('Are you sure you want to delete this inquiry?')">
                            <i class="fas fa-trash me-2"></i>Delete
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
