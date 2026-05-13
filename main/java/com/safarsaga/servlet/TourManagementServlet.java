package com.safarsaga.servlet;

import com.safarsaga.dao.AdminDAO;
import com.safarsaga.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import com.safarsaga.dao.TourDAO;
import com.safarsaga.model.Tour;
import java.util.List;

@WebServlet("/tourManagement")
@MultipartConfig(
	    maxFileSize    = 10485760,   // 10 MB
	    maxRequestSize = 52428800,   // 50 MB
	    fileSizeThreshold = 1048576  // 1 MB
	)
public class TourManagementServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        TourDAO tourDAO = new TourDAO();

        if ("edit".equals(action)) {
            int tourId = Integer.parseInt(request.getParameter("id"));
            Tour tour = tourDAO.getTourById(tourId);
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("admin/edit-tour.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int tourId = Integer.parseInt(request.getParameter("id"));
            tourDAO.deleteTour(tourId);

            int adminId = (int) session.getAttribute("adminId");
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, "DELETE_TOUR", "Deleted tour ID: " + tourId, request.getRemoteAddr());

            response.sendRedirect("tourManagement");
        } else {
            List<Tour> tours = tourDAO.getAllTours();
            request.setAttribute("tours", tours);
            request.getRequestDispatcher("admin/manage-tours.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String action = request.getParameter("action");
        TourDAO tourDAO = new TourDAO();
        int adminId = (int) session.getAttribute("adminId");

        Tour tour = new Tour();
        tour.setTourName(request.getParameter("tourName"));
        tour.setTourType(request.getParameter("tourType"));
        tour.setCategory(request.getParameter("category"));
        tour.setState(request.getParameter("state"));
        tour.setCountry(request.getParameter("country"));
        tour.setDestinationCity(request.getParameter("destinationCity"));

        String daysStr = request.getParameter("durationDays");
        String nightsStr = request.getParameter("durationNights");
        tour.setDurationDays(daysStr != null && !daysStr.isEmpty() ? Integer.parseInt(daysStr) : 1);
        tour.setDurationNights(nightsStr != null && !nightsStr.isEmpty() ? Integer.parseInt(nightsStr) : 0);

        tour.setDescription(request.getParameter("description"));
        tour.setDetailedItinerary(request.getParameter("detailedItinerary"));
        tour.setHighlights(request.getParameter("highlights"));
        tour.setInclusions(request.getParameter("inclusions"));
        tour.setExclusions(request.getParameter("exclusions"));
        tour.setBestSeason(request.getParameter("bestSeason"));
        tour.setFeatured("on".equals(request.getParameter("isFeatured")));
        tour.setTrending("on".equals(request.getParameter("isTrending")));

        // ── IMAGE HANDLING ──
        // 1. Check if a new file was uploaded
        // 2. Fall back to imageUrl text field (gallery selection)
        String imageUrl = request.getParameter("imageUrl");

        try {
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Sanitize filename
                fileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_");

                String uploadDir = getServletContext().getRealPath("") + File.separator + "images";
                File uploadFolder = new File(uploadDir);
                if (!uploadFolder.exists()) uploadFolder.mkdirs();

                try (InputStream is = filePart.getInputStream()) {
                    Files.copy(is, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
                }
                imageUrl = "images/" + fileName;
            }
        } catch (Exception e) {
            // file part not present – use imageUrl text field
        }

        if (imageUrl == null || imageUrl.isEmpty()) {
            imageUrl = "images/Himalayan.jpg"; // default fallback
        }
        tour.setImageUrl(imageUrl);

        boolean success = false;
        String logAction = "";

        if ("add".equals(action)) {
            tour.setCreatedBy(adminId);
            success = tourDAO.addTour(tour);
            logAction = "ADD_TOUR";
        } else if ("update".equals(action)) {
            String tourIdStr = request.getParameter("tourId");
            if (tourIdStr != null && !tourIdStr.isEmpty()) {
                tour.setTourId(Integer.parseInt(tourIdStr));
            }
            success = tourDAO.updateTour(tour);
            logAction = "UPDATE_TOUR";
        }

        if (success) {
            AdminDAO adminDAO = new AdminDAO();
            adminDAO.logActivity(adminId, logAction, "Tour: " + tour.getTourName(), request.getRemoteAddr());
            response.sendRedirect("tourManagement?success=true");
        } else {
            response.sendRedirect("tourManagement?error=true");
        }
    }
}