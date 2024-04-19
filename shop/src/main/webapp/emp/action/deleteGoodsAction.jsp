<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%
	// 요청값 분석
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);
	
	// goodsNo에 해당하는 게시물을 DB 삭제
	int deleteGoodsRow = GoodsDAO.deleteGoods(goodsNo);
	if(deleteGoodsRow == 1){
		response.sendRedirect("/shop/emp/goodsList.jsp");
		System.out.println("상품 삭제 성공!");
	}else{
		response.sendRedirect("/shop/emp/form/goodsOne.jsp?goodsNo=" + goodsNo);
		System.out.println("상품 삭제 실패");
	}
	
	// DAO 디버깅 코드
	System.out.println("GoodsDAO.deleteGoods(goodsNo) : " + GoodsDAO.deleteGoods(goodsNo));
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String deleteGoodsSql = "DELETE FROM goods WHERE goods_no = ?";
	PreparedStatement deleteGoodsStmt = null;
	deleteGoodsStmt = conn.prepareStatement(deleteGoodsSql);
	deleteGoodsStmt.setInt(1, goodsNo);
	System.out.println("deleteGoodsStmt : " + deleteGoodsStmt);
	
	int deleteGoodsRow = deleteGoodsStmt.executeUpdate();
	*/

%>