<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CommentDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
	}
%>

<%
	// 요청값 분석
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	// 파라미터 디버깅 코드
	System.out.println("ordersNo : " + ordersNo);
	System.out.println("goodsNo : " + goodsNo);
	
	// ordersNo와 동일한 코멘트를 삭제
	boolean deleteGoodsComment = CommentDAO.deleteGoodsComment(ordersNo);
	
	if(deleteGoodsComment){
		System.out.println("리뷰가 성공적으로 삭제되었습니다.");
		response.sendRedirect("/shop/customer/form/goodsOne.jsp?goodsNo=" + goodsNo + "&currentPage=1");
	}else{
		System.out.println("리뷰 삭제에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/goodsOne.jsp?goodsNo=" + goodsNo + "&currentPage=1");
	}
	
	// DAO 디버깅 코드
	System.out.println("deleteGoodsComment : " + CommentDAO.deleteGoodsComment(ordersNo));
%>