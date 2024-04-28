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
	
	// DB에서 카테고리 명에 해당하는 카테고리 삭제시키는 쿼리
	boolean deleteCategory = CategoryDAO.deleteCategory(category);
	if(deleteCategory){
		System.out.println("카테고리 삭제 성공!");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		System.out.println("카테고리 삭제 실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
	// DAO 디버깅 코드
	System.out.println("deleteCategory : " + CategoryDAO.deleteCategory(category));
%>