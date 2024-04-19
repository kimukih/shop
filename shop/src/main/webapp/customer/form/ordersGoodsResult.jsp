<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 주문 완료</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap')
	</style>
	<style>
		.container{
			text-align: center;
			font-family: "Noto Sans KR", sans-serif;
  			font-optical-sizing: auto;
  			font-weight: <weight>;
  			font-style: normal;
		}
		
		.table{
			text-align: center;
			width: 500px;
			margin-left: 180px;
		}
		
		td{
			width: 300px;
		}
		
		.btn{
			width: 250px;
		}
		
		
		input.border{
			border-width: 0 0 0 1px;
		}
		
		input:focus{
			outline: none;
		}
		
		
		div.login{
			border: 1px solid gray;
		}
		
		.form{
			margin-top: 30%;
		}
		
		h1{
			padding-top: 50px;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>Thank For Your Purchase</h1>
				<br>
				<img src="/shop/img/logo.png" width="500px" height="500px;">
				<br>
				<h3>상품 주문이 성공적으로 완료되었습니다.</h3>
				<br>
				<h5>주문하신 상품 이외의 다양한 카테고리의 상품들도 구경해 보세요!</h5>
				<br>
				<a class="btn btn-outline-dark" href="/shop/customer/goodsList.jsp">메인페이지</a>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>