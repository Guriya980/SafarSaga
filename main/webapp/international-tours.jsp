<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.safarsaga.dao.*, com.safarsaga.model.*" %>
<%
    TourDAO dao = new TourDAO();
    List<Tour> tours = dao.getToursByType("INTERNATIONAL");
    int total = tours.size();
    long featured = tours.stream().filter(Tour::isFeatured).count();
    long trending = tours.stream().filter(Tour::isTrending).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="description" content="Explore International Tours — Bali, Maldives, Europe, Thailand and beyond.">
<title>International Tours | SafarSaga</title>

<link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
<link rel="preconnect" href="https://cdnjs.cloudflare.com" crossorigin>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"></noscript>

<%@ include file="shared_tours_style.jsp" %>

<style>
/* International-specific theme — deep ocean/indigo */
.tours-hero .hero-overlay{background:linear-gradient(135deg,rgba(10,10,35,.85) 0%,rgba(20,20,70,.65) 50%,rgba(102,126,234,.4) 100%)}
.search-wrap button{background:linear-gradient(135deg,#667eea,#764ba2)}
.tab-pill.active{background:linear-gradient(135deg,#667eea,#764ba2);box-shadow:0 6px 18px rgba(102,126,234,.35)}
.hero-eyebrow{color:#c3d6ff}
.hero-h1 em{color:#c3d6ff}

/* Card accent */
.t-card-img::before{background:linear-gradient(135deg,#e8eaff,#d0d5f5)}

/* Country filter pills */
.dest-pills .dp-active,.dest-pills .dest-pill:hover{background:linear-gradient(135deg,#667eea,#764ba2);border-color:transparent;color:#fff}
.dur-chip{background:#f0f0ff;color:#667eea}
.btn-view{background:linear-gradient(135deg,#667eea,#764ba2)}

/* Stats bar accent */
.stat .n{color:#667eea}

/* Load more */
.load-more{border-color:#667eea;color:#667eea}
.load-more:hover{background:linear-gradient(135deg,#667eea,#764ba2);border-color:transparent;box-shadow:0 8px 24px rgba(102,126,234,.35)}

/* No tours */
.no-tours i{color:#c3d6ff}
.no-tours h3{color:#667eea}
</style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- ══════════ HERO ══════════ -->
<section class="tours-hero">
  <div class="hero-bg" style="background-image:url('images/Himalayan.jpg'),url('https://images.unsplash.com/photo-1488085061387-422e29b40080?w=1400&q=75&fit=crop')"></div>
  <div class="hero-overlay"></div>
  <div class="hero-body">
    <div class="container">
      <div class="fade-in d1">
        <div class="hero-eyebrow"><i class="fas fa-globe-americas"></i>&nbsp; Beyond Borders</div>
        <h1 class="hero-h1">Explore <em>International</em> Tours<br>Crafted for the World Wanderer</h1>
        <p class="hero-sub">
          <% if (total > 0) { %><%= total %> curated international<% } else { %>Discover<%} %> adventures — Bali, Maldives, Europe, Southeast Asia & more.
        </p>
        <div class="search-wrap fade-in d2">
          <i class="fas fa-search" style="margin-left:1.2rem;color:#bbb;font-size:.9rem"></i>
          <input type="text" id="searchInput" placeholder="Search by destination, country…" autocomplete="off">
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

<!-- ══════════ MAIN ══════════ -->
<main class="container py-4">

  <nav class="tab-nav">
    <a href="tours.jsp"               class="tab-pill"><i class="fas fa-th-large"></i> All Tours</a>
    <a href="domestic-tours.jsp"      class="tab-pill"><i class="fas fa-flag"></i> Domestic</a>
    <a href="international-tours.jsp" class="tab-pill active"><i class="fas fa-globe"></i> International</a>
  </nav>

  <div class="stats-bar fade-in d1">
    <div class="stat"><div class="n"><%= total %></div><div class="l">Total Tours</div></div>
    <div class="stat"><div class="n"><%= featured %></div><div class="l">Featured</div></div>
    <div class="stat"><div class="n"><%= trending %></div><div class="l">Trending</div></div>
    <div class="stat"><div class="n">4.8 ⭐</div><div class="l">Avg Rating</div></div>
  </div>

  <!-- Country quick-filter -->
  <% if (!tours.isEmpty()) {
       Set<String> countries = new LinkedHashSet<>();
       for (Tour t : tours) { if (t.getCountry() != null && !t.getCountry().trim().isEmpty() && !"India".equalsIgnoreCase(t.getCountry().trim())) countries.add(t.getCountry().trim()); }
       if (!countries.isEmpty()) { %>
  <div class="dest-pills" id="destPills">
    <span class="dest-pill dp-active" data-state="all" onclick="filterState(this,'all')">🌍 All Countries</span>
    <% for (String c : countries) { %>
    <span class="dest-pill" data-state="<%= c %>" onclick="filterState(this,'<%= c %>')"><%= c %></span>
    <% } %>
  </div>
  <% } } %>

  <!-- Tour cards -->
  <% if (tours.isEmpty()) { %>
  <div class="no-tours">
    <i class="fas fa-globe-americas"></i>
    <h3 class="mb-2">International Tours Coming Soon!</h3>
    <p style="color:#777">We're building world-class travel packages. Drop us a message to get notified.</p>
    <a href="contact.jsp" class="btn-view mt-3 d-inline-flex">Contact Us &nbsp;<i class="fas fa-arrow-right"></i></a>
  </div>
  <% } else { %>

  <%
    /* Unsplash international fallbacks */
    String[] FALLBACKS = {
      "https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=600&q=70&fit=crop",
      "https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=600&q=70&fit=crop",
      "https://images.unsplash.com/photo-1488085061387-422e29b40080?w=600&q=70&fit=crop",
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&q=70&fit=crop",
      "https://images.unsplash.com/photo-1503220317375-aaad61436b1b?w=600&q=70&fit=crop",
      "images/Himalayan.jpg","images/Himalayan1.jpg"
    };
  %>

  <div class="card-grid" id="cardGrid">
    <%
      int idx = 0;
      for (Tour tour : tours) {
        String img  = (tour.getImageUrl() != null && !tour.getImageUrl().trim().isEmpty())
                        ? tour.getImageUrl()
                        : FALLBACKS[idx % FALLBACKS.length];
        String desc = tour.getDescription() != null ? tour.getDescription() : "";
        String cntry = tour.getCountry() != null ? tour.getCountry() : "";
        String city  = (tour.getDestinationCity() != null && !tour.getDestinationCity().isEmpty()) ? tour.getDestinationCity() : cntry;
        String animClass = "fade-in d" + Math.min(idx + 1, 6);
    %>
    <div class="t-card-wrap <%= animClass %>"
         data-name="<%= tour.getTourName().toLowerCase() %>"
         data-loc="<%= (cntry + " " + city).toLowerCase() %>"
         data-state="<%= cntry.trim() %>"
         data-idx="<%= idx %>">
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
          <span class="t-badge badge-new"><i class="fas fa-globe"></i> International</span>
          <% } %>
          <button class="wishlist" aria-label="Save to wishlist" onclick="heart(this)"><i class="fas fa-heart"></i></button>
          <% if (!cntry.isEmpty()) { %><span class="type-lozenge"><%= cntry.toUpperCase() %></span><% } %>
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
