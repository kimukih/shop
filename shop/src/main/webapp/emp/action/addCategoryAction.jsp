<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CategoryDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String category = request.getParameter("category");

	// 파라미터 디버깅 코드
	System.out.println("category : " + category);
	
	// category 파라미터로 받아서 DB에 카테고리 추가하기
	boolean addCategory = CategoryDAO.addCategory(category);
	if(addCategory){
		response.sendRedirect("/shop/emp/categoryList.jsp");
		System.out.println("카테고리 추가 성공!");
	}else{
		response.sendRedirect("/shop/emp/form/addCategoryForm.jsp");
		System.out.println("카테고리 추가 실패!");
	}
	
	// DAO 디버깅 코드
	System.out.println("addCategory : " + CategoryDAO.addCategory(category));
	
	/*
	String addCategorySql = "INSERT INTO category(category) VALUES(?)";
	PreparedStatement addCategoryStmt = null;
	
	addCategoryStmt = conn.prepareStatement(addCategorySql);
	addCategoryStmt.setString(1, category);
	System.out.println("addCategoryStmt : " + addCategoryStmt);
	*/
%>