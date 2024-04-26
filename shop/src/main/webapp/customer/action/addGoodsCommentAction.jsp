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
	int score = Integer.parseInt(request.getParameter("score"));
	String comment = request.getParameter("comment");
	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	
	System.out.println("ordersNo : " + ordersNo);
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("score : " + score);
	System.out.println("comment : " + comment);
	System.out.println("mail : " + mail);
	System.out.println("name : " + name);
	
	// 상품 리뷰 내용 DB Table에 추가하기
	boolean addGoodsComment = CommentDAO.addGoodsComment(ordersNo, goodsNo, mail, name, score, comment);
	
	if(addGoodsComment){
		System.out.println("성공적으로 리뷰를 작성하였습니다.");
		response.sendRedirect("/shop/customer/form/goodsOne.jsp?goodsNo=" + goodsNo + "&currentPage=1");
	}
%>