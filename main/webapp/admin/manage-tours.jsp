<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.safarsaga.model.Admin, com.safarsaga.model.Tour, com.safarsaga.dao.TourDAO" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    List<Tour> tours = (List<Tour>) request.getAttribute("tours");
    if (tours == null) {
        TourDAO tourDAO = new TourDAO();
        tours = tourDAO.getAllTours();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Tours | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #1a8a7a; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; }
        .page-header { background: linear-gradient(135deg, var(--accent), #27ae60); border-radius: 16px; padding: 1.5rem 2rem; color: white; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between; }
        .stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
        .stat-card { background: white; border-radius: 14px; padding: 1.2rem 1.5rem; box-shadow: 0 2px 12px rgba(0,0,0,0.07); text-align: center; }
        .stat-card h3 { font-size: 2rem; font-weight: 800; color: var(--accent); margin: 0; }
        .stat-card p { color: #666; margin: 0; font-size: 0.85rem; }
        .table-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .table-card .table { margin: 0; }
        .table thead th { background: #f8f9fa; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px; color: #666; border-bottom: 2px solid #e9ecef; padding: 1rem 1.2rem; }
        .table tbody td { padding: 1rem 1.2rem; vertical-align: middle; border-bottom: 1px solid #f0f0f0; }
        .tour-img { width: 60px; height: 45px; object-fit: cover; border-radius: 8px; }
        .tour-name { font-weight: 700; color: #222; font-size: 0.95rem; }
        .tour-loc { font-size: 0.8rem; color: #888; }
        .badge-type { font-size: 0.7rem; padding: 0.3rem 0.7rem; border-radius: 50px; }
        .btn-icon { width: 34px; height: 34px; border-radius: 8px; border: none; display: inline-flex; align-items: center; justify-content: center; font-size: 0.85rem; cursor: pointer; transition: all 0.2s; }
        .btn-edit { background: #fff3cd; color: #856404; }
        .btn-edit:hover { background: #ffc107; color: white; }
        .btn-del { background: #fde8e8; color: #c0392b; }
        .btn-del:hover { background: #e74c3c; color: white; }
        .btn-add { background: white; color: var(--accent); border: 2px solid white; padding: 0.5rem 1.5rem; border-radius: 50px; font-weight: 700; text-decoration: none; font-size: 0.9rem; }
        .btn-add:hover { background: var(--accent); color: white; }
        .search-box { background: white; border-radius: 50px; border: 2px solid #e0e0e0; padding: 0.5rem 1rem; width: 250px; font-size: 0.9rem; }
        .search-box:focus { border-color: var(--accent); outline: none; }
        .empty-state { text-align: center; padding: 4rem 2rem; color: #999; }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <!-- Header -->
        <div class="page-header">
            <div>
                <h2 class="mb-0 fw-bold"><i class="fas fa-map-marked-alt me-2"></i>Manage Tours</h2>
                <p class="mb-0 opacity-75 small"><%= tours.size() %> tours in database</p>
            </div>
            <a href="add-tour.jsp" class="btn-add"><i class="fas fa-plus me-1"></i> Add New Tour</a>
        </div>

        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success alert-dismissible rounded-3 mb-3">
            <i class="fas fa-check-circle me-2"></i>Tour saved successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger alert-dismissible rounded-3 mb-3">
            <i class="fas fa-exclamation-circle me-2"></i>Failed to save tour.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <h3><%= tours.size() %></h3>
                <p>Total Tours</p>
            </div>
            <div class="stat-card">
                <h3><%= tours.stream().filter(t -> "DOMESTIC".equals(t.getTourType())).count() %></h3>
                <p>Domestic</p>
            </div>
            <div class="stat-card">
                <h3><%= tours.stream().filter(t -> "INTERNATIONAL".equals(t.getTourType())).count() %></h3>
                <p>International</p>
            </div>
            <div class="stat-card">
                <h3><%= tours.stream().filter(t -> t.isFeatured()).count() %></h3>
                <p>Featured</p>
            </div>
        </div>

        <!-- Search + Table -->
        <div class="table-card">
            <div class="p-3 border-bottom d-flex align-items-center justify-content-between">
                <h6 class="mb-0 fw-bold text-muted">All Tours</h6>
                <input type="text" class="search-box" id="searchInput" placeholder="🔍 Search tours...">
            </div>
            <% if (tours.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-map-marked-alt fa-4x mb-3" style="color: #ddd;"></i>
                <h5>No tours yet</h5>
                <p>Click "Add New Tour" to create your first tour.</p>
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table" id="toursTable">
                    <thead>
                        <tr>
                            <th>Tour</th>
                            <th>Type</th>
                            <th>Destination</th>
                            <th>Duration</th>
                            <th>Views</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Tour tour : tours) {
                            String imgUrl = (tour.getImageUrl() != null && !tour.getImageUrl().isEmpty()) ? request.getContextPath() + "/" + tour.getImageUrl() : "https://via.placeholder.com/60x45?text=Tour";
                        %>
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="<%= imgUrl %>" class="tour-img" alt="<%= tour.getTourName() %>" onerror="this.src='https://via.placeholder.com/60x45?text=Tour'">
                                    <div>
                                        <div class="tour-name"><%= tour.getTourName() %></div>
                                        <div class="tour-loc"><i class="fas fa-tag me-1"></i><%= tour.getCategory() != null ? tour.getCategory() : "General" %></div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-type <%= "DOMESTIC".equals(tour.getTourType()) ? "bg-primary" : "bg-success" %>">
                                    <%= tour.getTourType() %>
                                </span>
                            </td>
                            <td>
                                <span class="fw-600"><%= tour.getDestinationCity() != null ? tour.getDestinationCity() : "" %></span><br>
                                <small class="text-muted"><%= tour.getState() != null ? tour.getState() : tour.getCountry() != null ? tour.getCountry() : "" %></small>
                            </td>
                            <td><span class="fw-bold"><%= tour.getDurationDays() %>D</span> / <%= tour.getDurationNights() %>N</td>
                            <td><i class="fas fa-eye text-muted me-1"></i><%= tour.getViewsCount() %></td>
                            <td>
                                <% if (tour.isFeatured()) { %><span class="badge bg-warning text-dark me-1" style="font-size:0.65rem;"><i class="fas fa-star"></i> Featured</span><% } %>
                                <% if (tour.isTrending()) { %><span class="badge bg-danger" style="font-size:0.65rem;"><i class="fas fa-fire"></i> Trending</span><% } %>
                                <% if (!tour.isFeatured() && !tour.isTrending()) { %><span class="text-muted small">Active</span><% } %>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <!-- FIX: use servlet URL not JSP directly -->
                                    <a href="<%=request.getContextPath()%>/tourManagement?action=edit&id=<%= tour.getTourId() %>" class="btn-icon btn-edit" title="Edit">
                                        <i class="fas fa-pen"></i>
                                    </a>
                                    <a href="<%=request.getContextPath()%>/tourManagement?action=delete&id=<%= tour.getTourId() %>" class="btn-icon btn-del" title="Delete"
                                       onclick="return confirm('Delete \'<%= tour.getTourName().replace("'","") %>\'?')">
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
    document.getElementById('searchInput')?.addEventListener('input', function() {
        const q = this.value.toLowerCase();
        document.querySelectorAll('#toursTable tbody tr').forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    });
</script>
</body>
</html>
