<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // This file is deprecated. Redirect to the proper admin dashboard.
    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
%>
