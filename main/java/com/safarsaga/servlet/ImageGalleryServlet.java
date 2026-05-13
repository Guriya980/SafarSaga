package com.safarsaga.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


@WebServlet("/imageGallery")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class ImageGalleryServlet extends HttpServlet {

    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "webp", "gif");

    // GET: return JSON list of images
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String imagesDir = getServletContext().getRealPath("") + File.separator + "images";
        File folder = new File(imagesDir);
        List<String> imageList = new ArrayList<>();

        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles();
            if (files != null) {
                for (File f : files) {
                    String ext = getExtension(f.getName()).toLowerCase();
                    if (ALLOWED_EXTENSIONS.contains(ext)) {
                        imageList.add("images/" + f.getName());
                    }
                }
            }
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        // Simple JSON array without external library
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < imageList.size(); i++) {
            json.append("\"").append(imageList.get(i)).append("\"");
            if (i < imageList.size() - 1) json.append(",");
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    // POST: upload a new image
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("imageUpload");
        if (filePart == null || filePart.getSize() == 0) {
            response.setStatus(400);
            response.getWriter().write("{\"error\":\"No file\"}");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String ext = getExtension(fileName).toLowerCase();
        if (!ALLOWED_EXTENSIONS.contains(ext)) {
            response.setStatus(400);
            response.getWriter().write("{\"error\":\"Invalid file type\"}");
            return;
        }

        fileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
        String uploadDir = getServletContext().getRealPath("") + File.separator + "images";
        new File(uploadDir).mkdirs();

        try (InputStream is = filePart.getInputStream()) {
            Files.copy(is, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"path\":\"images/" + fileName + "\"}");
    }

    private String getExtension(String name) {
        int dot = name.lastIndexOf('.');
        return dot >= 0 ? name.substring(dot + 1) : "";
    }
}
