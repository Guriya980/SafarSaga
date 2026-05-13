<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.safarsaga.dao.*, com.safarsaga.model.*" %>
<%
    TourDAO dao = new TourDAO();
    List<Tour> tours = dao.getToursByType("DOMESTIC");
    int total = tours.size();
    long featured = tours.stream().filter(Tour::isFeatured).count();
    long trending = tours.stream().filter(Tour::isTrending).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="description" content="Explore the best domestic tours across India — Kerala, Rajasthan, Goa, Himalayas and more.">
<title>Domestic Tours India | SafarSaga</title>

<!-- Critical: preconnect to CDNs -->
<link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
<link rel="preconnect" href="https://cdnjs.cloudflare.com" crossorigin>

<!-- Bootstrap CSS — only what's needed -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome — deferred via JS swap trick for speed -->
<link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"></noscript>

<!-- ALL critical CSS inlined — zero extra HTTP requests for above-fold -->
<%@ include file="shared_tours_style.jsp" %>

<style>
/* Domestic-specific hero accent */
.tours-hero .hero-overlay{background:linear-gradient(135deg,rgba(15,32,39,.82) 0%,rgba(32,58,67,.65) 50%,rgba(26,138,122,.45) 100%)}
.search-wrap button{background:linear-gradient(135deg,#1a8a7a,#27ae60)}
.tab-pill.active{background:linear-gradient(135deg,#1a8a7a,#27ae60)}

/* Destination pills row */
.dest-pills{display:flex;flex-wrap:wrap;gap:.5rem;margin-bottom:1.8rem}
.dest-pill{padding:.35rem 1rem;border-radius:100px;border:1.5px solid #dde8e5;background:#fff;color:#444;font-size:.78rem;font-weight:600;cursor:pointer;transition:all .2s}
.dest-pill:hover,.dest-pill.dp-active{background:#1a8a7a;color:#fff;border-color:#1a8a7a}

/* Colour accents for card badges on domestic */
.t-card-img::before{background:linear-gradient(135deg,#e8f5e9,#c8e6c9)}
</style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- ══════════ HERO ══════════ -->
<section class="tours-hero">
  <div class="hero-bg" style="background-image:url('images/Rajasthan.jpg'),url('https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=1400&q=75&fit=crop')"></div>
  <div class="hero-overlay"></div>
  <div class="hero-body">
    <div class="container">
      <div class="fade-in d1">
        <div class="hero-eyebrow"><i class="fas fa-flag"></i>&nbsp; Incredible India</div>
        <h1 class="hero-h1">Discover <em>Domestic</em> Tours<br>Made for Every Traveller</h1>
        <p class="hero-sub">From Himalayan peaks to Kerala backwaters — <%= total %> handpicked Indian adventures await you.</p>
        <div class="search-wrap fade-in d2">
          <i class="fas fa-search" style="margin-left:1.2rem;color:#bbb;font-size:.9rem"></i>
          <input type="text" id="searchInput" placeholder="Search by name, state, city…" autocomplete="off">
          <button onclick="doSearch()">Search <i class="fas fa-arrow-right ms-1"></i></button>
        </div>
      </div>
    </div>
  </div>
  <div class="wave-bottom">
    <svg viewBox="0 0 1440 54" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
      <path fill="#f4f7f6" d="M0,32L80,26.7C160,21,320,11,480,16C640,21,800,43,960,48C1120,53,1280,43,1360,37.3L1440,32L1440,54L0,54Z"/>
    </svg>
  </div>
</section>

<!-- ══════════ MAIN CONTENT ══════════ -->
<main class="container py-4">

  <!-- Tab navigation -->
  <nav class="tab-nav">
    <a href="tours.jsp"             class="tab-pill"><i class="fas fa-th-large"></i> All Tours</a>
    <a href="domestic-tours.jsp"    class="tab-pill active"><i class="fas fa-flag"></i> Domestic</a>
    <a href="international-tours.jsp" class="tab-pill"><i class="fas fa-globe"></i> International</a>
  </nav>

  <!-- Stats bar -->
  <div class="stats-bar fade-in d1">
    <div class="stat"><div class="n"><%= total %></div><div class="l">Total Tours</div></div>
    <div class="stat"><div class="n"><%= featured %></div><div class="l">Featured</div></div>
    <div class="stat"><div class="n"><%= trending %></div><div class="l">Trending</div></div>
    <div class="stat"><div class="n">4.9 ⭐</div><div class="l">Avg Rating</div></div>
  </div>

  <!-- Destination quick-filter pills (state-based) -->
  <% if (!tours.isEmpty()) {
       Set<String> states = new LinkedHashSet<>();
       for (Tour t : tours) { if (t.getState() != null && !t.getState().trim().isEmpty()) states.add(t.getState().trim()); }
       if (!states.isEmpty()) { %>
  <div class="dest-pills" id="destPills">
    <span class="dest-pill dp-active" data-state="all" onclick="filterState(this,'all')">All States</span>
    <% for (String s : states) { %>
    <span class="dest-pill" data-state="<%= s %>" onclick="filterState(this,'<%= s %>')"><%= s %></span>
    <% } %>
  </div>
  <% } } %>

  <!-- Tour cards -->
  <% if (tours.isEmpty()) { %>
  <div class="no-tours">
    <i class="fas fa-map-marked-alt"></i>
    <h3 style="color:#1a8a7a;font-weight:800" class="mb-2">No Domestic Tours Yet</h3>
    <p style="color:#777">We're curating incredible Indian journeys. Check back soon!</p>
    <a href="contact.jsp" class="btn-view mt-3 d-inline-flex">Get Notified &nbsp;<i class="fas fa-arrow-right"></i></a>
  </div>
  <% } else { %>
  <div class="card-grid" id="cardGrid">
    <%
      String[] FALLBACKS = {
        "images/Rajasthan.jpg","images/Kerala1.jpg","images/Himalayan.jpg","images/Goa.jpg",
        "images/Rajasthan1.jpg","images/kerala.jpg","images/Himalayan1.jpg"
      };
      int idx = 0;
      for (Tour tour : tours) {
        String img = (tour.getImageUrl() != null && !tour.getImageUrl().trim().isEmpty())
                       ? tour.getImageUrl()
                       : FALLBACKS[idx % FALLBACKS.length];
        String desc = tour.getDescription() != null ? tour.getDescription() : "";
        String loc  = (tour.getState() != null && !tour.getState().isEmpty()) ? tour.getState() : "India";
        String city = (tour.getDestinationCity() != null && !tour.getDestinationCity().isEmpty()) ? tour.getDestinationCity() : loc;
        String animClass = "fade-in d" + Math.min(idx + 1, 6);
        String stateVal = (tour.getState() != null) ? tour.getState().trim() : "";
    %>
    <div class="t-card-wrap <%= animClass %>" data-name="<%= tour.getTourName().toLowerCase() %>"
         data-loc="<%= loc.toLowerCase() %>" data-state="<%= stateVal %>" data-idx="<%= idx %>">
      <article class="t-card">
        <div class="t-card-img">
          <img src="<%= img %>"
               alt="<%= tour.getTourName() %>"
               loading="<%= idx < 6 ? "eager" : "lazy" %>"
               onerror="this.src='<%= FALLBACKS[idx % FALLBACKS.length] %>';this.onerror=null">
          <% if (tour.isFeatured()) { %>
          <span class="t-badge badge-feat"><i class="fas fa-star"></i> Featured</span>
          <% } else if (tour.isTrending()) { %>
          <span class="t-badge badge-trend"><i class="fas fa-fire"></i> Trending</span>
          <% } else { %>
          <span class="t-badge badge-new"><i class="fas fa-leaf"></i> New</span>
          <% } %>
          <button class="wishlist" aria-label="Save to wishlist" onclick="heart(this)"><i class="fas fa-heart"></i></button>
          <span class="type-lozenge">DOMESTIC</span>
        </div>
        <div class="t-card-body">
          <div class="t-meta">
            <span><i class="fas fa-map-marker-alt"></i> <%= city %></span>
            <% if (tour.getCategory() != null && !tour.getCategory().isEmpty()) { %>
            <span><i class="fas fa-tag"></i> <%= tour.getCategory() %></span>
            <% } %>
          </div>
          <h2 class="t-title"><%= tour.getTourName() %></h2>
          <p class="t-desc"><%= desc %></p>
          <div class="t-footer">
            <div class="dur-chip"><i class="fas fa-clock"></i> <%= tour.getDurationDays() %> Days<% if(tour.getDurationNights()>0){%>/<%= tour.getDurationNights() %>N<%}%></div>
            <a href="tour-details.jsp?id=<%= tour.getTourId() %>" class="btn-view">Explore <i class="fas fa-arrow-right"></i></a>
          </div>
        </div>
      </article>
    </div>
    <% idx++; } %>
  </div>

  <% if (tours.size() > 6) { %>
  <button class="load-more" id="loadMoreBtn" onclick="loadMore()">
    <i class="fas fa-plus me-2"></i>Show More Tours
  </button>
  <% } %>
  <% } %>

</main>

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS deferred — non-blocking -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" defer></script>
<script>
(function(){
  var BATCH = 6, vis = BATCH;
  var all = document.querySelectorAll('.t-card-wrap');
  var btn = document.getElementById('loadMoreBtn');
  var currentFilter = {state:'all', q:''};

  function applyFilter(){
    var shown = 0;
    all.forEach(function(c){
      var stateOk = currentFilter.state === 'all' || c.dataset.state === currentFilter.state;
      var q = currentFilter.q;
      var qOk = !q || c.dataset.name.includes(q) || c.dataset.loc.includes(q);
      var idx = parseInt(c.dataset.idx);
      var within = idx < vis;
      var show = stateOk && qOk && within;
      c.style.display = show ? '' : 'none';
      if(stateOk && qOk) shown++;
    });
    if(btn) btn.style.display = shown <= vis ? 'none' : '';
  }

  window.filterState = function(el, state){
    document.querySelectorAll('.dest-pill').forEach(function(p){p.classList.remove('dp-active')});
    el.classList.add('dp-active');
    currentFilter.state = state;
    vis = BATCH;
    applyFilter();
  };

  window.doSearch = function(){
    currentFilter.q = (document.getElementById('searchInput').value||'').toLowerCase().trim();
    vis = BATCH;
    applyFilter();
  };

  var si = document.getElementById('searchInput');
  if(si){ si.addEventListener('input', function(){ currentFilter.q = this.value.toLowerCase().trim(); vis = BATCH; applyFilter(); }); }

  window.loadMore = function(){
    vis += BATCH;
    applyFilter();
    if(btn && vis >= all.length) btn.style.display='none';
  };

  window.heart = function(btn){
    var icon = btn.querySelector('i');
    if(btn.classList.toggle('active')){
      icon.style.color='#e74c3c';
      btn.style.transform='scale(1.3)';
      setTimeout(function(){btn.style.transform=''},300);
    } else { icon.style.color='#ccc'; }
  };

  applyFilter();
})();
</script>
</body>
</html>
