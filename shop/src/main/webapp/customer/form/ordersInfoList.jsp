<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
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
	String addressName = request.getParameter("addressName");
	String address = request.getParameter("address");
	String phoneNumber = request.getParameter("phoneNumber");
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("addressName : " + addressName);
	System.out.println("address : " + address);
	System.out.println("phoneNumber : " + phoneNumber);
	
	// 주문 정보 가져오기
	ArrayList<HashMap<String, Object>> ordersListInfo = OrdersDAO.getOrdersListInfo(mail);
	
	// DAO 디버깅 코드
	System.out.println("ordersListInfo : " + OrdersDAO.getOrdersListInfo(mail));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문조회</title>
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
		<h1 style="text-align: center; margin-bottom: 30px;">주문 상품 리스트</h1>
		<div class="main row">
			<!-- 메인 내용 시작 -->
			<h2 style="text-align: left; margin-bottom: 30px;">결제완료목록</h2>
			<hr><br><br>
			<table class="table">
				<tr>
					<td>주문번호</td>
					<td>상품번호</td>
					<td>상품명</td>
					<td>수취인</td>
					<td>연락처</td>
					<td>배송지</td>
					<td>배송상태</td>
				</tr>
				<%
				for(HashMap<String, Object> m : ordersListInfo){
				%>
				<tr>
					<td><%=(Integer)(m.get("ordersNo"))%></td>
					<td><%=(Integer)(m.get("goodsNo"))%></td>
					<td><a href="/shop/customer/form/ordersInfoOne.jsp?mail=<%=mail%>&ordersNo=<%=(Integer)(m.get("ordersNo"))%>"><%=(String)(m.get("goodsTitle"))%></a></td>
					<td><%=(String)(m.get("addressName"))%></td>
					<td><%=(String)(m.get("phoneNumber"))%></td>
					<td><%=(String)(m.get("address"))%></td>
					<td><%=(String)(m.get("state"))%></td>
				<%
				}
				%>
				</tr>
			</table>
			<!-- 메인 내용 끝 -->
		</div>
	</div>
</body>
</html>