package com.safarsaga.model;

public class Country {
    private int countryId;
    private String countryName;
    private String countryCode;
    private String continent;
    private String description;
    private String imageUrl;
    private boolean isPopular;
    private int tourCount;
    private int displayOrder;

    public Country() {}

    public int getCountryId() { return countryId; }
    public void setCountryId(int countryId) { this.countryId = countryId; }
    
    public String getCountryName() { return countryName; }
    public void setCountryName(String countryName) { this.countryName = countryName; }
    
    public String getCountryCode() { return countryCode; }
    public void setCountryCode(String countryCode) { this.countryCode = countryCode; }
    
    public String getContinent() { return continent; }
    public void setContinent(String continent) { this.continent = continent; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public boolean isPopular() { return isPopular; }
    public void setPopular(boolean popular) { isPopular = popular; }
    
    public int getTourCount() { return tourCount; }
    public void setTourCount(int tourCount) { this.tourCount = tourCount; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
}
