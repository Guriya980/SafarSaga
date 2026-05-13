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
    <title>Add Blog | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #764ba2; --accent2: #667eea; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; }
        .page-header { background: linear-gradient(135deg, var(--accent), var(--accent2)); border-radius: 16px; padding: 2rem; color: white; margin-bottom: 2rem; }
        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 2rem; margin-bottom: 1.5rem; }
        .section-title { font-size: 1rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent); border-left: 4px solid var(--accent); padding-left: 12px; margin-bottom: 1.5rem; }
        .form-control, .form-select { border-radius: 10px; border-color: #e0e0e0; padding: 0.6rem 1rem; }
        .form-control:focus { border-color: var(--accent); box-shadow: 0 0 0 0.2rem rgba(118,75,162,0.15); }
        .form-label { font-weight: 600; font-size: 0.875rem; color: #444; margin-bottom: 0.4rem; }
        .btn-submit { background: linear-gradient(135deg, var(--accent), var(--accent2)); border: none; padding: 0.8rem 2.5rem; border-radius: 50px; font-weight: 700; color: white; transition: all 0.3s; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(118,75,162,0.4); }
        .image-preview-box { border: 2px dashed #d0d0d0; border-radius: 12px; padding: 1rem; text-align: center; background: #fafafa; min-height: 120px; display: flex; align-items: center; justify-content: center; cursor: pointer; }
        .image-preview-box img { max-height: 110px; border-radius: 8px; max-width: 100%; }
        .gallery-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(110px, 1fr)); gap: 10px; max-height: 320px; overflow-y: auto; }
        .gallery-item { border-radius: 8px; overflow: hidden; cursor: pointer; border: 3px solid transparent; transition: all 0.2s; aspect-ratio: 4/3; }
        .gallery-item:hover, .gallery-item.selected { border-color: var(--accent); }
        .gallery-item img { width: 100%; height: 100%; object-fit: cover; }
        .word-count { font-size: 0.78rem; color: #888; }
        .switch-group { display: flex; gap: 1.5rem; }
        .form-switch .form-check-input { width: 44px; height: 22px; }
    </style>
</head>
<body>
<div class="admin-layout">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="page-header">
            <div class="d-flex align-items-center gap-3">
                <i class="fas fa-pen-to-square fa-2x"></i>
                <div>
                    <h2 class="mb-0 fw-bold">Write New Blog</h2>
                    <p class="mb-0 opacity-75">Share travel stories and inspire others</p>
                </div>
            </div>
        </div>

        <form action="<%=request.getContextPath()%>/admin/blogManagement" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">

            <!-- Title & Category -->
            <div class="form-card">
                <div class="section-title">Blog Details</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Blog Title <span class="text-danger">*</span></label>
                        <input type="text" name="title" id="titleInput" class="form-control form-control-lg" placeholder="e.g. 10 Best Beaches in Goa..." required oninput="autoSlug(this.value)">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">Select Category</option>
                            <option value="Destinations">Destinations</option>
                            <option value="Travel Tips">Travel Tips</option>
                            <option value="Adventure">Adventure</option>
                            <option value="Food & Culture">Food & Culture</option>
                            <option value="Budget Travel">Budget Travel</option>
                            <option value="Luxury Travel">Luxury Travel</option>
                            <option value="Solo Travel">Solo Travel</option>
                            <option value="Family Travel">Family Travel</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Author Name</label>
                        <input type="text" name="authorName" class="form-control" placeholder="Your name" value="SafarSaga Team">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Tags <small class="text-muted">(comma separated)</small></label>
                        <input type="text" name="tags" class="form-control" placeholder="e.g. goa, beaches, summer travel">
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="form-card">
                <div class="section-title">Content</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Short Description <span class="text-danger">*</span></label>
                        <textarea name="excerpt" class="form-control" rows="2" placeholder="A brief teaser for this blog post (shown in listings)..." required></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Blog Content <span class="text-danger">*</span></label>
                        <textarea name="content" id="contentArea" class="form-control" rows="12" placeholder="Write your travel story here..." required oninput="updateWordCount()"></textarea>
                        <div class="d-flex justify-content-between mt-1">
                            <span class="word-count" id="wordCount">0 words · ~0 min read</span>
                            <span class="word-count text-muted">Tip: Use blank lines for paragraphs</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Featured Image -->
            <div class="form-card">
                <div class="section-title">Featured Image</div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <div class="d-flex gap-2 mb-2">
                            <button type="button" class="btn btn-outline-primary rounded-pill btn-sm" onclick="openGallery()">
                                <i class="fas fa-images me-1"></i> Gallery
                            </button>
                            <button type="button" class="btn btn-outline-secondary rounded-pill btn-sm" onclick="document.getElementById('fileInput').click()">
                                <i class="fas fa-upload me-1"></i> Upload
                            </button>
                        </div>
                        <input type="file" id="fileInput" name="imageFile" class="d-none" accept="image/*" onchange="handleUpload(this)">
                        <input type="text" name="featuredImage" id="featuredImage" class="form-control" placeholder="Or paste image path: images/Goa.jpg" oninput="updatePreview(this.value)">
                    </div>
                    <div class="col-md-6">
                        <div class="image-preview-box" onclick="openGallery()">
                            <img id="previewImg" src="" alt="Preview" style="display:none;">
                            <div id="previewPlaceholder"><i class="fas fa-image fa-2x text-muted"></i><br><small class="text-muted">Click to choose</small></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Publish Settings -->
            <div class="form-card">
                <div class="section-title">Publish Settings</div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-4">
                        <label class="form-label">Published Date</label>
                        <input type="date" name="publishedDate" class="form-control" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                    <div class="col-md-8">
                        <label class="form-label d-block mb-3">Options</label>
                        <div class="switch-group">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="isPublished" id="publishCheck" checked>
                                <label class="form-check-label" for="publishCheck">Publish Now</label>
                            </div>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="featuredCheck">
                                <label class="form-check-label" for="featuredCheck">Mark as Featured</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-3 justify-content-end pb-4">
                <a href="<%=request.getContextPath()%>/admin/blogManagement" class="btn btn-light rounded-pill px-4">Cancel</a>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane me-2"></i>Publish Blog
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Gallery Modal -->
<div class="modal fade" id="galleryModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0" style="background: linear-gradient(135deg, #764ba2, #667eea); color: white; border-radius: 16px 16px 0 0;">
                <h5 class="modal-title fw-bold"><i class="fas fa-images me-2"></i>Image Gallery</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-3">
                <p class="text-muted small mb-2">Select an image from your gallery or upload a new one:</p>
                <label class="d-block mb-3 p-2 border rounded-3 text-center" style="cursor:pointer; border-style: dashed !important;">
                    <input type="file" class="d-none" accept="image/*" onchange="uploadToGallery(this)">
                    <i class="fas fa-cloud-upload-alt me-2 text-muted"></i><span class="text-muted small">Upload New Image</span>
                </label>
                <div id="galleryGrid" class="gallery-grid">
                    <div class="text-center p-4 col-12"><div class="spinner-border text-primary" role="status"></div></div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                <button class="btn text-white rounded-pill px-4" style="background: linear-gradient(135deg,#764ba2,#667eea);" onclick="useSelected()">
                    <i class="fas fa-check me-2"></i>Use Image
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedPath = '';

    function autoSlug(val) {
        // slug not visible to user but auto-generated server-side
    }

    function updateWordCount() {
        const text = document.getElementById('contentArea').value;
        const words = text.trim() ? text.trim().split(/\s+/).length : 0;
        const mins = Math.max(1, Math.round(words / 200));
        document.getElementById('wordCount').textContent = `${words} words · ~${mins} min read`;
    }

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
                if (!images.length) { grid.innerHTML = '<p class="text-center text-muted py-4">No images yet. Upload one!</p>'; return; }
                grid.innerHTML = images.map(img =>
                    `<div class="gallery-item" onclick="pick(this,'${img}')">
                        <img src="${ctx}/${img}" loading="lazy">
                    </div>`
                ).join('');
            });
    }

    function pick(el, path) {
        document.querySelectorAll('.gallery-item').forEach(i => i.classList.remove('selected'));
        el.classList.add('selected');
        selectedPath = path;
    }

    function useSelected() {
        if (!selectedPath) return;
        document.getElementById('featuredImage').value = selectedPath;
        updatePreview(selectedPath);
        bootstrap.Modal.getInstance(document.getElementById('galleryModal')).hide();
    }

    function updatePreview(path) {
        const ctx = '<%=request.getContextPath()%>';
        const img = document.getElementById('previewImg');
        const ph = document.getElementById('previewPlaceholder');
        if (path) {
            img.src = ctx + '/' + path;
            img.style.display = 'block';
            ph.style.display = 'none';
        }
    }

    function handleUpload(input) {
        if (input.files[0]) {
            document.getElementById('previewImg').src = URL.createObjectURL(input.files[0]);
            document.getElementById('previewImg').style.display = 'block';
            document.getElementById('previewPlaceholder').style.display = 'none';
        }
    }

    function uploadToGallery(input) {
        if (!input.files[0]) return;
        const ctx = '<%=request.getContextPath()%>';
        const fd = new FormData();
        fd.append('imageUpload', input.files[0]);
        fetch(ctx + '/imageGallery', { method: 'POST', body: fd })
            .then(r => r.json())
            .then(data => { if (data.path) loadGallery(); });
    }
</script>
</body>
</html>
