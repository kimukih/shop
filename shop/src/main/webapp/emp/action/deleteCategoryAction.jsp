<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	System.out.println("category : " + category);
	
	// DB에서 카테고리 명에 해당하는 카테고리 삭제시키는 쿼리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String deleteCategorySql = "DELETE FROM category WHERE category = ?";
	PreparedStatement deleteCategoryStmt = null;
	
	deleteCategoryStmt = conn.prepareStatement(deleteCategorySql);
	deleteCategoryStmt.setString(1, category);
	System.out.println("deleteCategoryStmt : " + deleteCategoryStmt);
	
	int deleteCategoryRow = deleteCategoryStmt.executeUpdate();
	if(deleteCategoryRow == 1){
		System.out.println("카테고리 삭제 성공!");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		System.out.println("카테고리 삭제 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
%>