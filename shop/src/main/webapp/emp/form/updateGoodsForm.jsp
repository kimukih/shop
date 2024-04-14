<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);

	// 상품 정보에 대한 데이터 DB에서 가져오기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		
	String goodsBoardOneSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, goods_content goodsContent, FORMAT(goods_price, 0) goodsPrice, emp_id empId, goods_img goodsImg FROM goods WHERE goods_no = ?";
	PreparedStatement goodsBoardOneStmt = null;
	ResultSet goodsBoardOneRs = null;
	goodsBoardOneStmt = conn.prepareStatement(goodsBoardOneSql);
	goodsBoardOneStmt.setInt(1, goodsNo);
	System.out.println("goodsBoardOneStmt : " + goodsBoardOneStmt);
		
	goodsBoardOneRs = goodsBoardOneStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 상세 수정</title>
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
		
		td.column{
			width: 100px;
			vertical-align: middle;
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
		<span><a class="btn btn-outline-dark" href="/shop/emp/form/goodsBoardOne.jsp?goodsNo=<%=goodsNo%>">이전</a></span>
		</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>상품상세 수정</h1>
				<br>
				<form method="post" action="/shop/emp/action/updateGoodsAction.jsp">
					<table class="table table-hover" border=1>
						<%
						while(goodsBoardOneRs.next()){
						%>
						<tr>
							<td class="column">No</td>
							<td>
								<input type="number" name="goodsNo" value="<%=goodsBoardOneRs.getInt("goodsNo")%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td class="column">카테고리</td>
							<td><%=goodsBoardOneRs.getString("category")%></td>
						</tr>
						<tr>
							<td class="column">상품명</td>
							<td>
								<input type="text" name="goodsTitle" value="<%=goodsBoardOneRs.getString("goodsTitle")%>">
							</td>
						</tr>
						<tr>
							<td class="column">등록자</td>
							<td><%=goodsBoardOneRs.getString("empId")%></td>
						</tr>
						<tr>
							<td class="column" style="vertical-align: middle">상품이미지</td>
							<td>
								<img src="/shop/img/<%=goodsBoardOneRs.getString("goodsImg")%>" width="200px" height="200px">
							</td>
						</tr>
						<tr>
							<td class="column">가격</td>
							<td>
								<input type="text" name="goodsPrice" value="<%=goodsBoardOneRs.getString("goodsPrice")%>">
							</td>
						</tr>
						<tr>
							<td class="column">상품내용</td>
							<td>
								<textarea name="goodsContent" rows="5" cols="70"><%=goodsBoardOneRs.getString("goodsContent")%></textarea>
							</td>
						</tr>
						<%
						}
						%>
					</table>
					<button type="submit" class="btn btn-outline-dark">수정하기</button>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>