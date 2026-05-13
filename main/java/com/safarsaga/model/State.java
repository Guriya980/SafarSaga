package com.safarsaga.model;

public class State {
    private int stateId;
    private String stateName;
    private String stateCode;
    private String description;
    private String imageUrl;
    private boolean isPopular;
    private int tourCount;
    private int displayOrder;

    public State() {}

    public int getStateId() { return stateId; }
    public void setStateId(int stateId) { this.stateId = stateId; }
    
    public String getStateName() { return stateName; }
    public void setStateName(String stateName) { this.stateName = stateName; }
    
    public String getStateCode() { return stateCode; }
    public void setStateCode(String stateCode) { this.stateCode = stateCode; }
    
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
