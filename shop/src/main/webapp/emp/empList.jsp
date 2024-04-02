<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}
%>

<%
	// emp 멤버들의 정보를 DB에서 가져오기 위한 쿼리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String empListSql = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp ORDER BY active, hire_date DESC";
	PreparedStatement empListStmt = null;
	ResultSet empListRs = null;
	
	empListStmt = conn.prepareStatement(empListSql);
	System.out.println("empListStmt : " + empListStmt);
	
	empListRs = empListStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
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
			width: 600px;
			margin-left: 130px;
		}
		
		a{
			text-decoration: none;
		}
	</style>
</head>
<body>
	<div class="container">
	<div class="header">
	<span><a class="btn btn-dark" style="color: white" href="/shop/emp/empLogout.jsp?session=<%=session.getAttribute("loginEmp")%>">로그아웃</a></span>
	<span><a class="btn btn-dark" style="color: white" href="/shop/emp/empList.jsp">이전</a></span>
	</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>직원 목록</h1>
				<br>
				<table class="table table-hover" border=1>
					<tr>
						<td>empId</td>
						<td>empName</td>
						<td>empJob</td>
						<td>hireDate</td>
						<td>active</td>
					</tr>
					<%
					while(empListRs.next()){
					%>
						<tr>
							<td><%=empListRs.getString("empId")%></td>
							<td><%=empListRs.getString("empName")%></td>
							<td><%=empListRs.getString("empJob")%></td>
							<td><%=empListRs.getString("hireDate")%></td>
							<td><a class="btn btn-dark" href="/shop/emp/modifyEmpActive.jsp?empId=<%=empListRs.getString("empId")%>&active=<%=empListRs.getString("active")%>"><%=empListRs.getString("active")%></a></td>
						</tr>
					<%
					}
					%>
				</table>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>