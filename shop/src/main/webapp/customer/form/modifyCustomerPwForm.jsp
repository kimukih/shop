<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	//요청값 분석
	String mail = request.getParameter("mail");
	String msg = request.getParameter("msg");
	String msg2 = request.getParameter("msg2");

	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("msg : " + msg);
	System.out.println("msg2 : " + msg2);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 비밀번호변경</title>
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
				<h1>회원 비밀번호변경</h1>
				<br>
				<form method="post" action="/shop/customer/action/modifyCustomerPwAction.jsp">
					<table class="table table-hover" border=1>
						<tr>
							<td>회원아이디 : </td>
							<td><input type="text" name="mail" style="width: 350px;" value="<%=mail%>" readonly="readonly"></td>
						</tr>
						<tr>
							<td>현재 비밀번호 : </td>
							<td>
								<input type="password" name="pw" style="width: 350px;" required="required" placeholder="현재 비밀번호를 입력해주세요.">
							<%
								if(msg != null){
							%>
									<br><%=msg%>
							<%
								}
							%>
							</td>
						</tr>
						<tr>
							<td>새로운 비밀번호 : </td>
							<td><input type="password" name="newPw" style="width: 350px;" required="required" placeholder="새로운 비밀번호를 입력해주세요.">
							<%
								if(msg2 != null){
							%>
									<br><%=msg2%>
							<%
								}
							%>
							</td>
						</tr>
					</table>
					<br>
					<button class="btn btn-outline-dark" type="submit">변경하기</button>
				</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>