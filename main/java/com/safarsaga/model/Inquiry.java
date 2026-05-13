package com.safarsaga.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Inquiry {
    private int inquiryId;
    private String fullName;
    private String email;
    private String phone;
    private String countryCode;
    private String subject;
    private String message;
    private String inquiryType;
    private Integer tourId;
    private Date preferredTravelDate;
    private Integer numberOfTravelers;
    private String status;
    private String adminNotes;
    private Integer repliedBy;
    private Timestamp repliedAt;
    private String ipAddress;
    private String userAgent;
    private Timestamp createdAt;

    public Inquiry() {}

    public int getInquiryId() { return inquiryId; }
    public void setInquiryId(int inquiryId) { this.inquiryId = inquiryId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getCountryCode() { return countryCode; }
    public void setCountryCode(String countryCode) { this.countryCode = countryCode; }
    
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getInquiryType() { return inquiryType; }
    public void setInquiryType(String inquiryType) { this.inquiryType = inquiryType; }
    
    public Integer getTourId() { return tourId; }
    public void setTourId(Integer tourId) { this.tourId = tourId; }
    
    public Date getPreferredTravelDate() { return preferredTravelDate; }
    public void setPreferredTravelDate(Date preferredTravelDate) { this.preferredTravelDate = preferredTravelDate; }
    
    public Integer getNumberOfTravelers() { return numberOfTravelers; }
    public void setNumberOfTravelers(Integer numberOfTravelers) { this.numberOfTravelers = numberOfTravelers; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getAdminNotes() { return adminNotes; }
    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }
    
    public Integer getRepliedBy() { return repliedBy; }
    public void setRepliedBy(Integer repliedBy) { this.repliedBy = repliedBy; }
    
    public Timestamp getRepliedAt() { return repliedAt; }
    public void setRepliedAt(Timestamp repliedAt) { this.repliedAt = repliedAt; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
