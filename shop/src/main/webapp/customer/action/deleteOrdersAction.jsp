<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println("mail : " + mail);
	System.out.println("ordersNo : " + ordersNo);
	System.out.println("goodsNo : " + goodsNo);
	
	// 주문 취소 시 취소한 상품의 재고수량 원복하기
	
	
	// 주문 정보 삭제 처리
	boolean deleteOrders = OrdersDAO.deleteOrders(mail, ordersNo);
	if(deleteOrders){
		System.out.println("주문이 정상적으로 취소되었습니다.");
		GoodsDAO.setGoodsAmountPlus(goodsNo);
		response.sendRedirect("/shop/customer/goodsList.jsp");
	}else{
		System.out.println("주문 취소에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/ordersInfoOne.jsp?mail=" + mail + "&ordersNo=" + ordersNo);
	}

%>