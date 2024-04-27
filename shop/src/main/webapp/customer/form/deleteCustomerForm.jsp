<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	String msg = request.getParameter("msg");
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("msg : " + msg);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
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
		}
		
		.table{
			text-align: center;
		}
		
		a{
			text-decoration: none;
		}
		
		a:hover{
			color: gray;
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
		
		div.header{
			padding-top: 20px;
			margin-bottom: 50px;
		}
		
		.table td{
			height: 70px;
			vertical-align: middle;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="header">
		<span><a class="btn btn-outline-dark" href="/shop/customer/action/logout.jsp">로그아웃</a></span>
		<span><a class="btn btn-outline-dark" href="/shop/customer/form/customerOne.jsp?mail=<%=mail%>">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>회원 탈퇴</h1>
				<br>
				<h5>회원 탈퇴 진행을 위해 비밀번호를 입력해주세요.</h5>
				<br>
				<form method="post" action="/shop/customer/action/deleteCustomerAction.jsp">
					<table class="table table-hover" border=1>
						<tr>
							<td>이메일 : </td>
							<td><input type="text" name="mail" value="<%=mail%>" readonly="readonly"></td>
						</tr>
						<tr>
							<td>비밀번호 : </td>
							<td>
								<input type="password" name="pw">
								<br>
							<%
								if(msg != null){
							%>
								<%=msg%>
							<%
								}
							%>
							</td>
						</tr>
					</table>
					<button class="btn btn-outline-dark" type="submit">회원탈퇴</button>
				</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>