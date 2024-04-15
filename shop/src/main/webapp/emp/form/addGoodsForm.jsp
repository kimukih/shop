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

<!-- Model Layer -->
<%
	// 카테고리 테이블 내용 DB에서 가져오기
	ArrayList<String> categoryList = CategoryDAO.getAddGoodsCategoryList();

	/*
	String categoryListSql = "SELECT category FROM category";
	PreparedStatement categoryListStmt = null;
	ResultSet categoryListRs = null;
	
	categoryListStmt = conn.prepareStatement(categoryListSql);
	categoryListRs = categoryListStmt.executeQuery();
	
	ArrayList<String> categoryList = new ArrayList<String>();
	
	while(categoryListRs.next()){
		categoryList.add(categoryListRs.getString("category"));
	}
	*/
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품등록</title>
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
		
		table.category{
			text-align: left;
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
	<span><a class="btn btn-outline-dark" href="/shop/emp/goodsList.jsp">이전</a></span>
	</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
			<h1>상품등록</h1>
			<form method="post" action="/shop/emp/action/addGoodsAction.jsp" enctype="multipart/form-data">
			<table class="table category table-hover" border=1>
				<tr>
					<td>카테고리 : </td>
					<td>
						<select name="category">
							<option value="">선택</option>
							<%
								for(String c : categoryList){
							%>
									<option value="<%=c%>"><%=c%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>등록자 : </td>
					<td><input type="text" name="empId"></td>
				</tr>
				<tr>
					<td>제목 : </td>
					<td><input type="text" name="goodsTitle"></td>
				</tr>
				<tr>
					<td>가격 : </td>
					<td><input type="number" name="goodsPrice"></td>
				</tr>
				<tr>
					<td>수량 : </td>
					<td><input type="text" name="goodsAmount"></td>
				</tr>
				<tr>
					<td>내용 : </td>
					<td><textarea rows="5" cols="50" name="goodsContent"></textarea></td>
				</tr>
				<tr>
					<td>이미지 첨부 : </td>
					<td><input type="file" name="goodsImg" required="required"></td>
				</tr>
				</table>
				<div>
					<button class="btn btn-outline-dark" type="submit">등록하기</button>
				</div>
			</form>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>