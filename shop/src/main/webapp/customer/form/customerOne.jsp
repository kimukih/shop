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
	
	// mail에 해당하는 customer의 상세 정보 가져오기
	ArrayList<HashMap<String, Object>> customerOne = CustomerDAO.getCustomerOne(mail);
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String customerOneSql = "SELECT mail, name, birth, gender, update_date updateDate, create_date createDate FROM customer WHERE mail = ?";
	PreparedStatement customerOneStmt = null;
	ResultSet customerOneRs = null;
	
	customerOneStmt = conn.prepareStatement(customerOneSql);
	customerOneStmt.setString(1, mail);
	System.out.println("customerOneStmt : " + customerOneStmt);
	
	customerOneRs = customerOneStmt.executeQuery();
	*/
	
	// DAO 디버깅 코드
	System.out.println("CustomerDAO.getCustomerOne(mail) : " + CustomerDAO.getCustomerOne(mail));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 상세</title>
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
		<span><a class="btn btn-outline-dark" href="/shop/customer/goodsList.jsp?mail=<%=mail%>">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>회원 정보 상세</h1>
				<br>
				<table class="table table-hover" border=1>
				<%
				for(HashMap<String, Object> m : customerOne){
				%>
				<tr>
					<td>이메일</td>
					<td><%=(String)(m.get("mail"))%></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%=(String)(m.get("name"))%></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><%=(String)(m.get("birth"))%></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><%=(String)(m.get("gender"))%></td>
				</tr>
				<tr>
					<td>가입날짜</td>
					<td><%=(String)(m.get("createDate"))%></td>
				</tr>
				<tr>
					<td>수정날짜</td>
					<td><%=(String)(m.get("updateDate"))%></td>
				</tr>
				<%
				}
				%>
				</table>
				<br>
				<span style="margin-right: 220px;">
					<a class="btn btn-outline-dark" href="/shop/customer/form/updateCustomerForm.jsp?mail=<%=mail%>">정보수정</a>
					<a class="btn btn-outline-dark" href="/shop/customer/form/modifyCustomerPwForm.jsp?mail=<%=mail%>">비밀번호변경</a>
					<a class="btn btn-outline-dark" href="/shop/customer/form/ordersInfoList.jsp?mail=<%=mail%>">주문조회</a>
				</span>
				<span style="margin-left: 220px;">
					<a class="btn btn-outline-danger" href="/shop/customer/form/deleteCustomerForm.jsp?mail=<%=mail%>">회원탈퇴</a>
				</span>
			<!-- 메인 내용 시작 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>