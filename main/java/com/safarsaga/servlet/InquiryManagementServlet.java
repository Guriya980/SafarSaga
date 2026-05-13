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
import com.safarsaga.dao.InquiryDAO;
import com.safarsaga.model.Inquiry;
import java.util.List;

@WebServlet("/admin/inquiryManagement")
public class InquiryManagementServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../admin-login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        InquiryDAO inquiryDAO = new InquiryDAO();
        
        if ("view".equals(action)) {
            int inquiryId = Integer.parseInt(request.getParameter("id"));
            Inquiry inquiry = inquiryDAO.getInquiryById(inquiryId);
            request.setAttribute("inquiry", inquiry);
            request.getRequestDispatcher("view-inquiry.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int inquiryId = Integer.parseInt(request.getParameter("id"));
            inquiryDAO.deleteInquiry(inquiryId);
            
            // Log activity
            int adminId = (int) session.getAttribute("adminId");
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, "DELETE_INQUIRY", "Deleted inquiry ID: " + inquiryId, request.getRemoteAddr());
            
            response.sendRedirect("inquiryManagement");
        } else {
            List<Inquiry> inquiries = inquiryDAO.getAllInquiries();
            List<Inquiry> newInquiries = inquiryDAO.getNewInquiries();
            request.setAttribute("inquiries", inquiries);
            request.setAttribute("newInquiries", newInquiries);
            request.getRequestDispatcher("manage-inquiries.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../admin-login.jsp");
            return;
        }
        
        int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
        String status = request.getParameter("status");
        String adminNotes = request.getParameter("adminNotes");
        int adminId = (int) session.getAttribute("adminId");
        
        InquiryDAO inquiryDAO = new InquiryDAO();
        boolean success = inquiryDAO.updateInquiryStatus(inquiryId, status, adminNotes, adminId);
        
        if (success) {
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, "UPDATE_INQUIRY", "Updated inquiry ID: " + inquiryId, request.getRemoteAddr());
            response.sendRedirect("inquiryManagement?success=true");
        } else {
            response.sendRedirect("inquiryManagement?error=true");
        }
    }
}