<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
<%@ page import="shop.dao.GoodsDAO"%>
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
	String addressName = request.getParameter("addressName");
	String address = request.getParameter("address");
	String phoneNumber = request.getParameter("phoneNumber");
	
	System.out.println("mail : " + mail);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("totalAmount : " + totalAmount);
	System.out.println("totalPrice : " + totalPrice);
	System.out.println("addressName : " + addressName);
	System.out.println("address : " + address);
	System.out.println("phoneNumber : " + phoneNumber);

	// 주문결제한 내용을 orders Table에 추가
	boolean createOrders = OrdersDAO.createOrders(mail, goodsNo, goodsTitle, totalAmount, totalPrice, addressName, address, phoneNumber);
	
	if(createOrders){
		System.out.println("상품 결제 정보가 추가되었습니다.");
		GoodsDAO.setGoodsAmountMinus(goodsNo);
		response.sendRedirect("/shop/customer/form/ordersGoodsResult.jsp");
	}else{
		System.out.println("상품 결제 정보 추가에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/ordersGoodsForm.jsp?mail=" + mail +"&goodsNo=" + goodsNo);
	}
%>