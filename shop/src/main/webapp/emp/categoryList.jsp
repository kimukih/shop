<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CategoryDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	ArrayList<HashMap<String, String>> list = CategoryDAO.getCategoryList();

	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String categoryListSql = "SELECT category, create_date createDate FROM category";
	PreparedStatement categoryListStmt = null;
	ResultSet categoryListRs = null;
	
	categoryListStmt = conn.prepareStatement(categoryListSql);
	categoryListRs = categoryListStmt.executeQuery();
	
	ArrayList<HashMap<String, String>> list = new ArrayList<>();
	while(categoryListRs.next()){
		HashMap<String, String> m = new HashMap<>();
		m.put("category", categoryListRs.getString("category"));
		m.put("createDate", categoryListRs.getString("createDate"));
		
		list.add(m);
	}
	*/
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 리스트</title>
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
	</style>
</head>
<body>
	<div class="container">
		<div class="header">
		<!-- empMenu.jsp include : 서버 기준으로 페이지 요청 vs redirect(클라이언트 기준) -->
		<!-- 주체가 서버이기 때문에 include할 때에는 절대주소가 /shop/... 으로 시작하지 않는다 -->
		<!-- 메인 메뉴 -->
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		<span><a class="btn btn-outline-dark" href="/shop/emp/action/empLogout.jsp">로그아웃</a></span>
		<span><a class="btn btn-outline-dark" href="/shop/emp/goodsList.jsp">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>카테고리 리스트</h1>
				<br>
				<table class="table table-hover" border=1>
					<tr>
						<td>카테고리</td>
						<td>추가날짜</td>
						<td>&nbsp;</td>
					</tr>
				<%
				for(HashMap<String, String> m : list){
				%>
					<tr>
						<td><%=m.get("category")%></td>
						<td><%=m.get("createDate")%></td>
						<td><a class="btn btn-outline-danger" href="/shop/emp/action/deleteCategoryAction.jsp?category=<%=m.get("category")%>">삭제</a></td>						
					</tr>
				<%
				}
				%>
				</table>
				<br>
				<span><a class="btn btn-outline-dark" href="/shop/emp/form/addCategoryForm.jsp">카테고리 추가</a></span>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>