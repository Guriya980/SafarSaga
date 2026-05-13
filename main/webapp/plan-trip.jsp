<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.safarsaga.dao.TourDAO, com.safarsaga.model.Tour, java.util.List" %>
<%
    TourDAO tourDAO = new TourDAO();
    List<Tour> allTours = tourDAO.getAllTours();
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plan Your Trip - SafarSaga</title>
    <meta name="description" content="Plan your dream trip with SafarSaga. Tell us where you want to go and our experts will create a custom itinerary just for you!">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;800&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: #f8fafc; }

        /* ── Hero ── */
        .plan-hero {
            background: linear-gradient(135deg, rgba(26,26,46,0.85), rgba(15,52,96,0.8)),
                        url('images/Himalayan.jpg') center/cover no-repeat fixed;
            min-height: 380px;
            display: flex; align-items: center; justify-content: center;
            text-align: center; padding: 5rem 1rem 4rem;
            position: relative; overflow: hidden;
        }
        .plan-hero::before {
            content: ''; position: absolute; inset: 0;
            background: radial-gradient(ellipse at center, rgba(26,138,122,0.15) 0%, transparent 70%);
        }
        .plan-hero h1 {
            font-family: 'Playfair Display', serif; font-size: clamp(2rem, 5vw, 3.2rem);
            color: white; font-weight: 800; margin-bottom: 1rem; position: relative;
        }
        .plan-hero h1 span { color: #4adeaa; }
        .plan-hero p { color: rgba(255,255,255,0.8); font-size: 1.05rem; max-width: 560px; margin: 0 auto; position: relative; }

        /* ── Steps ── */
        .steps-bar { background: linear-gradient(90deg, #1a8a7a, #27ae60); padding: 1.5rem; }
        .step-item { text-align: center; color: white; }
        .step-num { width: 36px; height: 36px; border-radius: 50%; background: rgba(255,255,255,0.2);
                    display: inline-flex; align-items: center; justify-content: center;
                    font-weight: 700; margin-bottom: 0.3rem; font-size: 0.9rem; }
        .step-label { font-size: 0.75rem; opacity: 0.9; display: block; }

        /* ── Form Card ── */
        .form-wrapper { max-width: 920px; margin: -50px auto 3rem; padding: 0 1rem; position: relative; z-index: 10; }
        .form-card { background: white; border-radius: 24px; box-shadow: 0 20px 60px rgba(0,0,0,0.12); overflow: hidden; }
        .form-header { background: linear-gradient(135deg, #1a8a7a, #27ae60); padding: 2rem 2.5rem; color: white; }
        .form-header h3 { font-family: 'Playfair Display', serif; font-size: 1.6rem; font-weight: 700; margin-bottom: 0.3rem; }
        .form-body { padding: 2.5rem; }

        .section-label { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 2px;
                         color: #1a8a7a; font-weight: 700; margin-bottom: 1rem; margin-top: 1.5rem;
                         display: flex; align-items: center; gap: 8px; }
        .section-label::after { content: ''; flex: 1; height: 1px; background: #e8f5e9; }

        .form-label { font-weight: 600; font-size: 0.875rem; color: #374151; margin-bottom: 0.4rem; }
        .form-control, .form-select {
            border-radius: 12px; border: 1.5px solid #e5e7eb; padding: 0.75rem 1rem;
            font-size: 0.9rem; transition: all 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #1a8a7a; box-shadow: 0 0 0 4px rgba(26,138,122,0.1); outline: none;
        }
        .form-control::placeholder { color: #9ca3af; }
        textarea.form-control { resize: vertical; min-height: 110px; }

        .radio-group { display: flex; flex-wrap: wrap; gap: 10px; }
        .radio-pill { display: flex; align-items: center; gap: 8px; padding: 0.5rem 1.1rem;
                      border: 1.5px solid #e5e7eb; border-radius: 50px; cursor: pointer;
                      font-size: 0.85rem; transition: all 0.2s; font-weight: 500; color: #555; }
        .radio-pill input { display: none; }
        .radio-pill:has(input:checked),
        .radio-pill.selected { border-color: #1a8a7a; background: #f0faf8; color: #1a8a7a; }
        .radio-pill:hover { border-color: #1a8a7a; }
        .radio-pill .icon { font-size: 1rem; }

        .traveler-counter { display: flex; align-items: center; gap: 12px; }
        .counter-btn { width: 40px; height: 40px; border-radius: 50%; border: 1.5px solid #e5e7eb;
                       background: white; cursor: pointer; font-size: 1.1rem; font-weight: 700;
                       display: flex; align-items: center; justify-content: center; transition: all 0.2s;
                       color: #1a8a7a; }
        .counter-btn:hover { background: #1a8a7a; color: white; border-color: #1a8a7a; }
        .counter-val { font-size: 1.3rem; font-weight: 700; color: #1a1a2e; min-width: 30px; text-align: center; }

        .budget-pills { display: flex; flex-wrap: wrap; gap: 8px; }
        .budget-pill { padding: 0.5rem 1.1rem; border: 1.5px solid #e5e7eb; border-radius: 50px;
                       cursor: pointer; font-size: 0.82rem; font-weight: 500; color: #555; transition: all 0.2s; }
        .budget-pill:hover, .budget-pill.active { background: #f0faf8; border-color: #1a8a7a; color: #1a8a7a; }

        .btn-submit-trip {
            background: linear-gradient(135deg, #1a8a7a, #27ae60);
            border: none; color: white; padding: 1rem 3rem;
            border-radius: 50px; font-weight: 700; font-size: 1rem;
            letter-spacing: 0.3px; transition: all 0.3s; cursor: pointer;
            box-shadow: 0 8px 25px rgba(26,138,122,0.35);
        }
        .btn-submit-trip:hover { transform: translateY(-2px); box-shadow: 0 12px 35px rgba(26,138,122,0.45); }

        /* ── Why Us ── */
        .why-card { background: white; border-radius: 16px; padding: 2rem; text-align: center;
                    box-shadow: 0 4px 20px rgba(0,0,0,0.06); transition: transform 0.2s; height: 100%; }
        .why-card:hover { transform: translateY(-4px); }
        .why-icon { width: 64px; height: 64px; border-radius: 18px; display: flex; align-items: center;
                    justify-content: center; font-size: 1.5rem; margin: 0 auto 1rem; }

        /* ── Alert ── */
        .alert-success-custom { background: linear-gradient(135deg, #d4edda, #c3e6cb);
                                 border: none; border-radius: 16px; color: #155724; padding: 1.2rem 1.5rem; }

        @media (max-width: 768px) {
            .form-body { padding: 1.5rem; }
            .form-header { padding: 1.5rem; }
            .plan-hero { min-height: 280px; }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- Hero -->
<section class="plan-hero">
    <div>
        <div style="display:inline-block;background:rgba(255,255,255,0.12);backdrop-filter:blur(10px);
                    border:1px solid rgba(255,255,255,0.2);border-radius:50px;padding:0.4rem 1.2rem;
                    color:rgba(255,255,255,0.9);font-size:0.8rem;font-weight:600;letter-spacing:2px;
                    text-transform:uppercase;margin-bottom:1rem;">
            ✈️ Free Trip Planning
        </div>
        <h1>Plan Your <span>Dream Trip</span></h1>
        <p>Tell us where you want to go and our travel experts will craft a personalized itinerary just for you — absolutely free!</p>
    </div>
</section>

<!-- Steps Bar -->
<div class="steps-bar">
    <div style="max-width:900px;margin:0 auto;display:grid;grid-template-columns:repeat(4,1fr);gap:1rem">
        <div class="step-item">
            <div class="step-num">1</div>
            <span class="step-label">Fill the Form</span>
        </div>
        <div class="step-item">
            <div class="step-num">2</div>
            <span class="step-label">We Plan for You</span>
        </div>
        <div class="step-item">
            <div class="step-num">3</div>
            <span class="step-label">Review Itinerary</span>
        </div>
        <div class="step-item">
            <div class="step-num">4</div>
            <span class="step-label">Pack & Go!</span>
        </div>
    </div>
</div>

<!-- Main Form -->
<div class="form-wrapper">
    <% if ("true".equals(success)) { %>
    <div class="alert alert-success-custom d-flex align-items-start gap-3 mb-4">
        <i class="fas fa-check-circle fa-2x" style="color:#27ae60;flex-shrink:0;margin-top:2px"></i>
        <div>
            <strong style="font-size:1.05rem">Your Trip Request is Submitted! 🎉</strong><br>
            <span>Our travel experts will contact you within <strong>24 hours</strong> with a personalized itinerary. Check your email!</span>
        </div>
    </div>
    <% } %>
    <% if ("true".equals(error)) { %>
    <div class="alert alert-danger rounded-3 mb-4">
        <i class="fas fa-exclamation-triangle me-2"></i>Something went wrong. Please try again or call us at <strong>+91-8319932061</strong>.
    </div>
    <% } %>

    <div class="form-card">
        <div class="form-header">
            <div class="d-flex align-items-center gap-3">
                <div style="width:50px;height:50px;background:rgba(255,255,255,0.15);border-radius:14px;
                            display:flex;align-items:center;justify-content:center;font-size:1.4rem">🗺️</div>
                <div>
                    <h3>Plan My Trip</h3>
                    <p style="opacity:0.85;font-size:0.88rem;margin:0">Our experts will respond within 24 hours with a custom plan</p>
                </div>
            </div>
        </div>

        <div class="form-body">
            <form action="<%=request.getContextPath()%>/contact" method="post">
                <input type="hidden" name="inquiryType" value="PLAN_TRIP">

                <!-- Personal Details -->
                <div class="section-label"><i class="fas fa-user"></i> Your Details</div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name <span class="text-danger">*</span></label>
                        <input type="text" name="fullName" class="form-control" placeholder="e.g. Rahul Sharma" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <select name="countryCode" style="max-width:90px;border-radius:12px 0 0 12px;border:1.5px solid #e5e7eb;border-right:none;padding:0.75rem 0.5rem;font-size:0.85rem;background:white">
                                <option value="+91">🇮🇳 +91</option>
                                <option value="+1">🇺🇸 +1</option>
                                <option value="+44">🇬🇧 +44</option>
                                <option value="+61">🇦🇺 +61</option>
                                <option value="+971">🇦🇪 +971</option>
                            </select>
                            <input type="tel" name="phone" class="form-control" style="border-radius:0 12px 12px 0" 
                                   placeholder="98765 43210" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Your City / State</label>
                        <input type="text" name="subject" class="form-control" placeholder="e.g. Mumbai, Maharashtra">
                    </div>
                </div>

                <!-- Trip Details -->
                <div class="section-label mt-4"><i class="fas fa-map-marked-alt"></i> Trip Details</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label">Where do you want to go? <span class="text-danger">*</span></label>
                        <div class="row g-2">
                            <div class="col-md-8">
                                <input type="text" name="destination" id="destinationInput" class="form-control"
                                       placeholder="e.g. Goa, Rajasthan, Dubai, Bali, or multiple destinations..." required>
                            </div>
                            <div class="col-md-4">
                                <select name="tourId" class="form-select" onchange="fillDestination(this)">
                                    <option value="">Or choose a tour package</option>
                                    <% for (Tour t : allTours) { %>
                                    <option value="<%= t.getTourId() %>" data-dest="<%= t.getTourName() %>">
                                        <%= t.getTourName() %> (<%= t.getDurationDays() %>D/<%= t.getDurationNights() %>N)
                                    </option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <label class="form-label mb-2">Tour Type</label>
                        <div class="radio-group" id="tourTypeGroup">
                            <label class="radio-pill selected">
                                <input type="radio" name="tourTypePreference" value="Domestic" checked>
                                <span class="icon">🇮🇳</span> Domestic (India)
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="tourTypePreference" value="International">
                                <span class="icon">🌍</span> International
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="tourTypePreference" value="Both">
                                <span class="icon">🗺️</span> Both / Open
                            </label>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Preferred Travel Date</label>
                        <input type="date" name="travelDate" class="form-control"
                               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Trip Duration (approx.)</label>
                        <select name="duration" class="form-select">
                            <option value="">Select duration</option>
                            <option>Weekend (2-3 days)</option>
                            <option>Short Trip (4-5 days)</option>
                            <option>1 Week (6-7 days)</option>
                            <option>10 Days</option>
                            <option>2 Weeks</option>
                            <option>3+ Weeks</option>
                            <option>Flexible</option>
                        </select>
                    </div>
                </div>

                <!-- Travelers -->
                <div class="section-label mt-4"><i class="fas fa-users"></i> Travelers</div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-4">
                        <label class="form-label">Total Travelers</label>
                        <div class="traveler-counter">
                            <button type="button" class="counter-btn" onclick="changeCount(-1)">−</button>
                            <span class="counter-val" id="travelCount">2</span>
                            <button type="button" class="counter-btn" onclick="changeCount(1)">+</button>
                        </div>
                        <input type="hidden" name="numberOfTravelers" id="travelerInput" value="2">
                    </div>
                    <div class="col-md-8">
                        <label class="form-label mb-2">Traveler Type</label>
                        <div class="radio-group">
                            <label class="radio-pill selected">
                                <input type="radio" name="travelerType" value="Couple" checked>
                                <span>💑</span> Couple
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="travelerType" value="Family">
                                <span>👨‍👩‍👧‍👦</span> Family
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="travelerType" value="Friends">
                                <span>👥</span> Friends
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="travelerType" value="Solo">
                                <span>🧳</span> Solo
                            </label>
                            <label class="radio-pill">
                                <input type="radio" name="travelerType" value="Honeymoon">
                                <span>💍</span> Honeymoon
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Preferences -->
                <div class="section-label mt-4"><i class="fas fa-heart"></i> Interests & Preferences</div>
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label mb-2">What kind of experience are you looking for?</label>
                        <div class="radio-group" id="interestGroup">
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Adventure">🏔️ Adventure
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Beach">🏖️ Beach
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Heritage">🏛️ Heritage
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Nature">🌿 Nature
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Wildlife">🦁 Wildlife
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Honeymoon">💑 Romantic
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Spiritual">🙏 Spiritual
                            </label>
                            <label class="radio-pill">
                                <input type="checkbox" name="interests" value="Food">🍛 Food & Culture
                            </label>
                        </div>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Anything specific you want? <small class="text-muted">(optional)</small></label>
                        <textarea name="message" class="form-control" 
                                  placeholder="e.g. We want to include a houseboat stay in Kerala, prefer hill stations, need a wheelchair accessible hotel, vegetarian meals only, celebrating anniversary..."></textarea>
                    </div>
                </div>

                <!-- Submit -->
                <div class="d-flex flex-wrap gap-3 align-items-center justify-content-between mt-4 pt-3"
                     style="border-top:1px solid #f0f0f0">
                    <div>
                        <div style="font-size:0.8rem;color:#888">
                            <i class="fas fa-lock me-1"></i> Your data is secure & never shared.
                        </div>
                        <div style="font-size:0.8rem;color:#1a8a7a;font-weight:600">
                            <i class="fas fa-clock me-1"></i> Response within 24 hours guaranteed!
                        </div>
                    </div>
                    <button type="submit" class="btn-submit-trip">
                        <i class="fas fa-paper-plane me-2"></i>Submit Trip Request
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Why Plan with Us -->
<section style="background:#f8fafc;padding:4rem 0">
    <div style="max-width:1100px;margin:0 auto;padding:0 1.5rem">
        <div style="text-align:center;margin-bottom:3rem">
            <div style="color:#1a8a7a;font-size:0.75rem;text-transform:uppercase;letter-spacing:3px;font-weight:700;margin-bottom:.5rem">Why Choose Us</div>
            <h2 style="font-family:'Playfair Display',serif;font-size:2rem;font-weight:800;color:#1a1a2e">Plan with Confidence</h2>
        </div>
        <div class="row g-3">
            <div class="col-6 col-md-3">
                <div class="why-card">
                    <div class="why-icon" style="background:#eafaf1"><span style="font-size:1.6rem">🆓</span></div>
                    <h6 class="fw-bold mb-1">100% Free</h6>
                    <p class="text-muted small">Trip planning is completely free. No hidden charges.</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="why-card">
                    <div class="why-icon" style="background:#ebf5fb"><span style="font-size:1.6rem">🧠</span></div>
                    <h6 class="fw-bold mb-1">Expert Planners</h6>
                    <p class="text-muted small">10+ years of experience crafting perfect itineraries.</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="why-card">
                    <div class="why-icon" style="background:#fef9e7"><span style="font-size:1.6rem">✨</span></div>
                    <h6 class="fw-bold mb-1">Customized Plan</h6>
                    <p class="text-muted small">Every trip is uniquely tailored to your interests.</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="why-card">
                    <div class="why-icon" style="background:#fdf2f8"><span style="font-size:1.6rem">📞</span></div>
                    <h6 class="fw-bold mb-1">24/7 Support</h6>
                    <p class="text-muted small">We're with you before, during, and after your trip.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Need Help Banner -->
<section style="background:linear-gradient(135deg,#1a8a7a,#27ae60);padding:3rem 1.5rem;text-align:center">
    <h3 style="color:white;font-family:'Playfair Display',serif;font-size:1.7rem;margin-bottom:.5rem">
        Prefer to talk to us directly?
    </h3>
    <p style="color:rgba(255,255,255,.85);margin-bottom:1.5rem">Our team is ready to help you plan the perfect trip!</p>
    <div class="d-flex gap-3 justify-content-center flex-wrap">
        <a href="tel:+918319932061" style="background:white;color:#1a8a7a;border:none;padding:.8rem 2rem;border-radius:50px;font-weight:700;text-decoration:none;display:flex;align-items:center;gap:8px">
            <i class="fas fa-phone"></i> +91 83199 32061
        </a>
        <a href="https://wa.me/918319932061" target="_blank" style="background:#25d366;color:white;border:none;padding:.8rem 2rem;border-radius:50px;font-weight:700;text-decoration:none;display:flex;align-items:center;gap:8px">
            <i class="fab fa-whatsapp"></i> WhatsApp Us
        </a>
        <a href="contact.jsp" style="background:rgba(255,255,255,.15);color:white;border:2px solid rgba(255,255,255,.4);padding:.8rem 2rem;border-radius:50px;font-weight:700;text-decoration:none;display:flex;align-items:center;gap:8px">
            <i class="fas fa-envelope"></i> Send Email
        </a>
    </div>
</section>

<%@ include file="footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Traveler counter
    function changeCount(delta) {
        const el = document.getElementById('travelCount');
        const inp = document.getElementById('travelerInput');
        let val = Math.max(1, Math.min(50, parseInt(el.textContent) + delta));
        el.textContent = val;
        inp.value = val;
    }

    // Radio pill toggle style
    document.querySelectorAll('.radio-pill input[type="radio"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const group = this.closest('.radio-group, .row');
            if (group) {
                group.querySelectorAll('.radio-pill').forEach(p => p.classList.remove('selected'));
            }
            this.closest('.radio-pill').classList.add('selected');
        });
    });

    // Checkbox interest pills
    document.querySelectorAll('#interestGroup .radio-pill input[type="checkbox"]').forEach(cb => {
        cb.addEventListener('change', function() {
            this.closest('.radio-pill').classList.toggle('selected', this.checked);
        });
    });

    // Fill destination from dropdown
    function fillDestination(sel) {
        const opt = sel.options[sel.selectedIndex];
        if (opt.value && opt.dataset.dest) {
            document.getElementById('destinationInput').value = opt.dataset.dest;
        }
    }
</script>
</body>
</html>
