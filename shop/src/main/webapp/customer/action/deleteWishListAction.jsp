<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.WishListDAO"%>
<%
	// 로그인 인증 분기
	// loginCustomer == null <--- 세션이 존재하지 않는다 == 로그인 기록이 없다
	if(session.getAttribute("loginCustomer") == null){
		
	// 로그인 기록이 없으므로 로그인 화면으로 재요청
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("goodsNo : " + goodsNo);
	
	// 삭제하기 버튼을 누르면 장바구니 목록에서 상품 삭제
	boolean deleteWishList = WishListDAO.deleteWishList(mail, goodsNo);
	
	if(deleteWishList){	// 장바구니 상품 삭제 성공
		System.out.println("장바구니에서 상품을 성공적으로 삭제하였습니다.");
		response.sendRedirect("/shop/customer/form/wishList.jsp?mail=" + mail + "&goodsNo=" + goodsNo);
	}else{				// 장바구니 상품 삭제 실패
		System.out.println("장바구니 상품 삭제에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/wishList.jsp?mail=" + mail + "&goodsNo=" + goodsNo);
	}
	
	// DAO 디버깅 코드
	System.out.println("deleteWishList : " + WishListDAO.deleteWishList(mail, goodsNo));
%>