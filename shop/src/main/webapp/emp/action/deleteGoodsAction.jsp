<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);
	
	// goodsNo에 해당하는 게시물을 DB 삭제
	boolean deleteGoods = GoodsDAO.deleteGoods(goodsNo);
	if(deleteGoods){
		response.sendRedirect("/shop/emp/goodsList.jsp");
		System.out.println("상품 삭제 성공!");
	}else{
		response.sendRedirect("/shop/emp/form/goodsOne.jsp?goodsNo=" + goodsNo);
		System.out.println("상품 삭제 실패");
	}
	
	// DAO 디버깅 코드
	System.out.println("deleteGoods : " + GoodsDAO.deleteGoods(goodsNo));
%>