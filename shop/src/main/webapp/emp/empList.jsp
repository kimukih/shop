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
	// 페이징 코드
	// 요청값 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 파라미터 디버깅 코드
	System.out.println("currentPage : " + currentPage);
	
	// 한 페이지당 출력할 게시물 수
	int rowPerPage = 10;
	
	// 페이지마다 시작점이 되는 게시물의 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 화면에 표시할 직원리스트 개수 DB에서 가져오기
	int empCnt = EmpDAO.getEmpCnt();
	
	// 가장 마지막 페이지
	int lastPage = empCnt / rowPerPage;
	if(empCnt % rowPerPage != 0){
		lastPage = empCnt / rowPerPage + 1;
	}
	
	// DAO 디버깅 코드
	System.out.println("empCnt : " + EmpDAO.getEmpCnt());
%>

<!-- Model Layer -->
<%
	// emp 멤버들의 정보를 DB에서 가져오기 위한 쿼리
	// 특수한 형태의 데이터(RDBMS:mariadb)
	// 특정 데이터에 맞는 API를 사용하여 자료구조(ResultSet)을 취득하고
	// 일반화된 자료구조로 변경 (ArrayList<HashMap>) --> 모델 취득
	// ex) 데이터 : RDBMS, API : JDBC
	ArrayList<HashMap<String, Object>> list = EmpDAO.getEmpList(startRow, rowPerPage);
	
	// DAO 디버깅 코드
	System.out.println("EmpDAO.getEmpCnt() : " + EmpDAO.getEmpCnt());
	System.out.println("EmpDAO.getEmpList(startRow, rowPerPage) : " + EmpDAO.getEmpList(startRow, rowPerPage));
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>직원 리스트</title>
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
		
		a.link:hover{
			color: #8C8C8C;
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
	</style>
</head>
<body>
	<div class="container">
	<div class="header">
	<!-- empMenu.jsp include : 서버 기준으로 페이지 요청 vs redirect(클라이언트 기준) -->
	<!-- 주체가 서버이기 때문에 include할 때에는 절대주소가 /shop/... 으로 시작하지 않는다 -->
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<span><a class="btn btn-outline-dark" href="/shop/emp/action/empLogout.jsp">로그아웃</a></span>
	<span><a class="btn btn-outline-dark" href="/shop/emp/empList.jsp">이전</a></span>
	</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>직원 리스트</h1>
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
					for(HashMap<String, Object> m : list){
						
					%>
					<!-- (String)m.get("empId") <-- err
						 String타입으로 형변환 할 때 m.get()값 전체에 괄호를 씌워주지 않으면 에러발생 -->
						<tr>
							<td><%=(String)(m.get("empId"))%></td>
							<td><a class="link" href="/shop/emp/form/empOne.jsp?empId=<%=(String)(m.get("empId"))%>"><%=(String)(m.get("empName"))%></a></td>
							<td><%=(String)(m.get("empJob"))%></td>
							<td><%=(String)(m.get("hireDate"))%></td>
					<%
							HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
								if((Integer)(sm.get("grade")) > 0){
					%>
								
								<td><a class="btn btn-outline-dark" href="/shop/emp/action/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>"><%=(String)(m.get("active"))%></a></td>					
					<%
							}else{
					%>
								<td><a class="btn btn-outline-dark disabled" href="/shop/emp/action/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>"><%=(String)(m.get("active"))%></a></td>
					<%
							}
					}
					%>
						</tr>
				</table>
				<br>
				<div class="page">
					<nav aria-label="Page navigation">
					  <ul class="pagination justify-content-center">
					  <%
					  	if(currentPage > 1 && currentPage < lastPage){
					  %>
					  		<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
					  <%
					  	}else if(currentPage == 1){
					  %>
					  		<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
					  		<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
					  <%
					  	}else if(currentPage == lastPage){
					  %>
					  		<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
					    	<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
					  		<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
					  <%
					  	}
					  %>
					    
					  </ul>
					</nav>
				</div>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>