<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsContent = request.getParameter("goodsContent");
	
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsContent : " + goodsContent);
	
	// 상품 상세 정보를 수정한 내용을 DB에 저장하기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String updateGoodsSql = "UPDATE goods SET goods_title = ?, goods_price = ?, goods_content = ? WHERE goods_no = ?";
	PreparedStatement updateGoodsStmt = null;
	
	updateGoodsStmt = conn.prepareStatement(updateGoodsSql);
	updateGoodsStmt.setString(1, goodsTitle);
	updateGoodsStmt.setString(2, goodsPrice);
	updateGoodsStmt.setString(3, goodsContent);
	updateGoodsStmt.setInt(4, goodsNo);
	System.out.println("updateGoodsStmt : " + updateGoodsStmt);
	
	int updateGoodsRow = updateGoodsStmt.executeUpdate();
	if(updateGoodsRow == 1){
		System.out.println("상품 상세 정보 수정에 성공하였습니다.");
		response.sendRedirect("/shop/emp/form/goodsBoardOne.jsp?goodsNo=" + goodsNo);
	}else{
		System.out.println("상품 상세 정보 수정에 실패하였습니다.");
		response.sendRedirect("/shop/emp/form/updateGoodsForm.jsp?goodsNo=" + goodsNo);
	}
	

%>