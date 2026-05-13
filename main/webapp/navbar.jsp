<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <span style="color: #0d6efd;">Safar</span><span style="color: #dc3545;">सागा</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="toursDropdown" role="button" data-bs-toggle="dropdown">
                        Tours
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="tours">All Tours</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="tours?type=DOMESTIC">Domestic Tours</a></li>
                        <li><a class="dropdown-item" href="tours?type=INTERNATIONAL">International Tours</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="blogs">Blog</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-primary" href="admin-login.jsp"><i class="fas fa-user-shield"></i> Admin</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
