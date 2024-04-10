<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인 인증 분기
	// loginCustomer != null <--- 세션이 존재한다 == 로그인 기록이 있다
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}

	// 로그인 실패시 에러메시지 출력
	String msg = request.getParameter("msg");
	System.out.println("msg : " + msg);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
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
	
		.main{
			text-align: center;
			padding-top: 80px; 
		}
		
		.table{
			text-align: center;
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
		
		div.header{
			padding-top: 20px;
			margin-bottom: 50px;
		}
		
		input{
			border-color: #EAEAEA;
			outline: none;
		}
		
		tr{
			height: 80px;
			vertical-align: middle;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
			<h1>
				<a style="color: #000000;" href="/shop/customer/form/loginForm.jsp">
					W. B. Shoppin
				</a>
			</h1>
			<br>
			<h3>회원가입</h3>
			<br>
			<form method="post" action="/shop/customer/action/addCustomerAction.jsp">
				<table class="table table-hover" border=1>
					<tr>
						<td>이메일 : </td>
						<td><input type="email" name="mail" style="width: 400px;" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호 : </td>
						<td><input type="password" name="pw" style="width: 400px;" required="required"></td>
					</tr>
					<tr>
						<td>이름 : </td>
						<td><input type="text" name="name" style="width: 400px;" required="required"></td>
					</tr>
					<tr>
						<td>생년월일 : </td>
						<td><input type="date" name="birth" required="required"></td>
					</tr>
					<tr>
						<td>성별 : </td>
						<td>
							<input type="radio" name="gender" value="남"> 남&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="gender" value="여"> 여
						</td>
					</tr>
				</table>
				<br>
				<button class="btn btn-outline-dark" type="submit">가입하기</button>
			</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>