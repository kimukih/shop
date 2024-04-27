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
	String category = request.getParameter("category");

	// 파라미터 디버깅 코드
	System.out.println("category : " + category);	
%>

<!-- Model Layer -->
<%
	// 카테고리 테이블 내용 DB에서 가져오기
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.getCategoryCnt();
	
	// 페이지네이션
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 시작 번호와, 페이지당 보여줄 게시물 개수
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 총 게시물 개수 구하기
	int categoryListCnt = GoodsDAO.getCategoryListCnt(category);
	
	// 마지막 페이지
	// 총 게시물 개수를 페이지당 게시물 수로 나눔
	int lastPage = categoryListCnt / rowPerPage;
	if(categoryListCnt % rowPerPage != 0){
		lastPage = categoryListCnt / rowPerPage + 1;
	}
	
	// 카테고리에 해당하는 상품리스트를 가져오는 코드 작성
	ArrayList<HashMap<String, Object>> goodsBoardList = GoodsDAO.getGoodsBoardList(category, startRow, rowPerPage);
	
	// DAO 디버깅 코드
	System.out.println("categoryList : " + GoodsDAO.getCategoryCnt());
	System.out.println("categoryListCnt : " + GoodsDAO.getCategoryListCnt(category));
	System.out.println("goodsBoardList : " + GoodsDAO.getGoodsBoardList(category, startRow, rowPerPage));	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리 별 상품 리스트</title>
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
				<h1>카테고리 별 상품 리스트</h1>
				<br>
				<!-- 서브 메뉴 : 카테고리 별 상품리스트 -->
				<div>
					<a href="/shop/emp/goodsBoardList.jsp">&nbsp;전체&nbsp;</a>
					<%
						for(HashMap m : categoryList){
					%>
							<b>| </b> 
							<a href="/shop/emp/goodsBoardList.jsp?category=<%=(String)(m.get("category"))%>">
							&nbsp;<%=(String)(m.get("category"))%>(<%=(Integer)(m.get("cnt"))%>)&nbsp;</a>
					<%
						}
					%>
				</div>
				<br>
				<table class="table table-hover" border=1>
					<tr>
						<td>No</td>
						<td width="120px">카테고리</td>
						<td>상품명</td>
						<td>가격</td>
						<td>등록자</td>
					</tr>
				<%
					for(HashMap<String, Object> m : goodsBoardList){
				%>
					<tr>
						<td><%=(Integer)(m.get("goodsNo"))%></td>
						<td><%=(String)(m.get("category"))%></td>
						<td><a href="/shop/emp/form/goodsBoardOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>"><%=(String)(m.get("goodsTitle"))%></a></td>
						<td><%=(Integer)(m.get("goodsPrice"))%>원</td>
						<td><%=(String)(m.get("empId"))%></td>
					</tr>
				<%
					}
				%>
				</table>
				<br> 
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				<%
				if(request.getParameter("category") == null){
					if(currentPage > 1 && currentPage < lastPage){
				%>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=1">&laquo;</a></li>
				   		<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
				<%
				  	}else if(currentPage == 1){
				%>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
				<%
				  	}else if(currentPage == lastPage){
				%>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=1">&laquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
				<%
				  	}
				}else{
					if(currentPage > 1 && currentPage < lastPage){
				%>
					  	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=1">&laquo;</a></li>
					   	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>&category=<%=category%>"><%=currentPage%></a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">&rsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">&raquo;</a></li>
				<%
					}else if(currentPage == 1){
				%>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>&category=<%=category%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">&raquo;</a></li>
				<%
				  	}else if(currentPage == lastPage){
				%>
					  	<li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=1">&laquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsBoardList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
				<%
					}
				}
				%>
				  </ul>
				</nav>
			<!-- 메인 내용 끝 -->
			</div>
			<div class="col"></div>
		</div>
	</div>
	
</body>
</html>