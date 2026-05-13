<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Blog" %>
<%@ page import="com.safarsaga.dao.BlogDAO" %>
<%
    String slug = request.getParameter("slug");
    Blog blog = null;
    if (slug != null) {
        BlogDAO blogDAO = new BlogDAO();
        blog = blogDAO.getBlogBySlug(slug);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= (blog != null) ? blog.getTitle() : "Blog" %> - SafarSaga</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <% if (blog != null) { %>
        <article>
            <section class="py-5" style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('<%= blog.getFeaturedImage() %>'); background-size: cover; background-position: center; min-height: 400px;">
                <div class="container text-white d-flex align-items-center" style="min-height: 350px;">
                    <div>
                        <span class="badge bg-primary mb-3"><%= blog.getCategory() %></span>
                        <h1 class="display-4 fw-bold"><%= blog.getTitle() %></h1>
                        <p class="lead"><%= blog.getExcerpt() %></p>
                        <div class="d-flex align-items-center mt-4">
                            <img src="<%= blog.getAuthorImage() %>" alt="<%= blog.getAuthorName() %>" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h6 class="mb-0"><%= blog.getAuthorName() %></h6>
                                <small><%= blog.getPublishedDate() %> · <%= blog.getReadingTime() %> min read · <%= blog.getViewsCount() %> views</small>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="blog-content">
                                <%= blog.getContent() %>
                            </div>
                            
                            <hr class="my-5">
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6>Tags:</h6>
                                    <% if (blog.getTags() != null) {
                                        String[] tags = blog.getTags().split(",");
                                        for (String tag : tags) { %>
                                            <span class="badge bg-secondary me-1"><%= tag.trim() %></span>
                                    <% } } %>
                                </div>
                                <div>
                                    <a href="blogs" class="btn btn-outline-primary">
                                        <i class="fas fa-arrow-left"></i> Back to Blog
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </article>
    <% } else { %>
        <section class="py-5">
            <div class="container text-center">
                <h2>Blog Post Not Found</h2>
                <p>Sorry, the blog post you're looking for doesn't exist.</p>
                <a href="blogs" class="btn btn-primary">Browse All Articles</a>
            </div>
        </section>
    <% } %>

    <%@ include file="footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
