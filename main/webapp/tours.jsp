<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.safarsaga.dao.*, com.safarsaga.model.*" %>
<%
    TourDAO dao = new TourDAO();
    List<Tour> tours = dao.getAllTours();
    int total = tours.size();
    long domestic = tours.stream().filter(t -> "DOMESTIC".equals(t.getTourType())).count();
    long international = tours.stream().filter(t -> "INTERNATIONAL".equals(t.getTourType())).count();
    long featured = tours.stream().filter(Tour::isFeatured).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Discover unforgettable journeys with SafarSaga — handpicked domestic & international tours that awaken your wanderlust.">
    <title>All Tours • SafarSaga</title>

    <link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com" crossorigin>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="preload" as="style" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" onload="this.rel='stylesheet'">
    <noscript><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"></noscript>

    <%@ include file="shared_tours_style.jsp" %>

    <style>
        :root {
            --saga-teal:    #0f766e;
            --saga-emerald: #10b981;
            --saga-sand:    #f5e8d3;
            --saga-jungle:  #065f46;
            --saga-dark:    #0f172a;
            --glow:         0 0 18px rgba(16,185,129,0.45);
        }

        body {
            background: var(--saga-sand);
            color: #1e293b;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }

        /* ── HERO ──────────────────────────────────────────────── */
        .tours-hero {
            position: relative;
            height: 100vh;
            min-height: 720px;
            display: grid;
            place-items: center;
            overflow: hidden;
        }

        .hero-bg {
            position: absolute;
            inset: 0;
            background: url('images/kerala.webp'), url('https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1600&q=80&auto=format&fit=crop') center/cover no-repeat;
            background-blend-mode: luminosity;
            transform: scale(1.08);
            transition: transform 18s ease;
        }

        .tours-hero:hover .hero-bg { transform: scale(1.15); }

        .hero-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(15,118,110,0.78) 0%, rgba(6,95,70,0.62) 50%, rgba(16,185,129,0.28) 100%);
        }

        .hero-body {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            padding: 0 1rem;
        }

        .hero-eyebrow {
            font-size: 1.25rem;
            font-weight: 600;
            letter-spacing: 2px;
            color: #a7f3d0;
            text-transform: uppercase;
            opacity: 0.9;
        }

        .hero-h1 {
            font-size: clamp(3.2rem, 9vw, 6.8rem);
            font-weight: 800;
            line-height: 0.92;
            margin: 1.2rem 0 1.4rem;
            text-shadow: 0 6px 24px rgba(0,0,0,0.5);
        }

        .hero-h1 em {
            color: #6ee7b7;
            font-style: normal;
        }

        .hero-sub {
            font-size: 1.35rem;
            max-width: 620px;
            margin: 0 auto 2.2rem;
            opacity: 0.92;
        }

        .search-wrap {
            max-width: 620px;
            margin: 0 auto;
            background: rgba(255,255,255,0.14);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.18);
            border-radius: 60px;
            padding: 0.5rem;
            display: flex;
            align-items: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }

        .search-wrap input {
            flex: 1;
            background: transparent;
            border: none;
            color: white;
            font-size: 1.1rem;
            padding: 0.8rem 1.4rem;
        }

        .search-wrap input::placeholder { color: rgba(255,255,255,0.7); }

        .search-wrap button {
            background: linear-gradient(90deg, #10b981, #059669);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.9rem 1.9rem;
            border-radius: 50px;
            transition: all 0.3s;
        }

        .search-wrap button:hover {
            transform: translateY(-2px);
            box-shadow: var(--glow);
        }

        /* ── WAVE ──────────────────────────────────────────────── */
        .wave-bottom {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            overflow: hidden;
            line-height: 0;
        }

        .wave-bottom svg {
            position: relative;
            display: block;
            width: calc(100% + 1.3px);
            height: 80px;
        }

        .wave-bottom path { fill: var(--saga-sand); }

        /* ── STATS BAR ─────────────────────────────────────────── */
        .stats-bar {
            background: white;
            border-radius: 20px;
            padding: 1.8rem;
            margin: 2.5rem auto;
            max-width: 920px;
            box-shadow: 0 10px 40px rgba(16,185,129,0.12);
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .stat .n {
            font-size: 2.6rem;
            font-weight: 800;
            color: var(--saga-emerald);
            line-height: 1;
        }

        .stat .l {
            color: #64748b;
            font-size: 0.95rem;
            font-weight: 500;
        }

        /* ── FILTER PILLS ──────────────────────────────────────── */
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            justify-content: center;
            margin: 2rem 0 2.5rem;
        }

        .f-pill {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 50px;
            padding: 0.6rem 1.4rem;
            font-weight: 600;
            color: #475569;
            transition: all 0.28s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .f-pill:hover {
            border-color: var(--saga-emerald);
            color: var(--saga-emerald);
            transform: translateY(-2px);
        }

        .f-pill.fp-active {
            background: linear-gradient(135deg, var(--saga-teal), var(--saga-emerald));
            color: white;
            border-color: transparent;
            box-shadow: var(--glow);
            transform: translateY(-2px);
        }

        /* ── CARDS ─────────────────────────────────────────────── */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.8rem 1.5rem;
        }

        .t-card-wrap {
            perspective: 1200px;
        }

        .t-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 12px 36px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.22, 1, 0.36, 1);
            transform-style: preserve-3d;
        }

        .t-card:hover {
            transform: translateY(-12px) rotateX(4deg) rotateY(4deg);
            box-shadow: 0 28px 60px rgba(16,185,129,0.22), var(--glow);
        }

        .t-card-img {
            position: relative;
            height: 240px;
            overflow: hidden;
        }

        .t-card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.7s ease;
        }

        .t-card:hover .t-card-img img {
            transform: scale(1.14) translateY(-8px);
        }

        .t-card-img::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.65) 0%, transparent 60%);
            opacity: 0.4;
            transition: opacity 0.5s;
        }

        .t-card:hover .t-card-img::after { opacity: 0.65; }

        .t-badge {
            position: absolute;
            top: 14px;
            left: 14px;
            padding: 0.35rem 0.9rem;
            border-radius: 50px;
            font-size: 0.78rem;
            font-weight: 700;
            color: white;
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .badge-feat { background: linear-gradient(90deg, #f59e0b, #d97706); }
        .badge-trend { background: linear-gradient(90deg, #ef4444, #b91c1c); }
        .badge-new   { background: linear-gradient(90deg, #8b5cf6, #6d28d9); }

        .wishlist {
            position: absolute;
            top: 14px;
            right: 14px;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: rgba(255,255,255,0.22);
            border: none;
            backdrop-filter: blur(8px);
            display: grid;
            place-items: center;
            color: white;
            transition: all 0.3s;
        }

        .wishlist.active { background: #ef4444; transform: scale(1.15); }
        .wishlist:hover:not(.active) { background: rgba(255,255,255,0.4); }

        .type-lozenge {
            position: absolute;
            bottom: 14px;
            right: 14px;
            background: rgba(0,0,0,0.6);
            color: white;
            padding: 0.3rem 0.9rem;
            border-radius: 50px;
            font-size: 0.82rem;
            backdrop-filter: blur(6px);
        }

        .t-card-body {
            padding: 1.5rem 1.4rem 1.8rem;
        }

        .t-meta {
            display: flex;
            gap: 1.1rem;
            font-size: 0.92rem;
            color: #64748b;
            margin-bottom: 0.8rem;
        }

        .t-title {
            font-size: 1.38rem;
            font-weight: 800;
            margin-bottom: 0.7rem;
            line-height: 1.25;
            color: var(--saga-jungle);
        }

        .t-desc {
            font-size: 0.97rem;
            color: #4b5563;
            margin-bottom: 1.4rem;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .t-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dur-chip {
            background: #ecfdf5;
            color: var(--saga-emerald);
            padding: 0.45rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .btn-view {
            background: linear-gradient(90deg, var(--saga-teal), var(--saga-emerald));
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-view:hover {
            transform: translateY(-3px);
            box-shadow: var(--glow);
            color: white;
        }

        .load-more {
            display: block;
            margin: 3.5rem auto 4rem;
            background: transparent;
            border: 2px solid var(--saga-emerald);
            color: var(--saga-emerald);
            padding: 0.9rem 2.2rem;
            border-radius: 50px;
            font-weight: 700;
            transition: all 0.35s;
        }

        .load-more:hover {
            background: linear-gradient(90deg, var(--saga-teal), var(--saga-emerald));
            color: white;
            border-color: transparent;
            transform: translateY(-3px);
            box-shadow: var(--glow);
        }

        /* Fade-in stagger */
        .fade-in { opacity: 0; transform: translateY(30px); transition: all 0.9s ease-out; }
        .fade-in.d1 { animation: fadeUp 1s forwards; }
        .fade-in.d2 { animation: fadeUp 1.1s forwards 0.15s; }
        .fade-in.d3 { animation: fadeUp 1.1s forwards 0.25s; }
        .fade-in.d4 { animation: fadeUp 1.1s forwards 0.35s; }
        .fade-in.d5 { animation: fadeUp 1.1s forwards 0.45s; }
        .fade-in.d6 { animation: fadeUp 1.1s forwards 0.55s; }

        @keyframes fadeUp {
            to { opacity:1; transform:translateY(0); }
        }

        @media (max-width: 768px) {
            .hero-h1 { font-size: clamp(2.8rem, 10vw, 5rem); }
            .hero-sub { font-size: 1.15rem; }
            .stats-bar { padding: 1.4rem; gap: 1rem; }
            .stat .n { font-size: 2.2rem; }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<section class="tours-hero">
    <div class="hero-bg"></div>
    <div class="hero-overlay"></div>
    <div class="hero-body">
        <div class="container">
            <div class="fade-in d1">
                <div class="hero-eyebrow"><i class="fas fa-compass-drafting"></i> <%= total %> Curated Journeys</div>
                <h1 class="hero-h1">Awaken Your <em>Wanderlust</em></h1>
                <p class="hero-sub">From hidden gems of India to iconic wonders across the globe — your story begins with SafarSaga.</p>

                <div class="search-wrap fade-in d2">
                    <i class="fas fa-search mx-3" style="color:rgba(255,255,255,0.8);font-size:1.1rem;"></i>
                    <input type="text" id="searchInput" placeholder="Where do you dream of going?" autocomplete="off">
                    <button onclick="doSearch()">Explore <i class="fas fa-arrow-right ms-2"></i></button>
                </div>
            </div>
        </div>
    </div>

    <div class="wave-bottom">
        <svg viewBox="0 0 1440 120" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
            <path fill="var(--saga-sand)" d="M0,64L80,80C160,96,320,128,480,128C640,128,800,96,960,85.3C1120,75,1280,85,1360,90.7L1440,96L1440,120L0,120Z"></path>
        </svg>
    </div>
</section>

<main class="container py-5">
    <nav class="tab-nav d-flex justify-content-center mb-5">
        <a href="tours.jsp"               class="tab-pill active mx-2"><i class="fas fa-th-large me-2"></i>All Tours</a>
        <a href="domestic-tours.jsp"      class="tab-pill mx-2"><i class="fas fa-flag me-2"></i>Domestic</a>
        <a href="international-tours.jsp" class="tab-pill mx-2"><i class="fas fa-globe me-2"></i>International</a>
    </nav>

    <div class="stats-bar fade-in d1">
        <div class="stat"><div class="n"><%= total %></div><div class="l">Journeys</div></div>
        <div class="stat"><div class="n"><%= domestic %></div><div class="l">Domestic</div></div>
        <div class="stat"><div class="n"><%= international %></div><div class="l">International</div></div>
        <div class="stat"><div class="n"><%= featured %></div><div class="l">Featured</div></div>
    </div>

    <div class="filter-row">
        <span class="f-pill fp-active" data-f="all"           onclick="setFilter(this,'all')"><i class="fas fa-layer-group me-1"></i>All</span>
        <span class="f-pill" data-f="DOMESTIC"      onclick="setFilter(this,'DOMESTIC')"><i class="fas fa-flag me-1"></i>Domestic</span>
        <span class="f-pill" data-f="INTERNATIONAL" onclick="setFilter(this,'INTERNATIONAL')"><i class="fas fa-globe me-1"></i>International</span>
        <span class="f-pill" data-f="featured"      onclick="setFilter(this,'featured')"><i class="fas fa-star me-1"></i>Featured</span>
        <span class="f-pill" data-f="trending"      onclick="setFilter(this,'trending')"><i class="fas fa-fire me-1"></i>Trending</span>
    </div>

    <% if (tours.isEmpty()) { %>
    <div class="text-center py-5 my-5">
        <i class="fas fa-suitcase-rolling fa-5x mb-4" style="color:var(--saga-emerald);opacity:0.7"></i>
        <h3 class="mb-3" style="color:var(--saga-jungle);font-weight:800">Adventures Await — Coming Soon!</h3>
        <p class="text-muted fs-5">We're crafting unforgettable journeys. Stay tuned or reach out!</p>
        <a href="contact.jsp" class="btn-view mt-3">Let's Talk Travel <i class="fas fa-paper-plane ms-2"></i></a>
    </div>
    <% } else {
        String[] FALLBACKS_DOM = {"images/Rajasthan.jpg","images/Kerala1.jpg","images/Himalayan.jpg","images/Goa.jpg","images/kerala.jpg","images/Himalayan1.jpg","images/Rajasthan1.jpg"};
        String[] FALLBACKS_INT = {
            "https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=800&q=75&auto=format&fit=crop",
            "https://images.unsplash.com/photo-1488085061387-422e29b40080?w=800&q=75&auto=format&fit=crop",
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=75&auto=format&fit=crop",
            "https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&q=75&auto=format&fit=crop"
        };
    %>
    <div class="card-grid" id="cardGrid">
        <%
            int idx = 0;
            for (Tour tour : tours) {
                boolean isDom = "DOMESTIC".equals(tour.getTourType());
                String[] fallArr = isDom ? FALLBACKS_DOM : FALLBACKS_INT;
                String img = (tour.getImageUrl() != null && !tour.getImageUrl().trim().isEmpty()) ? tour.getImageUrl() : fallArr[idx % fallArr.length];
                String desc = tour.getDescription() != null ? tour.getDescription() : "Discover the magic of this destination with SafarSaga.";
                String loc  = (tour.getState() != null && !tour.getState().isEmpty()) ? tour.getState() : (tour.getCountry() != null ? tour.getCountry() : "Incredible India");
                String city = (tour.getDestinationCity() != null && !tour.getDestinationCity().isEmpty()) ? tour.getDestinationCity() : loc;
                String fb   = fallArr[idx % fallArr.length];
        %>
        <div class="t-card-wrap fade-in d<%= Math.min((idx % 6) + 1, 6) %>"
             data-name="<%= tour.getTourName().toLowerCase() %>"
             data-loc="<%= (loc + " " + city).toLowerCase() %>"
             data-type="<%= tour.getTourType() %>"
             data-feat="<%= tour.isFeatured() %>"
             data-trend="<%= tour.isTrending() %>"
             data-idx="<%= idx %>">
            <article class="t-card">
                <div class="t-card-img">
                    <img src="<%= img %>" alt="<%= tour.getTourName() %>"
                         loading="<%= idx < 8 ? "eager" : "lazy" %>"
                         onerror="this.src='<%= fb %>';this.onerror=null">
                    <% if(tour.isFeatured()){%>
                    <span class="t-badge badge-feat"><i class="fas fa-star me-1"></i>Featured</span>
                    <%}else if(tour.isTrending()){%>
                    <span class="t-badge badge-trend"><i class="fas fa-fire me-1"></i>Trending</span>
                    <%}else{%>
                    <span class="t-badge badge-new"><i class="fas fa-leaf me-1"></i>New</span><%}%>

                    <button class="wishlist" onclick="heart(this)"><i class="fas fa-heart"></i></button>
                    <span class="type-lozenge"><%= tour.getTourType().charAt(0) + tour.getTourType().substring(1).toLowerCase() %></span>
                </div>
                <div class="t-card-body">
                    <div class="t-meta">
                        <span><i class="fas fa-map-marker-alt me-1"></i><%= city %></span>
                        <%if(tour.getCategory()!=null && !tour.getCategory().isEmpty()){%>
                        <span><i class="fas fa-tag me-1"></i><%= tour.getCategory() %></span><%}%>
                    </div>
                    <h2 class="t-title"><%= tour.getTourName() %></h2>
                    <p class="t-desc"><%= desc %></p>
                    <div class="t-footer">
                        <div class="dur-chip"><i class="fas fa-clock me-1"></i><%= tour.getDurationDays() %> Days<%if(tour.getDurationNights()>0){%>/<%= tour.getDurationNights() %> Nights<%}%></div>
                        <a href="tour-details.jsp?id=<%= tour.getTourId() %>" class="btn-view">View Journey</a>
                    </div>
                </div>
            </article>
        </div>
        <% idx++; } %>
    </div>

    <% if(tours.size()>8){ %>
    <button class="load-more" id="loadMoreBtn" onclick="loadMore()">
        <i class="fas fa-compass me-2"></i> Discover More Adventures
    </button>
    <% } %>
    <% } %>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>
<script>
(function(){
    const BATCH = 8;
    let visible = BATCH;
    const cards = document.querySelectorAll('.t-card-wrap');
    const loadBtn = document.getElementById('loadMoreBtn');
    let state = { type: 'all', q: '' };

    function render() {
        let shown = 0;
        cards.forEach(card => {
            const t = card.dataset.type;
            const ok = state.type === 'all' ||
                       t === state.type ||
                       (state.type === 'featured' && card.dataset.feat === 'true') ||
                       (state.type === 'trending' && card.dataset.trend === 'true');

            const qok = !state.q ||
                        card.dataset.name.includes(state.q) ||
                        card.dataset.loc.includes(state.q);

            const inRange = parseInt(card.dataset.idx) < visible;

            const shouldShow = ok && qok && inRange;
            card.style.display = shouldShow ? '' : 'none';
            if (ok && qok) shown++;
        });

        if (loadBtn) loadBtn.style.display = (shown <= visible && visible >= cards.length) ? 'none' : '';
    }

    window.setFilter = function(el, type) {
        document.querySelectorAll('.f-pill').forEach(p => p.classList.remove('fp-active'));
        el.classList.add('fp-active');
        state.type = type;
        visible = BATCH;
        render();
    };

    window.doSearch = function() {
        state.q = document.getElementById('searchInput').value.toLowerCase().trim();
        visible = BATCH;
        render();
    };

    document.getElementById('searchInput')?.addEventListener('input', e => {
        state.q = e.target.value.toLowerCase().trim();
        visible = BATCH;
        render();
    });

    window.loadMore = function() {
        visible += BATCH;
        render();
    };

    window.heart = function(btn) {
        btn.classList.toggle('active');
        const icon = btn.querySelector('i');
        if (btn.classList.contains('active')) {
            icon.style.color = '#ef4444';
            btn.style.transform = 'scale(1.3)';
            setTimeout(() => btn.style.transform = '', 280);
        } else {
            icon.style.color = 'white';
        }
    };

    render();
})();
</script>
</body>
</html>