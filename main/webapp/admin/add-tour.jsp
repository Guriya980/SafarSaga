<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Tour | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #1a8a7a; --accent2: #27ae60; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .page-header { background: linear-gradient(135deg, var(--accent), var(--accent2)); border-radius: 16px; padding: 2rem; color: white; margin-bottom: 2rem; }
        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 2rem; margin-bottom: 1.5rem; }
        .section-title { font-size: 1rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent); border-left: 4px solid var(--accent); padding-left: 12px; margin-bottom: 1.5rem; }
        .form-control, .form-select { border-radius: 10px; border-color: #e0e0e0; padding: 0.6rem 1rem; }
        .form-control:focus, .form-select:focus { border-color: var(--accent); box-shadow: 0 0 0 0.2rem rgba(26,138,122,0.15); }
        .form-label { font-weight: 600; font-size: 0.875rem; color: #444; margin-bottom: 0.4rem; }
        .btn-submit { background: linear-gradient(135deg, var(--accent), var(--accent2)); border: none; padding: 0.8rem 2.5rem; border-radius: 50px; font-weight: 700; font-size: 1rem; color: white; transition: all 0.3s; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(26,138,122,0.4); }
        .image-preview-box { border: 2px dashed #d0d0d0; border-radius: 12px; padding: 1rem; text-align: center; background: #fafafa; min-height: 140px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: border-color 0.3s; }
        .image-preview-box:hover { border-color: var(--accent); }
        .image-preview-box img { max-height: 120px; max-width: 100%; object-fit: cover; border-radius: 8px; display: none; }
        .gallery-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 10px; max-height: 350px; overflow-y: auto; padding: 0.5rem; }
        .gallery-item { border-radius: 8px; overflow: hidden; cursor: pointer; border: 3px solid transparent; transition: all 0.2s; aspect-ratio: 4/3; }
        .gallery-item:hover { border-color: var(--accent); transform: scale(1.03); }
        .gallery-item.selected { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(26,138,122,0.3); }
        .gallery-item img { width: 100%; height: 100%; object-fit: cover; }
        .upload-zone { border: 2px dashed #d0d0d0; border-radius: 12px; padding: 1.5rem; text-align: center; cursor: pointer; transition: all 0.3s; }
        .upload-zone:hover { border-color: var(--accent); background: rgba(26,138,122,0.04); }
        .badge-check { display: inline-flex; align-items: center; gap: 8px; background: #f0faf0; border: 1.5px solid #c3e6cb; border-radius: 50px; padding: 0.5rem 1.2rem; cursor: pointer; font-weight: 600; font-size: 0.875rem; transition: all 0.2s; }
        .badge-check input { display: none; }
        .badge-check:has(input:checked) { background: #d4edda; border-color: var(--accent2); color: var(--accent); }
        .badge-check .dot { width: 16px; height: 16px; border-radius: 50%; border: 2px solid #aaa; transition: all 0.2s; }
        .badge-check:has(input:checked) .dot { background: var(--accent2); border-color: var(--accent2); }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div class="d-flex align-items-center gap-3">
                <i class="fas fa-map-marked-alt fa-2x"></i>
                <div>
                    <h2 class="mb-0 fw-bold">Add New Tour</h2>
                    <p class="mb-0 opacity-75">Create an amazing travel experience</p>
                </div>
            </div>
        </div>

        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger rounded-3 mb-3"><i class="fas fa-exclamation-circle me-2"></i>Failed to add tour. Please check all fields.</div>
        <% } %>

        <form action="<%=request.getContextPath()%>/tourManagement" method="post" enctype="multipart/form-data" id="tourForm">
            <input type="hidden" name="action" value="add">

            <!-- Basic Info -->
            <div class="form-card">
                <div class="section-title">Basic Information</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Tour Name <span class="text-danger">*</span></label>
                        <input type="text" name="tourName" class="form-control" placeholder="e.g. Kerala Backwaters Bliss" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tour Type <span class="text-danger">*</span></label>
                        <select name="tourType" class="form-select" required>
                            <option value="">Select Type</option>
                            <option value="DOMESTIC">🇮🇳 Domestic</option>
                            <option value="INTERNATIONAL">🌍 International</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">Select Category</option>
                            <option value="Adventure">Adventure</option>
                            <option value="Beach">Beach</option>
                            <option value="Heritage">Heritage</option>
                            <option value="Hill Station">Hill Station</option>
                            <option value="Wildlife">Wildlife</option>
                            <option value="Honeymoon">Honeymoon</option>
                            <option value="Family">Family</option>
                            <option value="Pilgrimage">Pilgrimage</option>
                            <option value="Budget">Budget</option>
                            <option value="Luxury">Luxury</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Best Season</label>
                        <select name="bestSeason" class="form-select">
                            <option value="">Select Season</option>
                            <option value="Year Round">Year Round</option>
                            <option value="Summer (Mar-Jun)">Summer (Mar-Jun)</option>
                            <option value="Monsoon (Jul-Sep)">Monsoon (Jul-Sep)</option>
                            <option value="Winter (Oct-Feb)">Winter (Oct-Feb)</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">State</label>
                        <input type="text" name="state" class="form-control" placeholder="e.g. Kerala, Rajasthan">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Country</label>
                        <input type="text" name="country" class="form-control" placeholder="e.g. India" value="India">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Destination City</label>
                        <input type="text" name="destinationCity" class="form-control" placeholder="e.g. Alleppey, Jaisalmer">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Duration (Days) <span class="text-danger">*</span></label>
                        <input type="number" name="durationDays" class="form-control" min="1" max="60" placeholder="7" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Duration (Nights)</label>
                        <input type="number" name="durationNights" class="form-control" min="0" max="60" placeholder="6">
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="form-card">
                <div class="section-title">Tour Description</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Short Description <span class="text-danger">*</span></label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Brief overview of the tour..." required></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Detailed Itinerary</label>
                        <textarea name="detailedItinerary" class="form-control" rows="6" placeholder="Day 1: Arrive at...&#10;Day 2: Visit..."></textarea>
                        <small class="text-muted">Describe day-by-day activities</small>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Tour Highlights</label>
                        <textarea name="highlights" class="form-control" rows="4" placeholder="• Visit Alleppey backwaters&#10;• Houseboat experience&#10;• Kathakali show"></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Inclusions</label>
                        <textarea name="inclusions" class="form-control" rows="4" placeholder="• Hotel accommodation&#10;• Breakfast & Dinner&#10;• Airport transfers"></textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Exclusions</label>
                        <textarea name="exclusions" class="form-control" rows="4" placeholder="• Air/Rail tickets&#10;• Personal expenses&#10;• Travel insurance"></textarea>
                    </div>
                </div>
            </div>

            <!-- Image -->
            <div class="form-card">
                <div class="section-title">Tour Image</div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Select from Gallery or Upload</label>
                        <div class="d-flex gap-2 mb-2">
                            <button type="button" class="btn btn-outline-primary rounded-pill btn-sm" onclick="openGallery()">
                                <i class="fas fa-images me-1"></i> Choose from Gallery
                            </button>
                            <button type="button" class="btn btn-outline-secondary rounded-pill btn-sm" onclick="document.getElementById('fileInput').click()">
                                <i class="fas fa-upload me-1"></i> Upload New
                            </button>
                        </div>
                        <input type="file" id="fileInput" name="imageFile" class="d-none" accept="image/*" onchange="handleFileUpload(this)">
                        <input type="text" name="imageUrl" id="imageUrl" class="form-control mt-2" placeholder="Or type image path: images/Goa.jpg" oninput="updatePreview(this.value)">
                        <small class="text-muted">Images are stored in webapp/images/ folder</small>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Preview</label>
                        <div class="image-preview-box" id="previewBox" onclick="openGallery()">
                            <img id="previewImg" src="" alt="Preview">
                            <div id="previewPlaceholder">
                                <i class="fas fa-image fa-3x text-muted mb-2"></i><br>
                                <span class="text-muted small">Click to choose image</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Options -->
            <div class="form-card">
                <div class="section-title">Tour Options</div>
                <div class="d-flex flex-wrap gap-3">
                    <label class="badge-check">
                        <input type="checkbox" name="isFeatured">
                        <span class="dot"></span>
                        <i class="fas fa-star text-warning"></i> Featured Tour
                    </label>
                    <label class="badge-check">
                        <input type="checkbox" name="isTrending">
                        <span class="dot"></span>
                        <i class="fas fa-fire text-danger"></i> Trending Tour
                    </label>
                </div>
            </div>

            <!-- Submit -->
            <div class="d-flex gap-3 justify-content-end pb-4">
                <a href="<%=request.getContextPath()%>/tourManagement" class="btn btn-light rounded-pill px-4">Cancel</a>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-rocket me-2"></i>Add Tour
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Gallery Modal -->
<div class="modal fade" id="galleryModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0" style="background: linear-gradient(135deg, #1a8a7a, #27ae60); color: white; border-radius: 16px 16px 0 0;">
                <h5 class="modal-title fw-bold"><i class="fas fa-images me-2"></i>Image Gallery</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-3">
                <!-- Upload new image in modal -->
                <div class="upload-zone mb-3" onclick="document.getElementById('modalFileInput').click()">
                    <input type="file" id="modalFileInput" class="d-none" accept="image/*" onchange="uploadFromModal(this)">
                    <i class="fas fa-cloud-upload-alt fa-2x text-muted mb-2"></i>
                    <p class="text-muted small mb-0">Click to upload a new image to gallery</p>
                </div>
                <div id="galleryGrid" class="gallery-grid">
                    <div class="text-center p-4 col-12">
                        <div class="spinner-border text-success" role="status"></div>
                        <p class="text-muted mt-2">Loading images...</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                <button class="btn btn-success rounded-pill px-4" onclick="selectGalleryImage()">
                    <i class="fas fa-check me-2"></i>Use Selected Image
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
        const ctx = '<%=request.getContextPath()%>';
        fetch(ctx + '/imageGallery')
            .then(r => r.json())
            .then(images => {
                const grid = document.getElementById('galleryGrid');
                if (!images.length) {
                    grid.innerHTML = '<p class="text-muted text-center py-3">No images found. Upload one above.</p>';
                    return;
                }
                grid.innerHTML = images.map(img =>
                    `<div class="gallery-item" onclick="highlightImage(this, '${img}')">
                        <img src="<%=request.getContextPath()%>/${img}" alt="${img}" loading="lazy">
                    </div>`
                ).join('');
            })
            .catch(() => {
                document.getElementById('galleryGrid').innerHTML =
                    '<p class="text-danger text-center py-3">Could not load gallery.</p>';
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
        updatePreview(selectedGalleryPath);
        bootstrap.Modal.getInstance(document.getElementById('galleryModal')).hide();
    }

    function updatePreview(path) {
        const img = document.getElementById('previewImg');
        const placeholder = document.getElementById('previewPlaceholder');
        if (path) {
            img.src = '../' + path;
            img.style.display = 'block';
            placeholder.style.display = 'none';
        } else {
            img.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    function handleFileUpload(input) {
        if (!input.files[0]) return;
        const url = URL.createObjectURL(input.files[0]);
        document.getElementById('previewImg').src = url;
        document.getElementById('previewImg').style.display = 'block';
        document.getElementById('previewPlaceholder').style.display = 'none';
    }

    function uploadFromModal(input) {
        if (!input.files[0]) return;
        const fd = new FormData();
        fd.append('imageUpload', input.files[0]);
        fetch(ctx + '/imageGallery', { method: 'POST', body: fd })
            .then(r => r.json())
            .then(data => { if (data.path) loadGallery(); })
            .catch(() => {});
    }

    // Auto-fill nights from days
    document.querySelector('[name="durationDays"]').addEventListener('input', function() {
        const nights = document.querySelector('[name="durationNights"]');
        if (!nights.value) nights.value = Math.max(0, parseInt(this.value || 0) - 1);
    });
</script>
</body>
</html>
