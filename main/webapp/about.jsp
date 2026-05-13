<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | SafarSaga</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700;800&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Poppins', sans-serif; color: #1a1a2e; }

        /* HERO */
        .about-hero {
            min-height: 500px; display: flex; align-items: center;
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
        }
        .about-hero::before {
            content: ''; position: absolute; inset: 0;
            background: url('images/Himalayan.jpg') center/cover no-repeat;
            opacity: 0.18;
        }
        .about-hero .container { position: relative; z-index: 2; }
        .hero-chip {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(255,255,255,0.1); backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.2); color: #a8e6cf;
            border-radius: 50px; padding: 0.4rem 1.2rem; font-size: 0.82rem;
            font-weight: 600; margin-bottom: 1.5rem;
        }
        .about-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.2rem, 5vw, 3.8rem);
            font-weight: 800; color: white; line-height: 1.2; margin-bottom: 1rem;
        }
        .about-title .gold { color: #f6d365; }
        .hero-text { color: rgba(255,255,255,0.75); font-size: 1.1rem; max-width: 600px; }
        .scroll-indicator {
            position: absolute; bottom: 30px; left: 50%; transform: translateX(-50%);
            color: rgba(255,255,255,0.5); text-align: center; font-size: 0.8rem;
            animation: bounce 2s infinite;
        }
        @keyframes bounce { 0%,100% { transform: translateX(-50%) translateY(0); } 50% { transform: translateX(-50%) translateY(-8px); } }

        /* STORY SECTION */
        .story-section { padding: 6rem 0; }
        .story-img-wrap {
            position: relative; border-radius: 24px; overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.12);
        }
        .story-img-wrap img { width: 100%; height: 420px; object-fit: cover; display: block; }
        .story-img-badge {
            position: absolute; bottom: 24px; left: 24px;
            background: white; border-radius: 16px; padding: 1rem 1.5rem;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }
        .story-img-badge .big { font-size: 1.8rem; font-weight: 800; color: #1a8a7a; }
        .story-img-badge .small-text { font-size: 0.8rem; color: #666; }
        .section-tag-green {
            display: inline-block; background: #e8f7f3; color: #1a8a7a;
            border-radius: 50px; padding: 0.3rem 1rem; font-size: 0.8rem;
            font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 1rem;
        }
        .section-h2 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.8rem, 3.5vw, 2.5rem); font-weight: 700;
            color: #1a1a2e; line-height: 1.3; margin-bottom: 1.2rem;
        }
        .story-text { color: #555; line-height: 1.8; font-size: 1.02rem; margin-bottom: 1rem; }
        .story-highlights { display: flex; flex-wrap: wrap; gap: 1rem; margin-top: 2rem; }
        .highlight-pill {
            display: flex; align-items: center; gap: 8px;
            background: #f0faf7; border: 1.5px solid #c3e8d8;
            border-radius: 50px; padding: 0.5rem 1.2rem;
            color: #1a8a7a; font-weight: 600; font-size: 0.875rem;
        }

        /* MISSION/VISION */
        .mv-section {
            padding: 5rem 0;
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f7f0 100%);
        }
        .mv-card {
            background: white; border-radius: 24px; padding: 2.5rem;
            box-shadow: 0 8px 30px rgba(0,0,0,0.07);
            height: 100%; transition: transform 0.3s;
        }
        .mv-card:hover { transform: translateY(-6px); }
        .mv-icon {
            width: 70px; height: 70px; border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem; margin-bottom: 1.5rem;
        }
        .mv-card h3 { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; margin-bottom: 1rem; }
        .mv-card p { color: #666; line-height: 1.8; }

        /* TEAM */
        .team-section { padding: 6rem 0; }
        .team-card {
            background: white; border-radius: 20px;
            overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            transition: all 0.3s; text-align: center;
        }
        .team-card:hover { transform: translateY(-8px); box-shadow: 0 20px 50px rgba(0,0,0,0.12); }
        .team-img-wrap { position: relative; height: 200px; overflow: hidden; }
        .team-img-wrap img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .team-card:hover .team-img-wrap img { transform: scale(1.07); }
        .team-social {
            position: absolute; bottom: 0; left: 0; right: 0;
            background: linear-gradient(0deg, rgba(26,138,122,0.85), transparent);
            padding: 1.5rem 1rem 0.8rem;
            transform: translateY(100%); transition: transform 0.3s;
        }
        .team-card:hover .team-social { transform: translateY(0); }
        .team-social a { color: white; margin: 0 6px; font-size: 1.1rem; }
        .team-body { padding: 1.5rem; }
        .team-name { font-weight: 700; font-size: 1.05rem; color: #1a1a2e; margin-bottom: 0.3rem; }
        .team-role { color: #1a8a7a; font-size: 0.85rem; font-weight: 600; }

        /* WHY CHOOSE US */
        .why-section {
            padding: 5rem 0;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #1a8a7a 100%);
        }
        .why-card {
            background: rgba(255,255,255,0.07); backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 20px; padding: 2rem; text-align: center;
            transition: all 0.3s; height: 100%;
        }
        .why-card:hover { background: rgba(255,255,255,0.12); transform: translateY(-6px); }
        .why-icon {
            width: 64px; height: 64px; border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            background: rgba(255,255,255,0.1); font-size: 1.5rem; color: #a8e6cf;
            margin: 0 auto 1.2rem;
        }
        .why-card h5 { color: white; font-weight: 700; margin-bottom: 0.7rem; }
        .why-card p { color: rgba(255,255,255,0.65); font-size: 0.88rem; line-height: 1.7; }

        /* ANIMATED FADE */
        .animate-in { animation: fadeUp 0.7s ease both; }
        @keyframes fadeUp { from { opacity:0; transform:translateY(28px); } to { opacity:1; transform:translateY(0); } }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <!-- HERO -->
    <section class="about-hero">
        <div class="container">
            <div class="animate-in">
                <div class="hero-chip"><i class="fas fa-compass"></i> Our Story</div>
                <h1 class="about-title">Crafting Memories,<br>One <span class="gold">Safar</span> at a Time</h1>
                <p class="hero-text">SafarSaga is more than a travel company — we're your companions in discovering the world's most incredible destinations.</p>
            </div>
        </div>
        <div class="scroll-indicator">
            <i class="fas fa-chevron-down fa-lg"></i><br>Scroll to explore
        </div>
    </section>

    <!-- STORY -->
    <section class="story-section">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 animate-in">
                    <div class="story-img-wrap">
                        <img src="images/Kerala1.jpg" alt="Our Story"
                             onerror="this.src='https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=420&fit=crop'">
                        <div class="story-img-badge">
                            <div class="big">2020</div>
                            <div class="small-text">Founded with passion</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 animate-in delay-2">
                    <div class="section-tag-green"><i class="fas fa-book-open me-1"></i> Our Story</div>
                    <h2 class="section-h2">Born From a Love<br>of Exploration</h2>
                    <p class="story-text">SafarSaga was born from a passion for travel and a dream to make incredible journeys accessible to everyone. Our team of travel enthusiasts and local experts work tirelessly to curate the perfect adventures for you.</p>
                    <p class="story-text">We believe every journey changes you. That's why we pour our hearts into every tour we design — ensuring you return home not just with photos, but with stories worth telling.</p>
                    <div class="story-highlights">
                        <div class="highlight-pill"><i class="fas fa-check"></i> Personalized Itineraries</div>
                        <div class="highlight-pill"><i class="fas fa-check"></i> Local Expert Guides</div>
                        <div class="highlight-pill"><i class="fas fa-check"></i> Transparent Pricing</div>
                        <div class="highlight-pill"><i class="fas fa-check"></i> 24/7 Support</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MISSION & VISION -->
    <section class="mv-section">
        <div class="container">
            <div class="text-center mb-5 animate-in">
                <div class="section-tag-green">What Drives Us</div>
                <h2 class="section-h2">Mission & Vision</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 animate-in delay-1">
                    <div class="mv-card">
                        <div class="mv-icon" style="background: #e8f7f3;"><i class="fas fa-bullseye" style="color:#1a8a7a;"></i></div>
                        <h3>Our Mission</h3>
                        <p>To provide authentic, memorable, and hassle-free travel experiences that connect people with cultures, nature, and themselves. We believe travel enriches lives and broadens perspectives.</p>
                    </div>
                </div>
                <div class="col-md-6 animate-in delay-2">
                    <div class="mv-card">
                        <div class="mv-icon" style="background: #f0e8ff;"><i class="fas fa-eye" style="color:#764ba2;"></i></div>
                        <h3>Our Vision</h3>
                        <p>To become India's most loved and trusted travel platform, inspiring millions to explore the world responsibly while promoting sustainable tourism and cultural preservation.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- TEAM -->
    <section class="team-section">
        <div class="container">
            <div class="text-center mb-5 animate-in">
                <div class="section-tag-green">The People Behind SafarSaga</div>
                <h2 class="section-h2">Meet Our Team</h2>
                <p style="color:#777; max-width:500px; margin: 0 auto;">Passionate travelers and local experts dedicated to creating your perfect journey</p>
            </div>
            <div class="row g-4 justify-content-center">
                <% String[][] team = {
                    {"Rahul Sharma", "Founder & CEO", "fas fa-user-tie", "#1a8a7a"},
                    {"Priya Menon", "Tour Director", "fas fa-map-marked-alt", "#764ba2"},
                    {"Amit Patel", "Travel Expert", "fas fa-hiking", "#e67e22"},
                    {"Anita Singh", "Customer Success", "fas fa-headset", "#e74c3c"}
                };
                for (String[] member : team) { %>
                <div class="col-6 col-lg-3 animate-in">
                    <div class="team-card">
                        <div class="team-img-wrap">
                            <div style="background: linear-gradient(135deg, <%= member[3] %>22, <%= member[3] %>44); height:100%; display:flex; align-items:center; justify-content:center;">
                                <i class="<%= member[2] %>" style="font-size:4rem; color:<%= member[3] %>; opacity:0.7;"></i>
                            </div>
                            <div class="team-social">
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                                <a href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                        <div class="team-body">
                            <div class="team-name"><%= member[0] %></div>
                            <div class="team-role"><%= member[1] %></div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- WHY CHOOSE US -->
    <section class="why-section">
        <div class="container">
            <div class="text-center mb-5 animate-in">
                <div style="display:inline-block;background:rgba(255,255,255,0.1);color:#a8e6cf;border-radius:50px;padding:0.3rem 1rem;font-size:0.8rem;font-weight:700;text-transform:uppercase;letter-spacing:1px;margin-bottom:0.8rem;">
                    Why Us
                </div>
                <h2 class="section-h2" style="color:white;">Why Choose SafarSaga</h2>
            </div>
            <div class="row g-4">
                <% String[][] reasons = {
                    {"fas fa-shield-alt", "Safe & Secure", "Your safety is our top priority with verified local partners and 24/7 emergency support throughout your trip."},
                    {"fas fa-headset", "24/7 Support", "Round-the-clock assistance ensures you're never alone, whether it's a question or an unexpected situation."},
                    {"fas fa-tags", "Best Prices", "Competitive and transparent pricing with no hidden charges — what you see is what you pay."},
                    {"fas fa-map-signs", "Local Experts", "Our knowledgeable local guides bring every destination to life with stories you won't find in guidebooks."}
                };
                for (String[] r : reasons) { %>
                <div class="col-sm-6 col-lg-3 animate-in">
                    <div class="why-card">
                        <div class="why-icon"><i class="<%= r[0] %>"></i></div>
                        <h5><%= r[1] %></h5>
                        <p><%= r[2] %></p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
