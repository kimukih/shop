<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
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

	// 파라미터 디버깅 코드
	System.out.println("goodsNo : " + goodsNo);
	
	// 상품 정보에 대한 데이터 DB에서 가져오기
	ArrayList<HashMap<String, Object>> goodsBoardOne = GoodsDAO.getGoodsBoardOne(goodsNo);
	
	/*
	String goodsBoardOneSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, goods_content goodsContent, FORMAT(goods_price, 0) goodsPrice, emp_id empId, goods_img goodsImg FROM goods WHERE goods_no = ?";
	PreparedStatement goodsBoardOneStmt = null;
	ResultSet goodsBoardOneRs = null;
	goodsBoardOneStmt = conn.prepareStatement(goodsBoardOneSql);
	goodsBoardOneStmt.setInt(1, goodsNo);
	System.out.println("goodsBoardOneStmt : " + goodsBoardOneStmt);
	
	goodsBoardOneRs = goodsBoardOneStmt.executeQuery();
	*/
	
	// DAO 디버깅 코드
	System.out.println("goodsBoardOne : " + GoodsDAO.getGoodsBoardOne(goodsNo));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품상세</title>
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
		<span><a class="btn btn-outline-dark" href="/shop/emp/goodsBoardList.jsp">이전</a></span>
		</div>
			<div class="row">
				<div class="col"></div>
				<div class="main col-8">
				<!-- 메인 내용 시작 -->
				<h1>상품상세</h1>
				<br>
					<table class="table table-hover" border=1>
						<%
						for(HashMap<String, Object> m : goodsBoardOne){
						%>
						<tr>
							<td class="column">No</td>
							<td><%=(Integer)(m.get("goodsNo"))%></td>
						</tr>
						<tr>
							<td class="column">카테고리</td>
							<td><%=(String)(m.get("category"))%></td>
						</tr>
						<tr>
							<td class="column">상품명</td>
							<td><%=(String)(m.get("goodsTitle"))%></td>
						</tr>
						<tr>
							<td class="column">등록자</td>
							<td><%=(String)(m.get("empId"))%></td>
						</tr>
						<tr>
							<td class="column" style="vertical-align: middle">상품이미지</td>
							<td>
								<img src="/shop/img/<%=(String)(m.get("goodsImg"))%>" width="200px" height="200px">
							</td>
						</tr>
						<tr>
							<td class="column">가격</td>
							<td><%=(Integer)(m.get("goodsPrice"))%>원</td>
						</tr>
						<tr>
							<td class="column">상품내용</td>
							<td><%=(String)(m.get("goodsContent"))%></td>
						</tr>
						<%
						}
						%>
					</table>
					<br>
					
					<a class="btn btn-outline-dark" href="/shop/emp/form/updateGoodsForm.jsp?goodsNo=<%=goodsNo%>">상품수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btn btn-outline-danger" href="/shop/emp/action/deleteGoodsAction.jsp?goodsNo=<%=goodsNo%>">상품삭제</a>
				</div>
				<div class="col"></div>
			</div>
		</div>
				<!-- 메인 내용 끝 -->
</body>
</html>