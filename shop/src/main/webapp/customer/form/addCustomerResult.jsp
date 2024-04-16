<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
<%
	// 요청값 분석
	String name = request.getParameter("name");
	System.out.println("name : " + name);
	
	// 회원가입한 정보 중 name을 DB에서 가져오기
	ResultSet cusNameRs = CustomerDAO.getCusName(name);
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String cusNameSql = "SELECT name FROM customer WHERE name = ?";
	PreparedStatement cusNameStmt = null;
	ResultSet cusNameRs = null;
	
	cusNameStmt = conn.prepareStatement(cusNameSql);
	cusNameStmt.setString(1, name);
	System.out.println("cusNameStmt : " + cusNameStmt);
	
	cusNameRs = cusNameStmt.executeQuery();
	*/
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
				<h1>Welcome to W.B.Shoppin</h1>
				<br>
				<img src="/shop/img/logo.png" width="500px" height="500px;">
				<br>
				<%
				if(cusNameRs.next()){
				%>
				<h3><%=cusNameRs.getString("name")%>님 W.B.Shoppin의 회원이 되신것을 환영합니다.</h3>
				<%
				}
				%>
				<br>
				<h5>다양한 카테고리의 상품들을 구경하고 구매해 보세요!</h5>
				<br>
				<a class="btn btn-outline-dark" href="/shop/customer/form/loginForm.jsp">로그인하기</a>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
	
	
</body>
</html>