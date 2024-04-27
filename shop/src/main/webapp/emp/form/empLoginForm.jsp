<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}

	// 로그인 실패시 에러메시지 출력
	String msg = request.getParameter("msg");
	
	// 파라미터 디버깅 코드
	System.out.println("msg : " + msg);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 로그인 페이지</title>
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
		
		div.main>form{
			background-color: white;
			vertical-align: middle;
		}
		
		div.login{
			border: 1px solid gray;
		}
		
		.form{
			margin-top: 30%;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<form class="form" method="post" action="/shop/emp/action/empLoginAction.jsp">
				<h1>W. B. Shoppin</h1>
				(관리자 로그인)
				<br><br>
				<table class="table" border=1>
					<tr>
						<td><label for="empId">아이디</label></td>
						<td><input class="border" type="text" name="empId" placeholder="아이디를 입력해주세요." size="30px"></td>
					</tr>
					<tr>
						<td><label for="empPw">비밀번호</label></td>
						<td><input class="border" type="password" name="empPw" placeholder="비밀번호를 입력해주세요." size="30px"></td>
					</tr>
				</table>
				<br>
					<button type="submit" class="btn btn-outline-dark">로그인</button>
					<a class="btn btn-outline-dark" href="">회원가입</a>
				</form>
				<br>
				<%
				if(msg != null){
				%>
					<%=msg%>
				<%
				}
				%>
				<br><br>
				<span style="font-size: 13px; color: gray;">Copyright © 2024 WBShopin Co.,Ltd. All Rights Reserved.</span>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>