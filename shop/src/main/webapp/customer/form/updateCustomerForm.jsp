<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
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
	System.out.println("mail : " + mail);
	
	String msg = request.getParameter("msg");
	System.out.println("msg : " + msg);

	// mail에 해당하는 customer의 상세 정보 가져오기
	ResultSet updateCustomerRs = CustomerDAO.getUpdateCustomerInfo(mail);
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String updateCustomerSql = "SELECT mail, name, birth, gender FROM customer WHERE mail = ?";
	PreparedStatement updateCustomerStmt = null;
	ResultSet updateCustomerRs = null;
	
	updateCustomerStmt = conn.prepareStatement(updateCustomerSql);
	updateCustomerStmt.setString(1, mail);
	System.out.println("updateCustomerStmt : " + updateCustomerStmt);
	
	updateCustomerRs = updateCustomerStmt.executeQuery();
	*/
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
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
				<h1>회원 정보 수정</h1>
				<br>
				<form method="post" action="/shop/customer/action/updateCustomerAction.jsp">
					<table class="table table-hover" border=1>
					<%
						while(updateCustomerRs.next()){
					%>
						<tr>
							<td>이메일 : </td>
							<td><input type="email" name="mail" value="<%=updateCustomerRs.getString("mail")%>" style="width: 350px;" readonly="readonly"></td>
						</tr>
						<tr>
							<td>이름 : </td>
							<td><input type="text" name="name" style="width: 350px;" required="required" placeholder="이름을 입력해주세요." value="<%=updateCustomerRs.getString("name")%>"></td>
						</tr>
						<tr>
							<td>생년월일 : </td>
							<td><input type="date" name="birth" required="required" value="<%=updateCustomerRs.getString("birth")%>"></td>
						</tr>
						<tr>
							<td>성별 : </td>
							<td>
							<%
								if(updateCustomerRs.getString("mail").equals("남")){
							%>
									<input type="radio" name="gender" value="남" checked="checked"> 남&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="gender" value="여"> 여
							<%
								}else{
							%>
									<input type="radio" name="gender" value="남"> 남&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="gender" value="여" checked="checked"> 여
							<%
								}
							%>
							</td>
						</tr>
						<tr>
							<td>비밀번호 : </td>
							<td>
								<input type="password" name="pw" style="width: 350px;" required="required" placeholder="비밀번호를 입력해주세요.">
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
					<%
						}
					%>
					</table>
					<br>
					<button class="btn btn-outline-dark" type="submit">수정하기</button>
				</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>