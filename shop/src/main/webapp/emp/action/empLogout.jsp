<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	session.invalidate();
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
%>
