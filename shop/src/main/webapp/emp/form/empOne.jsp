<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String empId = request.getParameter("empId");

	// 파라미터 디버깅 코드
	System.out.println("empId : " + empId);
	
	// empId에 해당하는 관리자의 정보 출력
	ArrayList<HashMap<String, Object>> empListOne = EmpDAO.getEmpListOne(empId);
	
	// DAO 디버깅 코드
	System.out.println("empListOne : " + EmpDAO.getEmpListOne(empId));

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 상세</title>
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
		<span><a class="btn btn-outline-dark" href="/shop/emp/action/empLogout.jsp">로그아웃</a></span>
		<span><a class="btn btn-outline-dark" href="/shop/emp/empList.jsp">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>관리자 정보 상세</h1>
				<br>
				<table class="table table-hover" border=1>
				<%
				for(HashMap<String, Object> m : empListOne){
				%>
				<tr>
					<td>관리자ID</td>
					<td><%=(String)(m.get("empId"))%></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%=(String)(m.get("empName"))%></td>
				</tr>
				<tr>
					<td>직책</td>
					<td><%=(String)(m.get("empJob"))%></td>
				</tr>
				<tr>
					<td>권한등급</td>
					<td><%=(Integer)(m.get("grade"))%></td>
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
					<a class="btn btn-outline-dark" href="/shop/emp/form/updateEmpOneForm.jsp?empId=<%=empId%>">정보수정</a>
					<a class="btn btn-outline-dark" href="/shop/emp/form/modifyEmpPwForm.jsp?empId=<%=empId%>">비밀번호변경</a>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>