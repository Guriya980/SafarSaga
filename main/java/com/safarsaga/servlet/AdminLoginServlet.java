package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.authenticate(username, password);
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminId", admin.getAdminId());
            session.setAttribute("adminName", admin.getFullName());
            session.setMaxInactiveInterval(3600); // 1 hour
            
            // Log activity
            String ipAddress = request.getRemoteAddr();
            adminDAO.logActivity(admin.getAdminId(), "LOGIN", "Admin logged in successfully", ipAddress);
            
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
