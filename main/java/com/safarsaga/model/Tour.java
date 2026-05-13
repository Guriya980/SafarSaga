package com.safarsaga.model;

import java.sql.Timestamp;

public class Tour {
    private int tourId;
    private String tourName;
    private String tourType; // DOMESTIC or INTERNATIONAL
    private String category;
    private String state;
    private String country;
    private String destinationCity;
    private int durationDays;
    private int durationNights;
    private String description;
    private String detailedItinerary;
    private String highlights;
    private String inclusions;
    private String exclusions;
    private String bestSeason;
    private String difficultyLevel;
    private String imageUrl;
    private String galleryImages;
    private boolean isFeatured;
    private boolean isTrending;
    private boolean isActive;
    private int viewsCount;
    private int inquiryCount;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Tour() {}

    public int getTourId() { return tourId; }
    public void setTourId(int tourId) { this.tourId = tourId; }
    
    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    
    public String getTourType() { return tourType; }
    public void setTourType(String tourType) { this.tourType = tourType; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    
    public String getDestinationCity() { return destinationCity; }
    public void setDestinationCity(String destinationCity) { this.destinationCity = destinationCity; }
    
    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }
    
    public int getDurationNights() { return durationNights; }
    public void setDurationNights(int durationNights) { this.durationNights = durationNights; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getDetailedItinerary() { return detailedItinerary; }
    public void setDetailedItinerary(String detailedItinerary) { this.detailedItinerary = detailedItinerary; }
    
    public String getHighlights() { return highlights; }
    public void setHighlights(String highlights) { this.highlights = highlights; }
    
    public String getInclusions() { return inclusions; }
    public void setInclusions(String inclusions) { this.inclusions = inclusions; }
    
    public String getExclusions() { return exclusions; }
    public void setExclusions(String exclusions) { this.exclusions = exclusions; }
    
    public String getBestSeason() { return bestSeason; }
    public void setBestSeason(String bestSeason) { this.bestSeason = bestSeason; }
    
    public String getDifficultyLevel() { return difficultyLevel; }
    public void setDifficultyLevel(String difficultyLevel) { this.difficultyLevel = difficultyLevel; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public String getGalleryImages() { return galleryImages; }
    public void setGalleryImages(String galleryImages) { this.galleryImages = galleryImages; }
    
    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }
    
    public boolean isTrending() { return isTrending; }
    public void setTrending(boolean trending) { isTrending = trending; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public int getViewsCount() { return viewsCount; }
    public void setViewsCount(int viewsCount) { this.viewsCount = viewsCount; }
    
    public int getInquiryCount() { return inquiryCount; }
    public void setInquiryCount(int inquiryCount) { this.inquiryCount = inquiryCount; }
    
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
