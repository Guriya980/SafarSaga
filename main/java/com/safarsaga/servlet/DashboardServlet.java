package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.dao.BlogDAO;
import com.safarsaga.dao.InquiryDAO;
import com.safarsaga.dao.TourDAO;
import com.safarsaga.dao.VisitorAnalyticsDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../admin-login.jsp");
            return;
        }
        
        // Get statistics
        TourDAO tourDAO = new TourDAO();
        BlogDAO blogDAO = new BlogDAO();
        InquiryDAO inquiryDAO = new InquiryDAO();
        VisitorAnalyticsDAO analyticsDAO = new VisitorAnalyticsDAO();
        
        request.setAttribute("totalTours", tourDAO.getAllTours().size());
        request.setAttribute("totalBlogs", blogDAO.getAllBlogs().size());
        request.setAttribute("totalInquiries", inquiryDAO.getInquiryCount());
        request.setAttribute("newInquiries", inquiryDAO.getNewInquiryCount());
        request.setAttribute("totalVisitors", analyticsDAO.getTotalVisitors());
        request.setAttribute("todayVisitors", analyticsDAO.getTodayVisitors());
        request.setAttribute("monthVisitors", analyticsDAO.getThisMonthVisitors());
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
