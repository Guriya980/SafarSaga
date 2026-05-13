<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin, com.safarsaga.model.Tour" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    Tour tour = (Tour) request.getAttribute("tour");
    if (tour == null) {
        response.sendRedirect(request.getContextPath() + "/tourManagement");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Tour | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #1a8a7a; --accent2: #27ae60; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .page-header { background: linear-gradient(135deg, #e67e22, #f39c12); border-radius: 16px; padding: 2rem; color: white; margin-bottom: 2rem; }
        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 2rem; margin-bottom: 1.5rem; }
        .section-title { font-size: 1rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent); border-left: 4px solid var(--accent); padding-left: 12px; margin-bottom: 1.5rem; }
        .form-control, .form-select { border-radius: 10px; border-color: #e0e0e0; padding: 0.6rem 1rem; }
        .form-control:focus, .form-select:focus { border-color: var(--accent); box-shadow: 0 0 0 0.2rem rgba(26,138,122,0.15); }
        .form-label { font-weight: 600; font-size: 0.875rem; color: #444; margin-bottom: 0.4rem; }
        .btn-submit { background: linear-gradient(135deg, #e67e22, #f39c12); border: none; padding: 0.8rem 2.5rem; border-radius: 50px; font-weight: 700; font-size: 1rem; color: white; transition: all 0.3s; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(230,126,34,0.4); }
        .image-preview-box { border: 2px dashed #d0d0d0; border-radius: 12px; padding: 1rem; text-align: center; background: #fafafa; min-height: 140px; display: flex; align-items: center; justify-content: center; cursor: pointer; }
        .image-preview-box img { max-height: 120px; max-width: 100%; object-fit: cover; border-radius: 8px; }
        .gallery-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 10px; max-height: 350px; overflow-y: auto; }
        .gallery-item { border-radius: 8px; overflow: hidden; cursor: pointer; border: 3px solid transparent; transition: all 0.2s; aspect-ratio: 4/3; }
        .gallery-item:hover { border-color: var(--accent); }
        .gallery-item.selected { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(26,138,122,0.3); }
        .gallery-item img { width: 100%; height: 100%; object-fit: cover; }
        .badge-check { display: inline-flex; align-items: center; gap: 8px; background: #f0faf0; border: 1.5px solid #c3e6cb; border-radius: 50px; padding: 0.5rem 1.2rem; cursor: pointer; font-weight: 600; font-size: 0.875rem; }
        .badge-check input { display: none; }
        .badge-check:has(input:checked) { background: #d4edda; border-color: var(--accent2); color: var(--accent); }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div class="d-flex align-items-center gap-3">
                <i class="fas fa-edit fa-2x"></i>
                <div>
                    <h2 class="mb-0 fw-bold">Edit Tour</h2>
                    <p class="mb-0 opacity-75"><%= tour.getTourName() %></p>
                </div>
            </div>
        </div>

        <form action="<%=request.getContextPath()%>/tourManagement" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="tourId" value="<%= tour.getTourId() %>">

            <!-- Basic Info -->
            <div class="form-card">
                <div class="section-title">Basic Information</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Tour Name *</label>
                        <input type="text" name="tourName" class="form-control" value="<%= tour.getTourName() %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tour Type *</label>
                        <select name="tourType" class="form-select" required>
                            <option value="DOMESTIC" <%= "DOMESTIC".equals(tour.getTourType()) ? "selected" : "" %>>🇮🇳 Domestic</option>
                            <option value="INTERNATIONAL" <%= "INTERNATIONAL".equals(tour.getTourType()) ? "selected" : "" %>>🌍 International</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">Select Category</option>
                            <% String[] cats = {"Adventure","Beach","Heritage","Hill Station","Wildlife","Honeymoon","Family","Pilgrimage","Budget","Luxury"};
                               for(String c : cats){ %>
                            <option value="<%= c %>" <%= c.equals(tour.getCategory()) ? "selected" : "" %>><%= c %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Best Season</label>
                        <select name="bestSeason" class="form-select">
                            <option value="">Select Season</option>
                            <% String[] seasons = {"Year Round","Summer (Mar-Jun)","Monsoon (Jul-Sep)","Winter (Oct-Feb)"};
                               for(String s : seasons){ %>
                            <option value="<%= s %>" <%= s.equals(tour.getBestSeason()) ? "selected" : "" %>><%= s %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">State</label>
                        <input type="text" name="state" class="form-control" value="<%= tour.getState() != null ? tour.getState() : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Country</label>
                        <input type="text" name="country" class="form-control" value="<%= tour.getCountry() != null ? tour.getCountry() : "" %>">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Destination City</label>
                        <input type="text" name="destinationCity" class="form-control" value="<%= tour.getDestinationCity() != null ? tour.getDestinationCity() : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Duration (Days) *</label>
                        <input type="number" name="durationDays" class="form-control" min="1" value="<%= tour.getDurationDays() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Duration (Nights)</label>
                        <input type="number" name="durationNights" class="form-control" min="0" value="<%= tour.getDurationNights() %>">
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="form-card">
                <div class="section-title">Tour Description</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Short Description *</label>
                        <textarea name="description" class="form-control" rows="3" required><%= tour.getDescription() != null ? tour.getDescription() : "" %></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Detailed Itinerary</label>
                        <textarea name="detailedItinerary" class="form-control" rows="6"><%= tour.getDetailedItinerary() != null ? tour.getDetailedItinerary() : "" %></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Tour Highlights</label>
                        <textarea name="highlights" class="form-control" rows="4"><%= tour.getHighlights() != null ? tour.getHighlights() : "" %></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Inclusions</label>
                        <textarea name="inclusions" class="form-control" rows="4"><%= tour.getInclusions() != null ? tour.getInclusions() : "" %></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Exclusions</label>
                        <textarea name="exclusions" class="form-control" rows="4"><%= tour.getExclusions() != null ? tour.getExclusions() : "" %></textarea>
                    </div>
                </div>
            </div>

            <!-- Image -->
            <div class="form-card">
                <div class="section-title">Tour Image</div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Change Image</label>
                        <div class="d-flex gap-2 mb-2">
                            <button type="button" class="btn btn-outline-primary rounded-pill btn-sm" onclick="openGallery()">
                                <i class="fas fa-images me-1"></i> Gallery
                            </button>
                            <button type="button" class="btn btn-outline-secondary rounded-pill btn-sm" onclick="document.getElementById('fileInput').click()">
                                <i class="fas fa-upload me-1"></i> Upload New
                            </button>
                        </div>
                        <input type="file" id="fileInput" name="imageFile" class="d-none" accept="image/*" onchange="handleFileUpload(this)">
                        <input type="text" name="imageUrl" id="imageUrl" class="form-control mt-2"
                               value="<%= tour.getImageUrl() != null ? tour.getImageUrl() : "" %>"
                               oninput="updatePreview(this.value)">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Current Image</label>
                        <div class="image-preview-box" onclick="openGallery()">
                            <img id="previewImg" src="<%=request.getContextPath()%>/<%= tour.getImageUrl() != null ? tour.getImageUrl() : "" %>" alt="Preview"
                                 onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Options -->
            <div class="form-card">
                <div class="section-title">Tour Options</div>
                <div class="d-flex flex-wrap gap-3">
                    <label class="badge-check">
                        <input type="checkbox" name="isFeatured" <%= tour.isFeatured() ? "checked" : "" %>>
                        <i class="fas fa-star text-warning"></i> Featured Tour
                    </label>
                    <label class="badge-check">
                        <input type="checkbox" name="isTrending" <%= tour.isTrending() ? "checked" : "" %>>
                        <i class="fas fa-fire text-danger"></i> Trending Tour
                    </label>
                </div>
            </div>

            <div class="d-flex gap-3 justify-content-end pb-4">
                <a href="<%=request.getContextPath()%>/tourManagement" class="btn btn-light rounded-pill px-4">Cancel</a>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save me-2"></i>Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Gallery Modal -->
<div class="modal fade" id="galleryModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0" style="background: linear-gradient(135deg, #e67e22, #f39c12); color: white; border-radius: 16px 16px 0 0;">
                <h5 class="modal-title fw-bold"><i class="fas fa-images me-2"></i>Image Gallery</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-3">
                <div id="galleryGrid" class="gallery-grid">
                    <div class="text-center p-4"><div class="spinner-border text-warning"></div></div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                <button class="btn rounded-pill px-4 text-white" style="background: linear-gradient(135deg, #e67e22, #f39c12);" onclick="selectGalleryImage()">
                    <i class="fas fa-check me-2"></i>Use Image
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedGalleryPath = '';

    function openGallery() {
        loadGallery();
        new bootstrap.Modal(document.getElementById('galleryModal')).show();
    }

    function loadGallery() {
        fetch('<%=request.getContextPath()%>/imageGallery')
            .then(r => r.json())
            .then(images => {
                const grid = document.getElementById('galleryGrid');
                if (!images.length) { grid.innerHTML = '<p class="text-muted text-center p-4">No images found.</p>'; return; }
                grid.innerHTML = images.map(img =>
                    `<div class="gallery-item" onclick="highlightImage(this,'${img}')">
                        <img src="<%=request.getContextPath()%>/${img}" loading="lazy">
                    </div>`
                ).join('');
            });
    }

    function highlightImage(el, path) {
        document.querySelectorAll('.gallery-item').forEach(i => i.classList.remove('selected'));
        el.classList.add('selected');
        selectedGalleryPath = path;
    }

    function selectGalleryImage() {
        if (!selectedGalleryPath) return;
        document.getElementById('imageUrl').value = selectedGalleryPath;
        document.getElementById('previewImg').src = '../' + selectedGalleryPath;
        bootstrap.Modal.getInstance(document.getElementById('galleryModal')).hide();
    }

    function updatePreview(path) {
        if (path) document.getElementById('previewImg').src = '../' + path;
    }

    function handleFileUpload(input) {
        if (input.files[0]) {
            document.getElementById('previewImg').src = URL.createObjectURL(input.files[0]);
        }
    }
</script>
</body>
</html>
