<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서 -->
<%
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<%
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
	System.out.println("category : " + category);
	System.out.println("empId : " + empId);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);
	System.out.println("goodsContent : " + goodsContent);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String addGoodsSql = "INSERT INTO goods(category, emp_id, goods_title, goods_content, goods_price, goods_amount) VALUES(?, ?, ?, ?, ?, ?)";
	
	PreparedStatement addGoodsStmt = null;
	addGoodsStmt = conn.prepareStatement(addGoodsSql);
	addGoodsStmt.setString(1, category);
	addGoodsStmt.setString(2, empId);
	addGoodsStmt.setString(3, goodsTitle);
	addGoodsStmt.setString(4, goodsContent);
	addGoodsStmt.setInt(5, goodsPrice);
	addGoodsStmt.setInt(6, goodsAmount);
	
	System.out.println("addGoodsStmt : " + addGoodsStmt);
	
	int addGoodsRow = addGoodsStmt.executeUpdate();
%>
	<!-- Controller Layer -->
<%
	if(addGoodsRow == 1){
		System.out.println("상품 추가 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}else{
		System.out.println("상품 추가 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
	// response.sendRedirect("/shop/emp/goodsList.jsp")
%>