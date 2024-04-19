<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%@ page import="shop.dao.CategoryDAO"%>
<%@ page import="shop.dao.CustomerDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	//요청값 분석
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);
	
	String mail = request.getParameter("mail");
	System.out.println("mail : " + mail);
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<!-- Model Layer -->
<%
	// 구매자 정보 가져오기
	ArrayList<HashMap<String, Object>> customerInfo = CustomerDAO.getCustomerInfo(mail);

	// 구매 상품 정보 가져오기
	ArrayList<HashMap<String, Object>> goodsOne = GoodsDAO.getGoodsOne(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품주문</title>
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
		
		input.border{
			border-width: 0 0 0 1px;
		}
		
		input:focus{
			outline: none;
		}
		
		a{
			text-decoration: none;
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
		
		h4{
			text-align: left;
		}
		
		input[type=text]{
			width: 400px;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="header"></div>
		<h1 style="margin-bottom: 30px">W. B. Shoppin</h1>
		<div class="main row">
			<!-- 메인 내용 시작 -->
			<h2 style="text-align: left; margin-bottom: 30px;">주문/결제</h2>
			<hr><br><br>
			<form method="post" action="/shop/customer/action/ordersGoodsAction.jsp?goodsNo=<%=goodsNo%>">
				<h4>구매자정보</h4>
				<table class="table">
				<%
				for(HashMap<String, Object> m : customerInfo){
				%>
					<tr>
						<td class="menu">이름</td>
						<td class="content"><input class="border" type="text" name="name" value="<%=(String)(m.get("name"))%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="menu">이메일</td>
						<td class="content"><input class="border" type="text" name="mail" value="<%=(String)(m.get("mail"))%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="menu">생년월일</td>
						<td class="content"><input class="border" type="text" name="birth" value="<%=(String)(m.get("birth"))%>" readonly="readonly"></td>
					</tr>
				<%
				}
				%>
				</table>
				<br>
				<br>
				
				<h4>받는사람정보</h4>
				<table class="table">
					<tr>
						<td class="menu">이름</td>
						<td class="content"><input class="border" type="text" name="addressName"></td>
					</tr>
					<tr>
						<td class="menu">주소</td>
						<td class="content"><input class="border" type="text" name="address"></td>
					</tr>
					<tr>
						<td class="menu">연락처</td>
						<td class="content"><input class="border" type="text" name="phoneNumber"></td>
					</tr>
					<tr>
						<td class="menu">요청사항</td>
						<td class="content"><input class="border" type="text" name="requestComment"></td>
					</tr>
				</table>
				<br>
				<br>
				
				<h4>결제정보</h4>
				<table class="table">
				<%
				for(HashMap<String, Object> m : goodsOne){
				%>
					<tr>
						<td class="menu">상품명</td>
						<td class="content"><%=(String)(m.get("goodsTitle"))%></td>
					</tr>
					<tr>
						<td class="menu">총구매수량</td>
						<td class="content"><input class="border" type="text" name="totalAmount" value="1" readonly="readonly">개</td>
					</tr>
					<tr>
						<td class="menu">총상품가격</td>
						<td class="content"><input class="border" type="text" name="totalPrice" value="<%=(Integer)(m.get("goodsPrice"))%>" readonly="readonly">원</td>
					</tr>
					<tr>
						<td class="menu">배송비</td>
						<td class="content">2500원</td>
					</tr>
					<tr>
						<td class="menu">총결제금액</td>
						<td class="content"><input class="border" type="text" name="addressName" value="<%=(Integer)(m.get("goodsPrice")) + 2500%>" readonly="readonly">원</td>
					</tr>
					<tr>
						<td class="menu">결제수단</td>
						<td class="content">
							<input type="radio" name="payCheck"> 계좌이체&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payCheck"> 신용/체크카드&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payCheck"> 법인카드&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payCheck"> 휴대폰&nbsp;&nbsp;&nbsp;
							<input type="radio" name="payCheck"> 무통장입금(가상계좌)
						</td>
					</tr>
				<%
				}
				%>
				</table>
				<br>
				<button class="btn btn-outline-dark" style="margin-bottom: 30px">결제하기</button>
			</form>
			<!-- 메인 내용 끝 -->
		</div>
	</div>		
</body>
</html>