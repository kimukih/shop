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
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	System.out.println("mail : " + mail);

	// 접속한 ID로 추가한 장바구니 목록 리스트
	ArrayList<HashMap<String, Object>> wishList = WishListDAO.getWishList(mail);
	System.out.println("WishListDAO.getWishList(mail) : " + WishListDAO.getWishList(mail));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap')
	</style>
	<style>
		.container{
			font-family: "Noto Sans KR", sans-serif;
  			font-optical-sizing: auto;
  			font-weight: <weight>;
  			font-style: normal;
		}
	
		div.main{
			text-align: center;
			border: 1px solid #EAEAEA;
			padding-top: 20px;
			padding-bottom: 20px;
			margin-bottom: 50px;
		}
		
		div.row{
			text-align: center;
		}
		
		.table{
			text-align: center;
			border-top: solid 2px;
		}
		
		.table td{
			height: 60px;
			vertical-align: middle;
		}
		
		.table td.menu{
			background-color: #EAEAEA;
			width: 200px;
			text-align: right;
			padding-right: 30px;
		}
		
		.table td.content{
			text-align: left;
			padding-left: 30px;
		}
		
		a{
			text-decoration: none;
			color: #000000;
		}
		
		a.page-link{
			color: #000000;
		}
		
		a.page-link:hover{
			background-color: #000000;
			color: #FFFFFF;
		}
		
		span.add{
			text-align: right;
		}
		
		div.product{
			display: inline-block;
			width: 250px;
			height: 250px;
			margin-top: 50px;
			padding-left: 65px;
		}
		
		nav{
			margin-top: 70px;
		}
		
		div.header{
			padding-top: 20px;
			margin-bottom: 50px;
		}
		
		table.head{
			width: 1300px;
			height: 120px;
		}
		
		table.head td{
			text-align: center;
		}
		
		div.grid{
			display: grid;
			grid-template-columns: 1fr 1fr;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="header"></div>
		<h1 style="text-align: center; margin-bottom: 30px;">장바구니</h1>
		<div class="main row">
			<!-- 메인 내용 시작 -->
			<h2 style="text-align: left; margin-bottom: 30px;">찜한상품목록</h2>
			<hr><br><br>
			<%
			if(wishList.size() != 0){
				for(HashMap<String, Object> m : wishList){
			%>
					<table class="table">
						<tr>
							<td style="width: 70px">No</td>
							<td style="width: 300px">상품이미지</td>
							<td style="width: 150px">카테고리</td>
							<td>상품명</td>
							<td style="width: 170px">판매가격</td>
							<td rowspan="2" style="width: 150px; border-left: solid 1px #EAEAEA;">
								<a style="margin-bottom: 5px" class="btn btn-outline-dark" href="/shop/customer/form/ordersGoodsForm.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=(Integer)(m.get("goodsNo"))%>">구매하기</a><br>
								<a style="margin-top: 5px"class="btn btn-outline-danger" href="/shop/customer/action/deleteWishListAction.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=(Integer)(m.get("goodsNo"))%>">삭제하기</a>
							</td>
						</tr>
						<tr>
							<td><%=(Integer)(m.get("wishNo"))%></td>
							<td><img src="/shop/img/<%=(String)(m.get("goodsImg"))%>" width="150px" height="150px"></td>
							<td><%=(String)(m.get("category"))%></td>
							<td><%=(String)(m.get("goodsTitle"))%></td>
							<td><%=(Integer)(m.get("goodsPrice"))%></td>
						</tr>
					</table>
			<%
				}
			}else{
			%>
					<h2 style="margin-bottom: 30px">장바구니에 담은 상품이 없습니다.</h2>
			<%
			}
			%>
			<!-- 메인 내용 끝 -->
		</div>
	</div>
</body>
</html>