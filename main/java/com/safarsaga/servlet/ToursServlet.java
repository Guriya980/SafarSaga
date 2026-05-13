package com.safarsaga.servlet;

import com.safarsaga.dao.TourDAO;
import com.safarsaga.model.Tour;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/tours")
public class ToursServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String type = request.getParameter("type");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String search = request.getParameter("search");
        String tourIdParam = request.getParameter("id");
        
        TourDAO tourDAO = new TourDAO();
        
        if ("view".equals(action) && tourIdParam != null) {
            // View single tour detail
            int tourId = Integer.parseInt(tourIdParam);
            Tour tour = tourDAO.getTourById(tourId);
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("tour-details.jsp").forward(request, response);
            
        } else if (search != null && !search.trim().isEmpty()) {
            // Search tours
            List<Tour> tours = tourDAO.searchTours(search);
            request.setAttribute("tours", tours);
            request.setAttribute("searchKeyword", search);
            request.getRequestDispatcher("tours.jsp").forward(request, response);
            
        } else if ("DOMESTIC".equalsIgnoreCase(type)) {
            // Domestic tours
            List<Tour> tours;
            if (state != null && !state.isEmpty()) {
                tours = tourDAO.getToursByState(state);
                request.setAttribute("selectedState", state);
            } else {
                tours = tourDAO.getToursByType("DOMESTIC");
            }
            request.setAttribute("tours", tours);
            request.setAttribute("tourType", "DOMESTIC");
            request.getRequestDispatcher("domestic-tours.jsp").forward(request, response);
            
        } else if ("INTERNATIONAL".equalsIgnoreCase(type)) {
            // International tours
            List<Tour> tours;
            if (country != null && !country.isEmpty()) {
                tours = tourDAO.getToursByCountry(country);
                request.setAttribute("selectedCountry", country);
            } else {
                tours = tourDAO.getToursByType("INTERNATIONAL");
            }
            request.setAttribute("tours", tours);
            request.setAttribute("tourType", "INTERNATIONAL");
            request.getRequestDispatcher("international-tours.jsp").forward(request, response);
            
        } else {
            // All tours
            List<Tour> tours = tourDAO.getAllTours();
            request.setAttribute("tours", tours);
            request.getRequestDispatcher("tours.jsp").forward(request, response);
        }
    }
}