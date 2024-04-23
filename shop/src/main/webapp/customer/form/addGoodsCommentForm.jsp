<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	// 세션 정보 사용
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));


	// 요청값 분석
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println("ordersNo : " + ordersNo);
	System.out.println("goodsNo : " + goodsNo);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>리뷰 작성</title>
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
			padding-top: 50px;
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
		<div class="header"></div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>Write Your Review</h1>
				<img src="/shop/img/logo.png" width="300px" height="300px">
				<br>
				<h3>구매하신 상품 및 배송 서비스가 만족스러우셨나요?</h3>
				<br>
				<h3>상품평을 작성하고 모두에게 공유해보세요!</h3>
				<br><br>
				<form method="post" action="/shop/customer/action/addGoodsCommentAction.jsp?ordersNo=<%=ordersNo%>&goodsNo=<%=goodsNo%>&mail=<%=loginMember.get("mail")%>&name=<%=loginMember.get("name")%>">
					<div>
						<h4>
						만족도 : &nbsp;&nbsp;&nbsp;
						<input type="radio" name="score" value="5"> 5점&nbsp;&nbsp;&nbsp;
						<input type="radio" name="score" value="4"> 4점&nbsp;&nbsp;&nbsp;
						<input type="radio" name="score" value="3"> 3점&nbsp;&nbsp;&nbsp;
						<input type="radio" name="score" value="2"> 2점&nbsp;&nbsp;&nbsp;
						<input type="radio" name="score" value="1"> 1점
						</h4>
					</div>
					<br>
					<div>
						<textarea rows="7" cols="60" name="comment"></textarea>
					</div>
					<br>
					<button class="btn btn-outline-dark" type="submit">등록하기</button>
				</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>