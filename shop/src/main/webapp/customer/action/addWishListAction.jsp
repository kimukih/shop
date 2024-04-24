<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.WishListDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	String goodsImg = request.getParameter("goodsImg");
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println("mail : " + mail);
	System.out.println("goodsImg : " + goodsImg);
	System.out.println("category : " + category);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsNo : " + goodsNo);
	
	// 찜하기 버튼을 누르면 DB의 wishlist Table에 상품정보가 추가됨
	boolean addWishList = WishListDAO.addWishList(mail, goodsImg, category, goodsTitle, goodsPrice);
	
	if(addWishList){
		System.out.println("상품을 장바구니에 담았습니다.");
		response.sendRedirect("/shop/customer/form/goodsOne.jsp?goodsNo=" + goodsNo + "&currentPage=1");
	}else{
		System.out.println("상품을 장바구니에 담는데 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/goodsOne.jsp?goodsNo=" + goodsNo + "&currentPage=1");
	}
	
%>