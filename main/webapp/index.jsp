<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Safarसागा - Chalo Ghum Kar Aate Hain!</title>

    <!-- ===== OG / SEO Meta Tags ===== -->
    <meta name="description" content="Safarसागा – India's most immersive travel experience. Plan your dream trip to Kerala, Rajasthan, Goa & the Himalayas. Chalo Ghum Kar Aate Hain!">
    <meta name="keywords" content="India travel, Kerala backwaters, Rajasthan heritage, Goa beach, Himalayan trek, tour packages, SafarSaga">
    <meta name="robots" content="index, follow">
    <meta name="author" content="SafarSaga">

    <meta property="og:type"        content="website">
    <meta property="og:url"         content="https://www.safarsaga.com/">
    <meta property="og:title"       content="Safarसागा – Chalo Ghum Kar Aate Hain!">
    <meta property="og:description" content="Discover India's most breathtaking destinations. Kerala backwaters, Royal Rajasthan, Goa beaches & Himalayan peaks. Your perfect journey starts here.">
    <meta property="og:image"       content="https://www.safarsaga.com/images/og-cover.jpg">

    <meta name="twitter:card"        content="summary_large_image">
    <meta name="twitter:title"       content="Safarसागा – Chalo Ghum Kar Aate Hain!">
    <meta name="twitter:description" content="India's most beautiful travel experiences. Plan your trip with SafarSaga.">
    <meta name="twitter:image"       content="https://www.safarsaga.com/images/og-cover.jpg">

    <link rel="canonical" href="https://www.safarsaga.com/">
    <!-- ===== End OG Tags ===== -->

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- ===== ADDED: Hero transition + Moving Bus animation ONLY ===== -->
    <style>
        /* Hero slide content fade-up on active */
        .hero-slide .hero-content {
            opacity: 0;
            transform: translateY(28px);
            transition: opacity 0.9s ease 0.35s, transform 0.9s ease 0.35s;
        }
        .hero-slide.active .hero-content {
            opacity: 1;
            transform: translateY(0);
        }

        /* Subtle Ken-Burns zoom on each active slide */
        .hero-slide.active {
            animation: heroKenBurns 8s ease forwards;
        }
        @keyframes heroKenBurns {
            from { background-size: 112%; }
            to   { background-size: 100%; }
        }

        /* ─── Moving Bus Road Strip ─────────────────── */
        .vehicle-road-strip {
            position: relative;
            width: 100%;
            height: 155px;
            background: linear-gradient(to bottom, #0a1628 0%, #0d2018 65%, #061510 100%);
            overflow: hidden;
        }

        /* Twinkling stars */
        .vrs-stars {
            position: absolute; inset: 0; pointer-events: none;
            background-image:
                radial-gradient(1px 1px at 8%  18%, rgba(255,255,255,.85) 0%, transparent 100%),
                radial-gradient(1px 1px at 22% 42%, rgba(255,255,255,.50) 0%, transparent 100%),
                radial-gradient(1px 1px at 37% 12%, rgba(255,255,255,.90) 0%, transparent 100%),
                radial-gradient(1px 1px at 54% 32%, rgba(255,255,255,.60) 0%, transparent 100%),
                radial-gradient(1px 1px at 70%  8%, rgba(255,255,255,.75) 0%, transparent 100%),
                radial-gradient(1.5px 1.5px at 83% 26%, rgba(255,255,255,1) 0%, transparent 100%),
                radial-gradient(1px 1px at 91% 48%, rgba(255,255,255,.40) 0%, transparent 100%),
                radial-gradient(1px 1px at 48% 52%, rgba(255,190,60,.90)  0%, transparent 100%),
                radial-gradient(1px 1px at 64% 40%, rgba(255,255,255,.60) 0%, transparent 100%);
        }

        /* Mountain silhouette */
        .vrs-mountains {
            position: absolute;
            bottom: 33%; left: 0; right: 0;
            height: 55%; pointer-events: none;
        }
        .vrs-mountains svg { width:100%; height:100%; }

        /* Ground */
        .vrs-ground {
            position: absolute;
            bottom: 0; left: 0; right: 0; height: 33%;
            background: linear-gradient(to bottom, #0d2a10, #061008);
        }

        /* Road */
        .vrs-road {
            position: absolute;
            bottom: 8%; left: 0; right: 0; height: 16%;
            background: #161620;
            border-top: 1px solid rgba(255,255,255,.06);
        }
        /* Animated dashes */
        .vrs-road::after {
            content: '';
            position: absolute;
            top: 50%; transform: translateY(-50%);
            left: 0; right: 0; height: 3px;
            background: repeating-linear-gradient(
                90deg,
                #f4a261 0px, #f4a261 36px,
                transparent 36px, transparent 72px
            );
            animation: roadScroll 1s linear infinite;
        }
        @keyframes roadScroll {
            from { background-position: 0 0; }
            to   { background-position: -72px 0; }
        }

        /* Destination pins */
        .vrs-pins {
            position: absolute;
            bottom: calc(8% + 16%);
            left: 0; right: 0;
            display: flex; justify-content: space-around; align-items: flex-end;
            padding: 0 6%; z-index: 6;
        }
        .vrs-pin {
            display: flex; flex-direction: column; align-items: center;
            animation: pinBob 3s ease-in-out infinite;
        }
        .vrs-pin:nth-child(2) { animation-delay: .7s; }
        .vrs-pin:nth-child(3) { animation-delay: 1.4s; }
        .vrs-pin:nth-child(4) { animation-delay: 2.1s; }
        @keyframes pinBob {
            0%,100% { transform: translateY(0); }
            50%     { transform: translateY(-5px); }
        }
        .vrs-pin-label {
            font-family: 'Poppins', sans-serif;
            font-size: .58rem; font-weight: 700;
            letter-spacing: .09em; text-transform: uppercase;
            color: #ffb347; margin-bottom: 3px;
            text-shadow: 0 1px 6px rgba(0,0,0,.9);
            white-space: nowrap;
        }
        .vrs-pin-head {
            width: 22px; height: 22px;
            background: #f4891a;
            border-radius: 50% 50% 50% 0;
            transform: rotate(-45deg);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 2px 10px rgba(244,137,26,.6);
        }
        .vrs-pin-head i { transform: rotate(45deg); color: white; font-size: .58rem; }
        .vrs-pin-stem  { width: 2px; height: 8px; background: linear-gradient(to bottom, #f4891a, transparent); }

        /* Drifting clouds */
        .vrs-cloud {
            position: absolute;
            background: rgba(255,255,255,.05);
            border-radius: 40px;
        }
        .vrs-cloud::before,.vrs-cloud::after {
            content:''; position:absolute;
            background:rgba(255,255,255,.05); border-radius:50%;
        }
        .vrs-cloud-1 { width:70px; height:18px; top:12%; left:5%;
            animation: cloudDrift 22s linear infinite; }
        .vrs-cloud-1::before { width:35px;height:26px;top:-10px;left:8px; }
        .vrs-cloud-1::after  { width:24px;height:20px;top:-7px; left:30px; }
        .vrs-cloud-2 { width:55px; height:14px; top:18%; left:42%;
            animation: cloudDrift 30s linear infinite; animation-delay:-10s; }
        .vrs-cloud-2::before { width:28px;height:22px;top:-9px;left:7px; }
        .vrs-cloud-2::after  { width:20px;height:16px;top:-6px;left:26px; }
        @keyframes cloudDrift {
            from { transform: translateX(110vw); }
            to   { transform: translateX(-200px); }
        }

        /* The Bus */
        .vrs-bus {
            position: absolute;
            bottom: calc(8% + 1px);
            left: -200px;
            width: 155px; z-index: 10;
            animation: busDrive 16s linear infinite;
            filter: drop-shadow(0 4px 14px rgba(244,137,26,.45));
        }
        @keyframes busDrive {
            0%   { left: -200px; }
            100% { left: calc(100% + 200px); }
        }
        /* Subtle bounce */
        .vrs-bus svg {
            animation: busBounce .28s ease-in-out infinite alternate;
        }
        @keyframes busBounce {
            from { transform: translateY(0); }
            to   { transform: translateY(-2px); }
        }
    </style>
    <!-- ===== END ADDED STYLES ===== -->
</head>
<body>
     
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-brand">
                <a href="index.jsp">
                    <span class="brand-safar">Safar</span><span class="brand-saga">सागा</span>
                </a>
            </div>
            <div class="nav-menu" id="navMenu">
                <a href="index.jsp" class="nav-link active">Home</a>
                <a href="tours.jsp" class="nav-link">Tours</a>
                <a href="blog.jsp" class="nav-link">Blog</a>
                <a href="contact.jsp" class="nav-link">Contact</a>
                <a href="admin-login.jsp" class="nav-link admin-link"><i class="fas fa-user-shield"></i> Admin</a>
            </div>
            <div class="nav-actions">
                <button class="theme-toggle" id="themeToggle">
                    <i class="fas fa-sun"></i>
                </button>
                <button class="language-toggle">
                    <i class="fas fa-globe"></i>
                </button>
                <a href="plan-trip.jsp" class="btn-primary">Plan My Trip</a>
                <button class="nav-toggle" id="navToggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-slider">
            <div class="hero-slide active" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.4)), url('images/kerala.webp');">
                <div class="hero-content">
                    <div class="hero-tag">Kerala Backwaters</div>
                    <h1 class="hero-title">Kerala Backwaters</h1>
                    <p class="hero-subtitle">Experience tranquil houseboat journeys</p>
                    <p class="hero-hindi">Chalo Ghum Kar Aate Hain!</p>
                    <a href="plan-trip.jsp" class="btn-hero">Plan My Trip</a>
                </div>
            </div>
            <div class="hero-slide" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.4)), url('images/Rajasthan.jpg');">
                <div class="hero-content">
                    <div class="hero-tag">Rajasthan Heritage</div>
                    <h1 class="hero-title">Royal Rajasthan</h1>
                    <p class="hero-subtitle">Discover palaces and desert landscapes</p>
                    <p class="hero-hindi">Chalo Ghum Kar Aate Hain!</p>
                    <a href="plan-trip.jsp" class="btn-hero">Plan My Trip</a>
                </div>
            </div>
            <div class="hero-slide" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.4)), url('images/Himalayan.jpg');">
                <div class="hero-content">
                    <div class="hero-tag">Himalayan Adventure</div>
                    <h1 class="hero-title">Himalayan Peaks</h1>
                    <p class="hero-subtitle">Trek through majestic mountains</p>
                    <p class="hero-hindi">Chalo Ghum Kar Aate Hain!</p>
                    <a href="plan-trip.jsp" class="btn-hero">Plan My Trip</a>
                </div>
            </div>
        </div>
        <button class="slider-control prev" id="prevSlide"><i class="fas fa-chevron-left"></i></button>
        <button class="slider-control next" id="nextSlide"><i class="fas fa-chevron-right"></i></button>
        <div class="slider-dots" id="sliderDots"></div>
    </section>

    <!-- ===== ADDED: Moving Bus Road Strip (sits between Hero and Featured Tours) ===== -->
    <div class="vehicle-road-strip">
        <div class="vrs-stars"></div>

        <div class="vrs-mountains">
            <svg viewBox="0 0 1440 160" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0,160 L0,100 L80,60 L160,85 L260,30 L360,65 L460,20 L560,55 L660,28 L760,62 L860,18 L960,52 L1060,32 L1160,58 L1260,38 L1360,65 L1440,48 L1440,160 Z" fill="#0a1a0f"/>
                <path d="M0,160 L0,130 L100,105 L200,120 L300,85 L400,108 L500,78 L600,102 L700,82 L800,110 L900,75 L1000,100 L1100,82 L1200,108 L1300,88 L1440,112 L1440,160 Z" fill="#061008"/>
            </svg>
        </div>

        <div class="vrs-cloud vrs-cloud-1"></div>
        <div class="vrs-cloud vrs-cloud-2"></div>
        <div class="vrs-ground"></div>
        <div class="vrs-road"></div>

        <!-- Destination pins -->
        <div class="vrs-pins">
            <div class="vrs-pin">
                <div class="vrs-pin-label">Kerala</div>
                <div class="vrs-pin-head"><i class="fas fa-water"></i></div>
                <div class="vrs-pin-stem"></div>
            </div>
            <div class="vrs-pin">
                <div class="vrs-pin-label">Rajasthan</div>
                <div class="vrs-pin-head"><i class="fas fa-crown"></i></div>
                <div class="vrs-pin-stem"></div>
            </div>
            <div class="vrs-pin">
                <div class="vrs-pin-label">Goa</div>
                <div class="vrs-pin-head"><i class="fas fa-umbrella-beach"></i></div>
                <div class="vrs-pin-stem"></div>
            </div>
            <div class="vrs-pin">
                <div class="vrs-pin-label">Himalayas</div>
                <div class="vrs-pin-head"><i class="fas fa-mountain"></i></div>
                <div class="vrs-pin-stem"></div>
            </div>
        </div>

        <!-- Moving Bus SVG -->
        <div class="vrs-bus">
            <svg viewBox="0 0 160 68" xmlns="http://www.w3.org/2000/svg">
                <rect x="4"  y="14" width="148" height="40" rx="7" fill="#f4891a"/>
                <rect x="10" y="9"  width="130" height="8"  rx="3" fill="#e07210"/>
                <rect x="7"  y="17" width="28"  height="22" rx="4" fill="#b8e0f7" opacity="0.85"/>
                <rect x="46" y="18" width="20"  height="15" rx="3" fill="#b8e0f7" opacity="0.85"/>
                <rect x="72" y="18" width="20"  height="15" rx="3" fill="#b8e0f7" opacity="0.85"/>
                <rect x="98" y="18" width="20"  height="15" rx="3" fill="#b8e0f7" opacity="0.85"/>
                <rect x="4"  y="37" width="148" height="5"  fill="#c75a05"/>
                <text x="80" y="52" font-size="5.5" fill="white" font-weight="bold"
                      text-anchor="middle" font-family="Poppins,sans-serif">SAFARSAGA</text>
                <ellipse cx="153" cy="28" rx="4"   ry="3"   fill="#fff9a0" opacity="0.9"/>
                <ellipse cx="153" cy="38" rx="3"   ry="2.5" fill="#ffcc44" opacity="0.8"/>
                <rect x="4" y="22" width="3" height="8" rx="1.5" fill="#ff4444" opacity="0.8"/>
                <circle cx="34"  cy="56" r="10" fill="#1a1a1a"/>
                <circle cx="34"  cy="56" r="5.5" fill="#333"/>
                <circle cx="34"  cy="56" r="2"   fill="#888"/>
                <circle cx="120" cy="56" r="10" fill="#1a1a1a"/>
                <circle cx="120" cy="56" r="5.5" fill="#333"/>
                <circle cx="120" cy="56" r="2"   fill="#888"/>
                <!-- Exhaust smoke -->
                <circle cx="7" cy="49" r="4" fill="rgba(255,255,255,0.1)">
                    <animate attributeName="r"       from="3"   to="9"  dur="1.1s" repeatCount="indefinite"/>
                    <animate attributeName="opacity" from="0.12" to="0"  dur="1.1s" repeatCount="indefinite"/>
                    <animate attributeName="cx"      from="7"   to="-8" dur="1.1s" repeatCount="indefinite"/>
                </circle>
                <circle cx="7" cy="46" r="3" fill="rgba(255,255,255,0.08)">
                    <animate attributeName="r"       from="2"   to="7"  dur="1.4s" repeatCount="indefinite" begin="0.4s"/>
                    <animate attributeName="opacity" from="0.1"  to="0"  dur="1.4s" repeatCount="indefinite" begin="0.4s"/>
                    <animate attributeName="cx"      from="7"   to="-6" dur="1.4s" repeatCount="indefinite" begin="0.4s"/>
                </circle>
            </svg>
        </div>
    </div>
    <!-- ===== END ADDED: Moving Bus Road Strip ===== -->

    <!-- Featured Tours Section -->
    <section class="featured-tours">
        <div class="container">
            <div class="section-header">
                <span class="section-tag">Popular Destinations</span>
                <h2 class="section-title">Featured Tours</h2>
                <p class="section-subtitle">Handpicked experiences across incredible India</p>
            </div>
            <div class="tours-grid">
                <div class="tour-card">
                    <div class="tour-image">
                        <img src="images/Kerala1.jpg" alt="Kerala Tour" loading="lazy">
                        <div class="tour-badge">Trending</div>
                        <button class="tour-wishlist"><i class="far fa-heart"></i></button>
                    </div>
                    <div class="tour-content">
                        <div class="tour-meta">
                            <span><i class="fas fa-map-marker-alt"></i> Kerala</span>
                            <span><i class="fas fa-clock"></i> 5 Days</span>
                        </div>
                        <h3 class="tour-title">Kerala Backwater Paradise</h3>
                        <p class="tour-description">Experience the serene beauty of Kerala's backwaters with luxury houseboats</p>
                        <div class="tour-footer">
                          
                            <a href="tour-details.jsp?id=1" class="btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>

                <div class="tour-card">
                    <div class="tour-image">
                        <img src="images/Rajasthan1.jpg" alt="Rajasthan Tour" loading="lazy">
                        <div class="tour-badge">Popular</div>
                        <button class="tour-wishlist"><i class="far fa-heart"></i></button>
                    </div>
                    <div class="tour-content">
                        <div class="tour-meta">
                            <span><i class="fas fa-map-marker-alt"></i> Rajasthan</span>
                            <span><i class="fas fa-clock"></i> 7 Days</span>
                        </div>
                        <h3 class="tour-title">Royal Rajasthan Heritage</h3>
                        <p class="tour-description">Explore magnificent palaces, forts and vibrant culture of Rajasthan</p>
                        <div class="tour-footer">
                           
                            <a href="tour-details.jsp?id=2" class="btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>

                <div class="tour-card">
                    <div class="tour-image">
                        <img src="images/Goa.jpg" alt="Goa Tour" loading="lazy">
                        <div class="tour-badge">Beach</div>
                        <button class="tour-wishlist"><i class="far fa-heart"></i></button>
                    </div>
                    <div class="tour-content">
                        <div class="tour-meta">
                            <span><i class="fas fa-map-marker-alt"></i> Goa</span>
                            <span><i class="fas fa-clock"></i> 4 Days</span>
                        </div>
                        <h3 class="tour-title">Goa Beach Retreat</h3>
                        <p class="tour-description">Relax on pristine beaches and enjoy vibrant nightlife of Goa</p>
                        <div class="tour-footer">
                            
                            <a href="tour-details.jsp?id=3" class="btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>

                <div class="tour-card">
                    <div class="tour-image">
                        <img src="images/Himalayan1.jpg" alt="Himalayas Tour" loading="lazy">
                        <div class="tour-badge">Adventure</div>
                        <button class="tour-wishlist"><i class="far fa-heart"></i></button>
                    </div>
                    <div class="tour-content">
                        <div class="tour-meta">
                            <span><i class="fas fa-map-marker-alt"></i> Himachal</span>
                            <span><i class="fas fa-clock"></i> 6 Days</span>
                        </div>
                        <h3 class="tour-title">Himalayan Adventure</h3>
                        <p class="tour-description">Trek through breathtaking mountain landscapes and ancient monasteries</p>
                        <div class="tour-footer">
                           
                            <a href="tour-details.jsp?id=4" class="btn-secondary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-cta">
                <a href="tours.jsp" class="btn-outline">View All Tours</a>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="why-choose">
        <div class="container">
            <div class="section-header">
                <span class="section-tag">Why Safarसागा</span>
                <h2 class="section-title">Your Perfect Travel Partner</h2>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Safe & Secure</h3>
                    <p>Travel with confidence knowing your safety is our priority</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3>24/7 Support</h3>
                    <p>Round-the-clock assistance for a worry-free journey</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3>Best Prices</h3>
                    <p>Competitive rates with no hidden charges</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3>Expert Guides</h3>
                    <p>Local experts who bring destinations to life</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
        <div class="container">
            <div class="section-header">
                <span class="section-tag">Traveler Stories</span>
                <h2 class="section-title">What Our Travelers Say</h2>
            </div>
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">"The Kerala backwater tour was absolutely magical! The houseboat experience and local cuisine were unforgettable. Safarसागा made everything seamless."</p>
                    <div class="testimonial-author">
                        <img src="https://i.pravatar.cc/150?img=1" alt="Priya Sharma" loading="lazy">
                        <div>
                            <h4>Priya Sharma</h4>
                            <span>Mumbai</span>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">"Exploring the palaces of Rajasthan was a dream come true. The guides were knowledgeable and the itinerary was perfect. Highly recommend!"</p>
                    <div class="testimonial-author">
                        <img src="https://i.pravatar.cc/150?img=33" alt="Rahul Verma" loading="lazy">
                        <div>
                            <h4>Rahul Verma</h4>
                            <span>Delhi</span>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">"The Himalayan trek was challenging but incredibly rewarding. Professional team and stunning views. Best adventure of my life!"</p>
                    <div class="testimonial-author">
                        <img src="https://i.pravatar.cc/150?img=5" alt="Anjali Patel" loading="lazy">
                        <div>
                            <h4>Anjali Patel</h4>
                            <span>Bangalore</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <h3 class="footer-brand">
                        <span class="brand-safar">Safar</span><span class="brand-saga">सागा</span>
                    </h3>
                    <p>Chalo Ghum Kar Aate Hain! Your journey to incredible India starts here.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="tours.jsp">Tours</a></li>
                        <li><a href="blog.jsp">Blog</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Destinations</h4>
                    <ul>
                        <li><a href="#">Kerala</a></li>
                        <li><a href="#">Rajasthan</a></li>
                        <li><a href="#">Goa</a></li>
                        <li><a href="#">Himalayas</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Contact Us</h4>
                    <ul>
                        <li><i class="fas fa-phone"></i> +91 83199 32061</li>
                        <li><i class="fas fa-envelope"></i> info@safarsaga.com</li>
                        <li><i class="fas fa-map-marker-alt"></i> Bhopal, India</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Safarसागा. All rights reserved. |</p>
            </div>
        </div>
    </footer>

    <script src="js/main.js"></script>
</body>
</html>
