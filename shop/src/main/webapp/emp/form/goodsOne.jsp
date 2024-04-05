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
	
	// goodsNo에 해당하는 정보를 DB에서 불러오기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String goodsOneSql = "SELECT goods_img goodsImg, goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, goods_amount goodsAmount FROM goods WHERE goods_no = ?";
	PreparedStatement goodsOneStmt = null;
	ResultSet goodsOneRs = null;
	
	goodsOneStmt = conn.prepareStatement(goodsOneSql);
	goodsOneStmt.setInt(1, goodsNo);
	System.out.println("goodsNo : " + goodsNo);
	
	goodsOneRs = goodsOneStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsOne</title>
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
			<table class="table category table-hover" border=1>
			<%
			ArrayList<HashMap<String, String>> goodsOneList = new ArrayList<>();
			while(goodsOneRs.next()){
				HashMap<String, String> m = new HashMap<>();
				m.put("goodsImg", goodsOneRs.getString("goodsImg"));
				m.put("goodsNo", goodsOneRs.getString("goodsNo"));
				m.put("goodsTitle", goodsOneRs.getString("goodsTitle"));
				m.put("goodsPrice", goodsOneRs.getString("goodsPrice"));
				m.put("goodsAmount", goodsOneRs.getString("goodsAmount"));
				
				goodsOneList.add(m);
			%>
				<tr>
					<td><img src="/shop/img/<%=m.get("goodsImg")%>" width="300px" height="300px"></td>
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