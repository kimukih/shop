<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
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
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	
	System.out.println("mail : " + mail);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("totalAmount : " + totalAmount);
	System.out.println("totalPrice : " + totalPrice);

	// 주문결제한 내용을 orders Table에 추가
	boolean createOrders = OrdersDAO.createOrders(mail, goodsNo, totalAmount, totalPrice);
	if(createOrders){
		System.out.println("상품 결제 정보가 추가되었습니다.");
		response.sendRedirect("/shop/customer/form/ordersGoodsResult.jsp");
	}else{
		System.out.println("상품 결제 정보 추가에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/ordersGoodsForm.jsp?mail=" + mail +"&goodsNo=" + goodsNo);
	}
	
	// 주문완료된 상품의 재고를 주문한 수량만 큼 빼기
%>