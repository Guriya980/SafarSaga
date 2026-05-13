<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.safarsaga.model.Blog, com.safarsaga.dao.BlogDAO" %>
<%
    BlogDAO blogDAO = new BlogDAO();
    List<Blog> blogs = blogDAO.getAllBlogs();
    List<Blog> featuredBlogs = blogDAO.getFeaturedBlogs();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Blog | SafarSaga</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700;800&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Poppins', sans-serif; background: #fafbfc; }

        /* HERO */
        .blog-hero {
            min-height: 420px;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            position: relative; display: flex; align-items: center; overflow: hidden;
        }
        .blog-hero::before {
            content: ''; position: absolute; inset: 0;
            background: url('images/Goa.jpg') center/cover no-repeat;
            opacity: 0.2;
        }
        .blog-hero::after {
            content: ''; position: absolute; bottom: -1px; left: 0; right: 0;
            height: 80px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 80'%3E%3Cpath fill='%23fafbfc' d='M0,80L1440,0L1440,80Z'/%3E%3C/svg%3E") no-repeat bottom/cover;
        }
        .hero-content { position: relative; z-index: 2; }
        .hero-tag-pill {
            background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2); color: #a8d8ea;
            border-radius: 50px; padding: 0.4rem 1.2rem; font-size: 0.82rem; font-weight: 600;
            display: inline-flex; align-items: center; gap: 6px; margin-bottom: 1.5rem;
        }
        .hero-title-blog {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2rem, 5vw, 3.5rem);
            font-weight: 800; color: white; line-height: 1.2; margin-bottom: 1rem;
        }
        .hero-sub { color: rgba(255,255,255,0.7); font-size: 1.05rem; margin-bottom: 2rem; }

        /* SEARCH */
        .blog-search {
            display: flex; max-width: 480px; background: white; border-radius: 50px;
            overflow: hidden; box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        .blog-search input {
            flex: 1; border: none; outline: none; padding: 0.8rem 1.5rem;
            font-size: 0.95rem; font-family: 'Poppins', sans-serif;
        }
        .blog-search button {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none; color: white; padding: 0.8rem 1.5rem; cursor: pointer;
            font-weight: 700; transition: opacity 0.2s;
        }

        /* FEATURED SECTION */
        .featured-section { padding: 4rem 0 2rem; }
        .section-label {
            font-size: 0.78rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 2px; color: #764ba2; margin-bottom: 0.5rem;
        }
        .section-h2 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.6rem, 3vw, 2.2rem); font-weight: 700; color: #1a1a2e;
        }

        /* FEATURED CARD (large) */
        .featured-card {
            border-radius: 20px; overflow: hidden; position: relative;
            height: 440px; cursor: pointer;
            box-shadow: 0 10px 40px rgba(0,0,0,0.12);
            transition: transform 0.3s ease;
        }
        .featured-card:hover { transform: translateY(-6px); }
        .featured-card img {
            width: 100%; height: 100%; object-fit: cover;
            transition: transform 0.6s ease;
        }
        .featured-card:hover img { transform: scale(1.05); }
        .featured-card .overlay {
            position: absolute; inset: 0;
            background: linear-gradient(0deg, rgba(0,0,0,0.75) 0%, rgba(0,0,0,0.1) 60%);
        }
        .featured-card .card-content {
            position: absolute; bottom: 0; left: 0; right: 0; padding: 2rem;
        }
        .featured-badge {
            background: linear-gradient(135deg,#667eea,#764ba2);
            color: white; border-radius: 50px; padding: 0.3rem 0.9rem;
            font-size: 0.72rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.5px; display: inline-block; margin-bottom: 0.8rem;
        }
        .featured-title {
            font-family: 'Playfair Display', serif;
            color: white; font-size: 1.6rem; font-weight: 700; line-height: 1.3;
            margin-bottom: 0.8rem;
        }
        .featured-excerpt { color: rgba(255,255,255,0.8); font-size: 0.88rem; line-height: 1.6; margin-bottom: 1rem; }
        .featured-meta { display: flex; align-items: center; gap: 1rem; }
        .featured-author { display: flex; align-items: center; gap: 8px; }
        .featured-author img { width: 32px; height: 32px; border-radius: 50%; border: 2px solid rgba(255,255,255,0.5); }
        .featured-author span { color: rgba(255,255,255,0.9); font-size: 0.8rem; font-weight: 600; }
        .featured-time { color: rgba(255,255,255,0.6); font-size: 0.78rem; }

        /* BLOG GRID CARD */
        .blog-card {
            background: white; border-radius: 18px; overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            transition: all 0.3s ease; height: 100%;
            display: flex; flex-direction: column;
        }
        .blog-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(0,0,0,0.12); }
        .blog-card-img {
            position: relative; height: 200px; overflow: hidden;
        }
        .blog-card-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .blog-card:hover .blog-card-img img { transform: scale(1.07); }
        .cat-badge {
            position: absolute; top: 12px; left: 12px;
            padding: 0.3rem 0.8rem; border-radius: 50px;
            font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
            background: linear-gradient(135deg,#667eea,#764ba2); color: white;
        }
        .blog-card-body { padding: 1.4rem; flex: 1; display: flex; flex-direction: column; }
        .blog-meta { display: flex; align-items: center; gap: 1rem; margin-bottom: 0.7rem; color: #999; font-size: 0.78rem; }
        .blog-meta i { color: #764ba2; }
        .blog-card-title {
            font-weight: 700; font-size: 1rem; color: #1a1a2e; line-height: 1.4;
            margin-bottom: 0.6rem;
        }
        .blog-card-excerpt { color: #777; font-size: 0.83rem; line-height: 1.6; flex: 1; }
        .blog-card-footer {
            display: flex; align-items: center; justify-content: space-between;
            margin-top: 1.2rem; padding-top: 1rem; border-top: 1px solid #f0f0f0;
        }
        .author-mini { display: flex; align-items: center; gap: 6px; }
        .author-mini span { font-size: 0.78rem; color: #555; font-weight: 600; }
        .btn-read {
            display: inline-flex; align-items: center; gap: 5px;
            color: #764ba2; font-weight: 700; font-size: 0.82rem;
            text-decoration: none; transition: gap 0.2s;
        }
        .btn-read:hover { gap: 8px; color: #667eea; }

        /* CATEGORIES */
        .cat-filter { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 2rem; }
        .cat-pill {
            padding: 0.4rem 1.1rem; border-radius: 50px;
            border: 2px solid #e0e0e0; background: white; color: #666;
            font-weight: 600; font-size: 0.8rem; cursor: pointer; transition: all 0.2s;
        }
        .cat-pill:hover, .cat-pill.active {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white; border-color: transparent;
        }

        /* EMPTY */
        .blog-empty {
            background: linear-gradient(135deg,#f0e6ff,#e6ecff);
            border-radius: 20px; padding: 4rem 2rem; text-align: center;
        }
        .animate-in { animation: fadeUp 0.7s ease both; }
        @keyframes fadeUp { from { opacity:0; transform:translateY(25px); } to { opacity:1; transform:translateY(0); } }

        .floating-orb {
            position: absolute; border-radius: 50%; pointer-events: none;
            animation: orb 8s infinite ease-in-out alternate;
        }
        @keyframes orb {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(30px, -20px) scale(1.1); }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <!-- HERO -->
    <section class="blog-hero">
        <div class="floating-orb" style="width:300px;height:300px;background:rgba(102,126,234,0.15);top:-100px;right:-80px;"></div>
        <div class="floating-orb" style="width:200px;height:200px;background:rgba(118,75,162,0.12);bottom:-60px;left:-40px;animation-delay:-4s;"></div>
        <div class="container hero-content">
            <div class="animate-in">
                <div class="hero-tag-pill"><i class="fas fa-feather-alt"></i> Travel Stories & Inspiration</div>
                <h1 class="hero-title-blog">Journeys That<br><span style="color:#a8d8ea;">Inspire</span></h1>
                <p class="hero-sub">Real stories, local secrets & expert travel tips</p>
                <div class="blog-search animate-in" style="animation-delay:0.2s">
                    <input type="text" id="blogSearch" placeholder="Search articles...">
                    <button onclick="searchBlogs()"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </div>
    </section>

    <!-- FEATURED BLOGS -->
    <% if (featuredBlogs != null && !featuredBlogs.isEmpty()) { %>
    <section class="featured-section">
        <div class="container">
            <div class="mb-4 animate-in">
                <div class="section-label"><i class="fas fa-star me-1"></i> Editor's Picks</div>
                <h2 class="section-h2">Featured Articles</h2>
            </div>
            <div class="row g-4">
                <% for(int i = 0; i < Math.min(3, featuredBlogs.size()); i++) {
                       Blog fb = featuredBlogs.get(i);
                       String colClass = i == 0 ? "col-lg-7" : "col-lg-5";
                       if (i == 0) { %>
                <div class="col-lg-7 animate-in" style="animation-delay:0.1s">
                    <a href="blogs?action=view&slug=<%= fb.getSlug() %>" style="text-decoration:none;">
                        <div class="featured-card">
                            <img src="<%= fb.getFeaturedImage() != null && !fb.getFeaturedImage().isEmpty() ? fb.getFeaturedImage() : "images/Rajasthan.jpg" %>"
                                 alt="<%= fb.getTitle() %>"
                                 onerror="this.src='https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=700&h=450&fit=crop'">
                            <div class="overlay"></div>
                            <div class="card-content">
                                <span class="featured-badge"><i class="fas fa-bookmark me-1"></i><%= fb.getCategory() != null ? fb.getCategory() : "Featured" %></span>
                                <h3 class="featured-title"><%= fb.getTitle() %></h3>
                                <p class="featured-excerpt"><%= fb.getExcerpt() != null && fb.getExcerpt().length() > 100 ? fb.getExcerpt().substring(0,100)+"…" : fb.getExcerpt() %></p>
                                <div class="featured-meta">
                                    <div class="featured-author">
                                        <i class="fas fa-user-circle" style="color:rgba(255,255,255,0.7);font-size:1.5rem;"></i>
                                        <span><%= fb.getAuthorName() != null ? fb.getAuthorName() : "SafarSaga" %></span>
                                    </div>
                                    <span class="featured-time"><i class="fas fa-clock me-1"></i><%= fb.getReadingTime() %> min read</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <%   } else { %>
                <div class="col-lg-5 animate-in" style="animation-delay:<%= 0.1 + i*0.1 %>s">
                    <a href="blogs?action=view&slug=<%= fb.getSlug() %>" style="text-decoration:none;">
                        <div class="featured-card" style="height:210px; margin-bottom: <%= i==1 ? "1.2rem" : "0" %>">
                            <img src="<%= fb.getFeaturedImage() != null && !fb.getFeaturedImage().isEmpty() ? fb.getFeaturedImage() : (i==1 ? "images/Kerala1.jpg" : "images/Goa.jpg") %>"
                                 alt="<%= fb.getTitle() %>"
                                 onerror="this.src='https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?w=500&h=210&fit=crop'">
                            <div class="overlay"></div>
                            <div class="card-content" style="padding:1.2rem;">
                                <span class="featured-badge" style="font-size:0.65rem;"><%= fb.getCategory() != null ? fb.getCategory() : "Travel" %></span>
                                <h4 class="featured-title" style="font-size:1.15rem;"><%= fb.getTitle() %></h4>
                                <span class="featured-time"><i class="fas fa-clock me-1"></i><%= fb.getReadingTime() %> min</span>
                            </div>
                        </div>
                    </a>
                </div>
                <%   }
                   } %>
            </div>
        </div>
    </section>
    <% } %>

    <!-- ALL BLOGS -->
    <section class="py-5" style="background: white;">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-4 animate-in">
                <div>
                    <div class="section-label">Latest Stories</div>
                    <h2 class="section-h2">All Articles</h2>
                </div>
                <div class="cat-filter" id="catFilter">
                    <span class="cat-pill active" data-cat="all">All</span>
                    <span class="cat-pill" data-cat="Destinations">Destinations</span>
                    <span class="cat-pill" data-cat="Travel Tips">Tips</span>
                    <span class="cat-pill" data-cat="Adventure">Adventure</span>
                    <span class="cat-pill" data-cat="Food & Culture">Food</span>
                </div>
            </div>

            <% if (blogs == null || blogs.isEmpty()) { %>
            <div class="blog-empty animate-in">
                <i class="fas fa-feather-alt fa-4x mb-3" style="color:#764ba2;opacity:0.4;"></i>
                <h4 style="color:#764ba2;" class="fw-bold">Stories Coming Soon!</h4>
                <p class="text-muted">We're crafting amazing travel stories for you. Stay tuned!</p>
            </div>
            <% } else { %>
            <div class="row g-4" id="blogsGrid">
                <% for (Blog blog : blogs) {
                       String imgSrc = (blog.getFeaturedImage() != null && !blog.getFeaturedImage().isEmpty()) ? blog.getFeaturedImage() : "images/Himalayan.jpg";
                       String excerpt = blog.getExcerpt() != null ? blog.getExcerpt() : "";
                       String shortExcerpt = excerpt.length() > 100 ? excerpt.substring(0, 100) + "…" : excerpt;
                %>
                <div class="col-md-6 col-lg-4 blog-grid-item animate-in" data-cat="<%= blog.getCategory() != null ? blog.getCategory() : "" %>">
                    <div class="blog-card h-100">
                        <div class="blog-card-img">
                            <img src="<%= imgSrc %>" alt="<%= blog.getTitle() %>"
                                 onerror="this.src='https://images.unsplash.com/photo-1501854140801-50d01698950b?w=400&h=200&fit=crop'">
                            <% if (blog.getCategory() != null) { %><span class="cat-badge"><%= blog.getCategory() %></span><% } %>
                        </div>
                        <div class="blog-card-body">
                            <div class="blog-meta">
                                <span><i class="fas fa-clock"></i> <%= blog.getReadingTime() %> min read</span>
                                <span><i class="fas fa-eye"></i> <%= blog.getViewsCount() %></span>
                            </div>
                            <h4 class="blog-card-title"><%= blog.getTitle() %></h4>
                            <p class="blog-card-excerpt"><%= shortExcerpt %></p>
                            <div class="blog-card-footer">
                                <div class="author-mini">
                                    <i class="fas fa-user-circle" style="color:#764ba2;font-size:1.3rem;"></i>
                                    <span><%= blog.getAuthorName() != null ? blog.getAuthorName() : "SafarSaga" %></span>
                                </div>
                                <a href="blogs?action=view&slug=<%= blog.getSlug() %>" class="btn-read">
                                    Read <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Category filter
    document.querySelectorAll('.cat-pill').forEach(pill => {
        pill.addEventListener('click', function() {
            document.querySelectorAll('.cat-pill').forEach(p => p.classList.remove('active'));
            this.classList.add('active');
            const cat = this.dataset.cat;
            document.querySelectorAll('.blog-grid-item').forEach(item => {
                item.style.display = (cat === 'all' || item.dataset.cat === cat) ? '' : 'none';
            });
        });
    });

    // Search
    function searchBlogs() {
        const q = document.getElementById('blogSearch').value.toLowerCase();
        document.querySelectorAll('.blog-grid-item').forEach(item => {
            item.style.display = item.textContent.toLowerCase().includes(q) ? '' : 'none';
        });
    }
    document.getElementById('blogSearch').addEventListener('keyup', function(e) {
        if(e.key === 'Enter') searchBlogs();
    });
</script>
</body>
</html>
