<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - SafarSaga</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

    <%@ include file="navbar.jsp" %>
    
    <!-- Hero Section -->
    <section class="py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-3">Get In Touch</h1>
            <p class="lead">We'd love to hear from you. Send us a message!</p>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="py-5">
        <div class="container">
            
            <div class="row">
                <!-- Contact Form -->
                <div class="col-lg-8">
                    <div class="card shadow-sm">
                        <div class="card-body p-4">
                            <h3 class="mb-4">Send Us a Message</h3>

                            <!-- UPDATED FORM ACTION -->
                            <form action="<%=request.getContextPath()%>/contact" method="post">
                                
                                <input type="hidden" name="inquiryType" value="GENERAL">
                                <input type="hidden" name="countryCode" value="+91">

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Full Name *</label>
                                        <input type="text" name="fullName" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email Address *</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Phone Number *</label>
                                        <input type="tel" name="phone" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Subject *</label>
                                        <input type="text" name="subject" class="form-control" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Message *</label>
                                    <textarea name="message" class="form-control" rows="5" required 
                                    placeholder="Tell us how we can help you..."></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-paper-plane"></i> Send Message
                                </button>

                            </form>
                        </div>
                    </div>
                </div>

                <!-- Contact Info -->
                <div class="col-lg-4">

                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h5 class="mb-3">
                                <i class="fas fa-map-marker-alt text-primary"></i> Our Office
                            </h5>
                            <p class="mb-0">
                                SafarSaga Travel Services<br>
                                Bhopal, Madhya Pradesh<br>
                                India - 462001
                            </p>
                        </div>
                    </div>

                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h5 class="mb-3">
                                <i class="fas fa-phone text-primary"></i> Phone
                            </h5>
                            <p class="mb-0">
                                +91 83199 32061<br>
                                <small class="text-muted">
                                    Mon - Sat: 9:00 AM - 7:00 PM
                                </small>
                            </p>
                        </div>
                    </div>

                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h5 class="mb-3">
                                <i class="fas fa-envelope text-primary"></i> Email
                            </h5>
                            <p class="mb-0">
                                info@safarsaga.com<br>
                                support@safarsaga.com
                            </p>
                        </div>
                    </div>

                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="mb-3">
                                <i class="fas fa-share-alt text-primary"></i> Follow Us
                            </h5>
                            <div class="d-flex gap-3">
                                <a href="#" class="btn btn-outline-primary btn-sm">
                                    <i class="fab fa-facebook"></i>
                                </a>
                                <a href="#" class="btn btn-outline-danger btn-sm">
                                    <i class="fab fa-instagram"></i>
                                </a>
                                <a href="#" class="btn btn-outline-info btn-sm">
                                    <i class="fab fa-twitter"></i>
                                </a>
                                <a href="#" class="btn btn-outline-danger btn-sm">
                                    <i class="fab fa-youtube"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- SUCCESS & ERROR ALERTS -->
    <% if ("true".equals(request.getParameter("success"))) { %>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Message Sent!',
            text: 'Your request has been sent to our team successfully.',
            confirmButtonColor: '#3085d6',
            timer: 3000,
            timerProgressBar: true,
            showConfirmButton: false
        }).then(() => {
            window.location.href = 'index.jsp';
        });
    </script>
    <% } %>

    <% if ("true".equals(request.getParameter("error"))) { %>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Oops!',
            text: 'Something went wrong. Please try again.',
            confirmButtonColor: '#d33'
        });
    </script>
    <% } %>

</body>
</html>
