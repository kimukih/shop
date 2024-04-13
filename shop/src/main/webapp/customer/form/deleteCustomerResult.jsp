<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<h1>회원탈퇴가 완료되었습니다.</h1>
				<br>
				<a href="/shop/customer/form/loginForm.jsp">
					<img src="/shop/img/logo.png" width="300px" height="300px">
				</a>
				<br><br>
				<h2>Thank You For Now !!</h2>
				<h2>See You Next Time</h2>
				<br>
				<a class="btn btn-outline-dark" href="/shop/customer/form/loginForm.jsp">홈으로</a>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>