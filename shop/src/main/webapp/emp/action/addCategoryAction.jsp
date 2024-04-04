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
	
	// category 파라미터로 받아서 DB에 카테고리 추가하기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String addCategorySql = "INSERT INTO category(category) VALUES(?)";
	PreparedStatement addCategoryStmt = null;
	
	addCategoryStmt = conn.prepareStatement(addCategorySql);
	addCategoryStmt.setString(1, category);
	System.out.println("addCategoryStmt : " + addCategoryStmt);
	
	int addCategoryRow = addCategoryStmt.executeUpdate();
	if(addCategoryRow == 1){
		response.sendRedirect("/shop/emp/categoryList.jsp");
		System.out.println("카테고리 추가 성공!");
	}else{
		response.sendRedirect("/shop/emp/form/addCategoryForm.jsp");
		System.out.println("카테고리 추가 실패!");
	}

%>