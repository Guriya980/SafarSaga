package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.dao.InquiryDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.safarsaga.dao.TourDAO;
import com.safarsaga.model.Inquiry;
import java.sql.Date;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Inquiry inquiry = new Inquiry();
        inquiry.setFullName(request.getParameter("fullName"));
        inquiry.setEmail(request.getParameter("email"));
        inquiry.setPhone(request.getParameter("phone"));
        inquiry.setCountryCode(request.getParameter("countryCode"));
        inquiry.setSubject(request.getParameter("subject"));
        inquiry.setMessage(request.getParameter("message"));
        inquiry.setInquiryType(request.getParameter("inquiryType"));
        
        // Tour inquiry specific fields
        String tourIdParam = request.getParameter("tourId");
        if (tourIdParam != null && !tourIdParam.isEmpty()) {
            inquiry.setTourId(Integer.parseInt(tourIdParam));
            
            // Increment tour inquiry count
            TourDAO tourDAO = new TourDAO();
            tourDAO.incrementInquiryCount(Integer.parseInt(tourIdParam));
        }
        
        String travelDateParam = request.getParameter("travelDate");
        if (travelDateParam != null && !travelDateParam.isEmpty()) {
            inquiry.setPreferredTravelDate(Date.valueOf(travelDateParam));
        }
        
        String travelersParam = request.getParameter("numberOfTravelers");
        if (travelersParam != null && !travelersParam.isEmpty()) {
            inquiry.setNumberOfTravelers(Integer.parseInt(travelersParam));
        }
        
        // Track IP and User Agent
        inquiry.setIpAddress(request.getRemoteAddr());
        inquiry.setUserAgent(request.getHeader("User-Agent"));
        
        InquiryDAO inquiryDAO = new InquiryDAO();
        boolean success = inquiryDAO.addInquiry(inquiry);
        
        if (success) {
            request.getSession().setAttribute("inquirySuccess", true);
            response.sendRedirect("contact.jsp?success=true");
        } else {
            response.sendRedirect("contact.jsp?error=true");
        }
    }
}
