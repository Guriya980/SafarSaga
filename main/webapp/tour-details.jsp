<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.model.Tour, com.safarsaga.dao.TourDAO" %>
<%
    String tourIdParam = request.getParameter("id");
    Tour tour = null;
    if (tourIdParam != null && !tourIdParam.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(tourIdParam);
            TourDAO tourDAO = new TourDAO();
            tour = tourDAO.getTourById(id);
        } catch (Exception e) {
            // log error if needed
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= (tour != null) ? tour.getTourName() : "Tour Not Found" %> | SafarSaga</title>

    <!-- Open Graph -->
    <meta property="og:title" content="<%= (tour != null) ? tour.getTourName() : "Tour Details" %> | SafarSaga">
    <meta property="og:description" content="<%= (tour != null && tour.getDescription() != null) ? tour.getDescription().substring(0, Math.min(160, tour.getDescription().length())) : "Discover incredible journeys with SafarSaga" %>">
    <meta property="og:image" content="<%= (tour != null && tour.getImageUrl() != null) ? tour.getImageUrl() : "https://yourdomain.com/images/default-tour-og.jpg" %>">
    <meta property="og:url" content="<%= request.getRequestURL() %>">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        :root {
            --saga-teal:    #0f766e;
            --saga-emerald: #10b981;
            --saga-saffron: #f59e0b;
            --saga-dark:    #0f172a;
            --saga-sand:    #fef8f1;
            --glow:         0 8px 32px rgba(16,185,129,0.22);
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: var(--saga-sand);
            color: #1e293b;
            line-height: 1.6;
        }

        h1, h2, h3, h4 { font-family: 'Playfair Display', serif; font-weight: 700; }

        /* ── HERO ──────────────────────────────────────────────── */
        .tour-hero {
            height: 70vh;
            min-height: 520px;
            position: relative;
            display: flex;
            align-items: flex-end;
            color: white;
            overflow: hidden;
        }

        .tour-hero-bg {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
            transform: scale(1.08);
            transition: transform 0.8s ease;
        }

        .tour-hero:hover .tour-hero-bg { transform: scale(1.12); }

        .hero-gradient {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(15,22,42,0.88) 0%, rgba(15,22,42,0.45) 50%, transparent 100%);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            width: 100%;
            padding: 4rem 1.5rem 5rem;
        }

        .tour-type-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.18);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.25);
            color: white;
            padding: 0.45rem 1.2rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1.2rem;
        }

        .tour-title {
            font-size: clamp(2.4rem, 6.5vw, 4.8rem);
            line-height: 1.05;
            margin-bottom: 0.8rem;
            text-shadow: 0 4px 16px rgba(0,0,0,0.6);
        }

        .tour-subtitle {
            font-size: 1.25rem;
            opacity: 0.92;
            margin-bottom: 1.8rem;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1.2rem;
        }

        .meta-pill {
            background: rgba(255,255,255,0.16);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.22);
            color: white;
            padding: 0.5rem 1.1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* ── MAIN CONTENT ──────────────────────────────────────── */
        .main-content { padding: 5rem 0 4rem; }

        .section-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.06);
            margin-bottom: 2.5rem;
            overflow: hidden;
        }

        .section-header {
            background: linear-gradient(135deg, #f8fafc, #f1f5f9);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .section-icon {
            width: 48px;
            height: 48px;
            background: var(--saga-emerald);
            color: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }

        .section-title {
            font-size: 1.45rem;
            margin: 0;
            color: var(--saga-dark);
        }

        .section-body { padding: 2rem; }

        .highlight-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.2rem;
        }

        .highlight-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            padding: 1rem;
            background: #f8fafc;
            border-radius: 12px;
        }

        .highlight-icon {
            color: var(--saga-saffron);
            font-size: 1.4rem;
            margin-top: 4px;
        }

        .itinerary-timeline {
            position: relative;
            padding-left: 2.5rem;
        }

        .itinerary-day {
            position: relative;
            margin-bottom: 2.2rem;
        }

        .day-marker {
            position: absolute;
            left: -2.2rem;
            top: 0.6rem;
            width: 16px;
            height: 16px;
            background: white;
            border: 4px solid var(--saga-emerald);
            border-radius: 50%;
            z-index: 2;
        }

        .day-line {
            position: absolute;
            left: -1.75rem;
            top: 2.2rem;
            bottom: -2.2rem;
            width: 2px;
            background: #e2e8f0;
        }

        .day-content {
            background: #f8fafc;
            padding: 1.4rem;
            border-radius: 12px;
            border-left: 4px solid var(--saga-emerald);
        }

        .ie-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .ie-list li {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .ie-list li:last-child { border-bottom: none; }

        .check { color: #10b981; }
        .cross { color: #ef4444; }

        /* ── SIDEBAR INQUIRY ───────────────────────────────────── */
        .inquiry-sidebar {
            position: sticky;
            top: 100px;
            background: white;
            border-radius: 16px;
            box-shadow: var(--glow);
            overflow: hidden;
        }

        .inquiry-header {
            background: linear-gradient(135deg, var(--saga-teal), var(--saga-emerald));
            color: white;
            padding: 2rem 1.8rem;
            text-align: center;
        }

        .inquiry-header h5 {
            font-size: 1.4rem;
            margin-bottom: 0.4rem;
        }

        .inquiry-body {
            padding: 1.8rem;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.45rem;
            color: #475569;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 1.1rem;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: var(--saga-emerald);
            box-shadow: 0 0 0 3px rgba(16,185,129,0.15);
        }

        .btn-book {
            width: 100%;
            background: linear-gradient(90deg, var(--saga-teal), var(--saga-emerald));
            border: none;
            color: white;
            font-weight: 600;
            padding: 1rem;
            border-radius: 50px;
            transition: all 0.3s;
        }

        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: var(--glow);
        }

        /* Fade-in stagger */
        .fade-in { opacity: 0; transform: translateY(24px); transition: all 0.8s ease-out; }
        .fade-in.visible { opacity: 1; transform: translateY(0); }

        @media (max-width: 992px) {
            .inquiry-sidebar { position: static; margin-top: 2rem; }
            .tour-hero { height: 60vh; min-height: 480px; }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<% if (tour != null) {
    String imgSrc = (tour.getImageUrl() != null && !tour.getImageUrl().trim().isEmpty()) 
                    ? tour.getImageUrl() 
                    : "images/default-tour-hero.jpg";
    String location = (tour.getState() != null && !tour.getState().isEmpty()) 
                      ? tour.getState() 
                      : (tour.getCountry() != null ? tour.getCountry() : "India");
%>
<!-- HERO -->
<section class="tour-hero">
    <div class="tour-hero-bg" style="background-image: url('<%= imgSrc %>');"></div>
    <div class="hero-gradient"></div>
    <div class="container hero-content">
        <div class="tour-type-badge">
            <i class="fas fa-compass"></i> <%= tour.getTourType() %>
        </div>
        <h1 class="tour-title"><%= tour.getTourName() %></h1>
        <p class="tour-subtitle">
            <i class="fas fa-map-marker-alt me-2"></i><%= location %>
            <% if (tour.getDestinationCity() != null && !tour.getDestinationCity().isEmpty()) { %>
                , <%= tour.getDestinationCity() %>
            <% } %>
        </p>

        <div class="hero-meta">
            <div class="meta-pill"><i class="fas fa-clock me-1"></i> <%= tour.getDurationDays() %> Days
                <% if (tour.getDurationNights() > 0) { %> / <%= tour.getDurationNights() %> Nights <% } %>
            </div>
            <% if (tour.getBestSeason() != null && !tour.getBestSeason().isEmpty()) { %>
            <div class="meta-pill"><i class="fas fa-calendar-days me-1"></i> <%= tour.getBestSeason() %></div>
            <% } %>
            <% if (tour.getCategory() != null && !tour.getCategory().isEmpty()) { %>
            <div class="meta-pill"><i class="fas fa-tag me-1"></i> <%= tour.getCategory() %></div>
            <% } %>
            <% if (tour.isFeatured()) { %>
            <div class="meta-pill"><i class="fas fa-star me-1" style="color:#fcd34d;"></i> Featured</div>
            <% } %>
        </div>
    </div>
</section>

<!-- MAIN CONTENT -->
<section class="main-content">
    <div class="container">
        <div class="row g-5">
            <!-- LEFT COLUMN -->
            <div class="col-lg-8">

                <!-- Overview -->
                <div class="section-card fade-in">
                    <div class="section-header">
                        <div class="section-icon"><i class="fas fa-compass"></i></div>
                        <h2 class="section-title">Tour Overview</h2>
                    </div>
                    <div class="section-body">
                        <p style="font-size:1.05rem; color:#334155; line-height:1.8;">
                            <%= tour.getDescription() != null ? tour.getDescription() : "Experience an unforgettable journey with SafarSaga." %>
                        </p>

                        <!-- Quick Facts -->
                        <div class="row g-3 mt-4">
                            <div class="col-md-6 col-lg-4">
                                <div class="fact-card p-3 bg-light rounded">
                                    <strong>Duration</strong><br>
                                    <%= tour.getDurationDays() %> Days
                                    <% if (tour.getDurationNights() > 0) { %> / <%= tour.getDurationNights() %> Nights <% } %>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="fact-card p-3 bg-light rounded">
                                    <strong>Best Time</strong><br>
                                    <%= tour.getBestSeason() != null ? tour.getBestSeason() : "All year round" %>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-4">
                                <div class="fact-card p-3 bg-light rounded">
                                    <strong>Category</strong><br>
                                    <%= tour.getCategory() != null ? tour.getCategory() : "Adventure / Cultural" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Highlights -->
                <% if (tour.getHighlights() != null && !tour.getHighlights().isEmpty()) { %>
                <div class="section-card fade-in">
                    <div class="section-header">
                        <div class="section-icon"><i class="fas fa-star"></i></div>
                        <h2 class="section-title">Tour Highlights</h2>
                    </div>
                    <div class="section-body">
                        <div class="highlight-grid">
                            <% for (String h : tour.getHighlights().split("\\n")) {
                                h = h.trim();
                                if (!h.isEmpty() && !h.startsWith("-") && !h.startsWith("•")) { %>
                            <div class="highlight-item">
                                <i class="fas fa-check-circle highlight-icon"></i>
                                <span><%= h %></span>
                            </div>
                            <% }} %>
                        </div>
                    </div>
                </div>
                <% } %>

                <!-- Itinerary -->
                <% if (tour.getDetailedItinerary() != null && !tour.getDetailedItinerary().isEmpty()) { %>
                <div class="section-card fade-in">
                    <div class="section-header">
                        <div class="section-icon"><i class="fas fa-route"></i></div>
                        <h2 class="section-title">Detailed Itinerary</h2>
                    </div>
                    <div class="section-body">
                        <div class="itinerary-timeline">
                            <% 
                                String[] lines = tour.getDetailedItinerary().split("\\n");
                                int dayCount = 0;
                                for (String line : lines) {
                                    line = line.trim();
                                    if (line.isEmpty()) continue;
                                    if (line.toLowerCase().startsWith("day")) {
                                        dayCount++;
                            %>
                            <div class="itinerary-day">
                                <div class="day-marker"></div>
                                <% if (dayCount > 1) { %><div class="day-line"></div><% } %>
                                <h5 style="color:var(--saga-teal); font-weight:700;">Day <%= dayCount %></h5>
                                <div class="day-content"><%= line.replaceFirst("(?i)^day\\s*\\d+\\s*[-:]", "").trim() %></div>
                            </div>
                            <% } else if (dayCount > 0) { %>
                            <div class="day-content" style="margin-left:2.8rem; margin-top:-1rem;"><%= line %></div>
                            <% }} %>
                        </div>
                    </div>
                </div>
                <% } %>

                <!-- Inclusions & Exclusions -->
                <div class="row g-4 fade-in">
                    <% if (tour.getInclusions() != null && !tour.getInclusions().isEmpty()) { %>
                    <div class="col-md-6">
                        <div class="section-card h-100">
                            <div class="section-header">
                                <div class="section-icon"><i class="fas fa-check"></i></div>
                                <h2 class="section-title">What's Included</h2>
                            </div>
                            <div class="section-body">
                                <ul class="ie-list">
                                    <% for (String inc : tour.getInclusions().split("\\n")) {
                                        inc = inc.trim().replaceAll("^[•\\-*]\\s*", "");
                                        if (!inc.isEmpty()) { %>
                                    <li><i class="fas fa-check check"></i> <%= inc %></li>
                                    <% }} %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <% if (tour.getExclusions() != null && !tour.getExclusions().isEmpty()) { %>
                    <div class="col-md-6">
                        <div class="section-card h-100">
                            <div class="section-header">
                                <div class="section-icon" style="background:#fee2e2;"><i class="fas fa-times"></i></div>
                                <h2 class="section-title">What's Not Included</h2>
                            </div>
                            <div class="section-body">
                                <ul class="ie-list">
                                    <% for (String exc : tour.getExclusions().split("\\n")) {
                                        exc = exc.trim().replaceAll("^[•\\-*]\\s*", "");
                                        if (!exc.isEmpty()) { %>
                                    <li><i class="fas fa-times cross"></i> <%= exc %></li>
                                    <% }} %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>

            </div>

            <!-- RIGHT COLUMN - INQUIRY -->
            <div class="col-lg-4">
                <div class="inquiry-sidebar fade-in">
                    <div class="inquiry-header">
                        <h5>Ready to Book?</h5>
                        <p>Send us your details — we'll get back within 24 hours</p>
                    </div>
                    <div class="inquiry-body">
                        <form action="contact" method="post">
                            <input type="hidden" name="inquiryType" value="TOUR_INQUIRY">
                            <input type="hidden" name="tourId" value="<%= tour.getTourId() %>">
                            <input type="hidden" name="subject" value="Booking Inquiry: <%= tour.getTourName() %>">

                            <div class="mb-3">
                                <label class="form-label">Full Name *</label>
                                <input type="text" name="fullName" class="form-control" required placeholder="Your name">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email Address *</label>
                                <input type="email" name="email" class="form-control" required placeholder="you@example.com">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone Number *</label>
                                <input type="tel" name="phone" class="form-control" required placeholder="+91 98765 43210">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Preferred Travel Date</label>
                                <input type="date" name="travelDate" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Number of Travelers</label>
                                <input type="number" name="numberOfTravelers" class="form-control" min="1" value="2">
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Any Special Requests?</label>
                                <textarea name="message" class="form-control" rows="3" placeholder="Dietary needs, room preference, etc..."></textarea>
                            </div>

                            <button type="submit" class="btn-book">
                                <i class="fas fa-paper-plane me-2"></i> Send Inquiry
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<% } else { %>
<section class="py-5 text-center">
    <div class="container py-5">
        <i class="fas fa-compass fa-6x mb-4" style="color:#cbd5e1;"></i>
        <h2 class="fw-bold mb-3">Tour Not Found</h2>
        <p class="text-muted fs-5 mb-4">The tour you're looking for doesn't exist or has been removed.</p>
        <a href="tours.jsp" class="btn btn-lg btn-success rounded-pill px-5 py-3">
            <i class="fas fa-arrow-left me-2"></i> Browse All Tours
        </a>
    </div>
</section>
<% } %>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Simple fade-in on scroll
document.addEventListener('DOMContentLoaded', () => {
    const elements = document.querySelectorAll('.fade-in');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    elements.forEach(el => observer.observe(el));
});
</script>
</body>
</html>