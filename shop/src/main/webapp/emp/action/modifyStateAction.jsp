<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String state = request.getParameter("state");
	
	System.out.println("ordersNo : " + ordersNo);
	System.out.println("state : " + state);
	
	// 버튼을 클릭하면 ordersNo에 맞는 state가 변경되도록
	boolean modifyOrdersState = OrdersDAO.modifyOrdersState(ordersNo, state);
	
	if(modifyOrdersState){
		System.out.println("배송 현황이 성공적으로 변경되었습니다.");
		response.sendRedirect("/shop/emp/ordersStateList.jsp");
	}
%>