package com.safarsaga.model;

import java.sql.Date;
import java.sql.Timestamp;

public class VisitorAnalytics {
    private int visitId;
    private String sessionId;
    private String ipAddress;
    private String country;
    private String city;
    private String deviceType;
    private String browser;
    private String operatingSystem;
    private String referrerUrl;
    private String landingPage;
    private String pagesVisited;
    private int totalPageViews;
    private int sessionDuration;
    private Date visitDate;
    private Timestamp visitTime;
    private Timestamp lastActivity;

    public VisitorAnalytics() {}

    public int getVisitId() { return visitId; }
    public void setVisitId(int visitId) { this.visitId = visitId; }
    
    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getDeviceType() { return deviceType; }
    public void setDeviceType(String deviceType) { this.deviceType = deviceType; }
    
    public String getBrowser() { return browser; }
    public void setBrowser(String browser) { this.browser = browser; }
    
    public String getOperatingSystem() { return operatingSystem; }
    public void setOperatingSystem(String operatingSystem) { this.operatingSystem = operatingSystem; }
    
    public String getReferrerUrl() { return referrerUrl; }
    public void setReferrerUrl(String referrerUrl) { this.referrerUrl = referrerUrl; }
    
    public String getLandingPage() { return landingPage; }
    public void setLandingPage(String landingPage) { this.landingPage = landingPage; }
    
    public String getPagesVisited() { return pagesVisited; }
    public void setPagesVisited(String pagesVisited) { this.pagesVisited = pagesVisited; }
    
    public int getTotalPageViews() { return totalPageViews; }
    public void setTotalPageViews(int totalPageViews) { this.totalPageViews = totalPageViews; }
    
    public int getSessionDuration() { return sessionDuration; }
    public void setSessionDuration(int sessionDuration) { this.sessionDuration = sessionDuration; }
    
    public Date getVisitDate() { return visitDate; }
    public void setVisitDate(Date visitDate) { this.visitDate = visitDate; }
    
    public Timestamp getVisitTime() { return visitTime; }
    public void setVisitTime(Timestamp visitTime) { this.visitTime = visitTime; }
    
    public Timestamp getLastActivity() { return lastActivity; }
    public void setLastActivity(Timestamp lastActivity) { this.lastActivity = lastActivity; }
}
