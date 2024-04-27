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
	String msg = request.getParameter("msg");
	
	// 파라미터 디버깅 코드
	System.out.println("empId : " + empId);
	System.out.println("msg : " + msg);
	
	// 정보 수정하기 전 기존 관리자 정보 출력
	ArrayList<HashMap<String, Object>> empOne = EmpDAO.getEmpListOne(empId);
	
	// DAO 디버깅 코드
	System.out.println("empOne : " + EmpDAO.getEmpListOne(empId));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 정보 수정</title>
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
		<span><a class="btn btn-outline-dark" href="/shop/emp/form/empOne.jsp">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>관리자 정보 수정</h1>
				<br>
				<form method="post" action="/shop/emp/action/updateEmpOneAction.jsp">
					<table class="table table-hover" border=1>
					<%
						for(HashMap<String, Object> m : empOne){
					%>
						<tr>
							<td>관리자ID : </td>
							<td><input type="text" name="empId" value="<%=(String)(m.get("empId"))%>" style="width: 350px;" readonly="readonly"></td>
						</tr>
						<tr>
							<td>이름 : </td>
							<td><input type="text" name="empName" style="width: 350px;" required="required" placeholder="이름을 입력해주세요." value="<%=(String)(m.get("empName"))%>"></td>
						</tr>
						<tr>
							<td>직책 : </td>
							<td><input type="text" name="empJob" required="required" value="<%=(String)(m.get("empJob"))%>"></td>
						</tr>
						<tr>
							<td>권한등급 : </td>
							<td><input type="number" name="grade" value="<%=(Integer)(m.get("grade"))%>"></td>
						</tr>
						<tr>
							<td>비밀번호 : </td>
							<td>
								<input type="password" name="empPw" style="width: 350px;" required="required" placeholder="비밀번호를 입력해주세요.">
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