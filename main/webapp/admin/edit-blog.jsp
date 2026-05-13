<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Admin, com.safarsaga.model.Blog" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }
    Blog blog = (Blog) request.getAttribute("blog");
    if (blog == null) {
        response.sendRedirect("blogManagement");
        return;
    }
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String pubDate = blog.getPublishedDate() != null ? sdf.format(blog.getPublishedDate()) : sdf.format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Blog | SafarSaga Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root { --accent: #764ba2; --accent2: #667eea; }
        body { background: #f0f4f8; font-family: 'Segoe UI', sans-serif; }
        .admin-layout { display: flex; min-height: 100vh; }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .page-header { background: linear-gradient(135deg, var(--accent), var(--accent2)); border-radius: 16px; padding: 2rem; color: white; margin-bottom: 2rem; }
        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 2rem; margin-bottom: 1.5rem; }
        .section-title { font-size: 1rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent); border-left: 4px solid var(--accent); padding-left: 12px; margin-bottom: 1.5rem; }
        .form-control, .form-select { border-radius: 10px; border-color: #e0e0e0; padding: 0.6rem 1rem; }
        .form-control:focus { border-color: var(--accent); box-shadow: 0 0 0 0.2rem rgba(118,75,162,0.15); }
        .form-label { font-weight: 600; font-size: 0.875rem; color: #444; margin-bottom: 0.4rem; }
        .btn-submit { background: linear-gradient(135deg, var(--accent), var(--accent2)); border: none; padding: 0.8rem 2.5rem; border-radius: 50px; font-weight: 700; color: white; transition: all 0.3s; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(118,75,162,0.4); color: white; }
        .image-preview-box { border: 2px dashed #d0d0d0; border-radius: 12px; padding: 1rem; text-align: center; background: #fafafa; min-height: 120px; display: flex; align-items: center; justify-content: center; cursor: pointer; }
        .image-preview-box img { max-height: 110px; border-radius: 8px; max-width: 100%; }
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
                    <h2 class="mb-0 fw-bold">Edit Blog Post</h2>
                    <p class="mb-0 opacity-75">Update your travel story</p>
                </div>
            </div>
        </div>

        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger rounded-3 mb-3"><i class="fas fa-exclamation-circle me-2"></i>Failed to update blog. Please try again.</div>
        <% } %>

        <form action="<%=request.getContextPath()%>/admin/blogManagement" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="blogId" value="<%= blog.getBlogId() %>">

            <!-- Title & Category -->
            <div class="form-card">
                <div class="section-title">Blog Details</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Blog Title <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control form-control-lg" value="<%= blog.getTitle() != null ? blog.getTitle().replace("\"", "&quot;") : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Slug (URL)</label>
                        <input type="text" name="slug" class="form-control" value="<%= blog.getSlug() != null ? blog.getSlug() : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">Select Category</option>
                            <% String[] cats = {"Destinations","Travel Tips","Adventure","Food & Culture","Budget Travel","Luxury Travel","Solo Travel","Family Travel"};
                               for (String c : cats) { %>
                            <option value="<%= c %>" <%= c.equals(blog.getCategory()) ? "selected" : "" %>><%= c %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Author Name</label>
                        <input type="text" name="authorName" class="form-control" value="<%= blog.getAuthorName() != null ? blog.getAuthorName() : "SafarSaga Team" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tags <small class="text-muted">(comma separated)</small></label>
                        <input type="text" name="tags" class="form-control" value="<%= blog.getTags() != null ? blog.getTags() : "" %>">
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="form-card">
                <div class="section-title">Content</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Short Description <span class="text-danger">*</span></label>
                        <textarea name="excerpt" class="form-control" rows="2" required><%= blog.getExcerpt() != null ? blog.getExcerpt() : "" %></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Blog Content <span class="text-danger">*</span></label>
                        <textarea name="content" class="form-control" rows="12" required><%= blog.getContent() != null ? blog.getContent() : "" %></textarea>
                    </div>
                </div>
            </div>

            <!-- Featured Image -->
            <div class="form-card">
                <div class="section-title">Featured Image</div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <label class="form-label">Upload New Image <small class="text-muted">(leave empty to keep current)</small></label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*" onchange="previewImg(this)">
                        <input type="text" name="featuredImage" id="featuredImage" class="form-control mt-2" 
                               value="<%= blog.getFeaturedImage() != null ? blog.getFeaturedImage() : "" %>" 
                               placeholder="Or paste image path: images/Goa.jpg"
                               oninput="updatePreview(this.value)">
                    </div>
                    <div class="col-md-6">
                        <div class="image-preview-box">
                            <% String imgSrc = (blog.getFeaturedImage() != null && !blog.getFeaturedImage().isEmpty()) ? "../" + blog.getFeaturedImage() : ""; %>
                            <img id="previewImg" src="<%= imgSrc %>" alt="Preview" style="<%= imgSrc.isEmpty() ? "display:none;" : "" %>">
                            <div id="previewPlaceholder" style="<%= imgSrc.isEmpty() ? "" : "display:none;" %>">
                                <i class="fas fa-image fa-2x text-muted"></i><br><small class="text-muted">Current image shown above</small>
                            </div>
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
                        <input type="date" name="publishedDate" class="form-control" value="<%= pubDate %>">
                    </div>
                    <div class="col-md-8">
                        <label class="form-label d-block mb-3">Options</label>
                        <div class="d-flex gap-4">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="isPublished" id="publishCheck" <%= blog.isPublished() ? "checked" : "" %>>
                                <label class="form-check-label" for="publishCheck">Published</label>
                            </div>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="featuredCheck" <%= blog.isFeatured() ? "checked" : "" %>>
                                <label class="form-check-label" for="featuredCheck">Featured</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-3 justify-content-end pb-4">
                <a href="blogManagement" class="btn btn-light rounded-pill px-4">Cancel</a>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save me-2"></i>Update Blog
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewImg(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('previewImg').src = e.target.result;
                document.getElementById('previewImg').style.display = 'block';
                document.getElementById('previewPlaceholder').style.display = 'none';
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    function updatePreview(val) {
        const img = document.getElementById('previewImg');
        if (val) {
            img.src = '../' + val;
            img.style.display = 'block';
            document.getElementById('previewPlaceholder').style.display = 'none';
        }
    }
</script>
</body>
</html>
