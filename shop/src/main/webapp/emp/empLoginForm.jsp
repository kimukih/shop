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
	System.out.println("msg : " + msg);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		.container{
			text-align: center;
		}
		
		.table{
			text-align: center;
			width: 500px;
			margin-left: 170px;
		}
		
		td{
			width: 300px;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
			<!-- 메인 내용 시작 -->
				<form method="post" action="/shop/emp/empLoginAction.jsp">
				<h1>로그인</h1>
				<table class="table table-hover table-striped">
					<tr>
						<td>아이디 : </td>
						<td><input type="text" name="empId" placeholder="아이디를 입력해주세요." size="30px"></td>
					</tr>
					<tr>
						<td>비밀번호 : </td>
						<td><input type="password" name="empPw" placeholder="비밀번호를 입력해주세요." size="30px"></td>
					</tr>
				</table>
					<button type="submit" class="btn btn-dark">로그인</button>
					<a class="btn btn-dark" href="">회원가입</a>
				</form>
				<br>
				<%
				if(msg != null){
				%>
					<%=msg%>
				<%
				}
				%>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>