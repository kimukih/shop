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
%>

<%
	// 로그인 실패시 에러메시지 출력
	String msg = request.getParameter("msg");

	// 요청값 분석
	String mail = request.getParameter("mail");
	String mailCheck = request.getParameter("mailCheck");
	String errMsg = request.getParameter("errMsg");
	String sucMsg = request.getParameter("sucMsg");
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("msg : " + msg);
	System.out.println("mailCheck : " + mailCheck);
	System.out.println("errMsg : " + errMsg);
	System.out.println("sucMsg : " + sucMsg);
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
				<table class="table table-hover" border=1>
				<form method="post" action="/shop/customer/action/checkIdAction.jsp">
					<tr>
						<td style="width: 150px">이메일 : </td>
						<%
						if(errMsg != null){
						%>
						<td style="width: 450px">
							<input type="email" name="mailCheck" required="required" style="width: 350px;" placeholder="이메일을 입력해주세요." value="<%=mailCheck%>">
							<br>
							<%=errMsg%>
						</td>
						<%
						}else if(sucMsg != null){
						%>
						<td>
							<input type="email" name="mailCheck" required="required" style="width: 350px;" placeholder="이메일을 입력해주세요." value="<%=mailCheck%>">
							<br>
							<%=sucMsg%>
						</td>
						<%
						}else{
						%>
						<td>
							<input type="email" name="mailCheck" required="required" style="width: 350px;" placeholder="이메일을 입력해주세요.">
						</td>
						<%
						}
						%>
						<td style="width: 120px">
							<button class="btn btn-outline-dark" type="submit">중복체크</button>
						</td>
					</tr>
				</form>
					
				<form method="post" action="/shop/customer/action/addCustomerAction.jsp">
					<tr>
						<%
						if(sucMsg != null){
						%>
							<input type="hidden" name="mail" required="required" value="<%=mailCheck%>">
						<%
						}
						%>
						<td>비밀번호 : </td>
						<td><input type="password" name="pw" style="width: 350px;" required="required" placeholder="비밀번호를 입력해주세요."></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>이름 : </td>
						<td><input type="text" name="name" style="width: 350px;" required="required" placeholder="이름을 입력해주세요."></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>생년월일 : </td>
						<td><input type="date" name="birth" style="width: 350px;" required="required"></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>성별 : </td>
						<td>
							<input type="radio" name="gender" value="남"> 남&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="gender" value="여"> 여
						</td>
						<td>&nbsp;</td>
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