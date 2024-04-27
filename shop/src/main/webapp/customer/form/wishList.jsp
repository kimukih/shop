<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.WishListDAO"%>
<%@ page import="shop.dao.CategoryDAO"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	String category = request.getParameter("category");
	if(category == null){
		category = "";
	}
	
	String keyword = request.getParameter("keyword");
	if(keyword == null){
		keyword = "";
	}
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("currentPage : " + currentPage);
	System.out.println("category : " + category);
	System.out.println("keyword : " + keyword);
	
	// 검색을 위한 카테고리 목록 가져오기
	ArrayList<String> categoryAll = CategoryDAO.getCategoryAll();
	
	// 카테고리 테이블 내용 DB에서 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.getCategoryCnt();
	
	// 접속한 아이디의 장바구니 목록 모두 가져오기
	int totalWishList = WishListDAO.getTotalWishList(mail);
		
	// 상품 리뷰 페이징 변수
	int rowPerPage = 5;
	int startRow = (currentPage - 1) * rowPerPage;
		
	// 마지막 페이지
	int lastPage = totalWishList / rowPerPage;
	if(totalWishList % rowPerPage != 0){
		lastPage = (totalWishList / rowPerPage) + 1;
	}
	
	// 카테고리에 해당하는 상품리스트를 가져오는 코드 작성
	ArrayList<HashMap<String, Object>> getGoodsList = GoodsDAO.getGoodsList(category, keyword, startRow, rowPerPage);

	// 접속한 ID로 추가한 장바구니 목록 리스트
	ArrayList<HashMap<String, Object>> wishList = WishListDAO.getWishList(mail, startRow, rowPerPage);
	
	// DAO 디버깅 코드
	System.out.println("totalWishList : " + WishListDAO.getTotalWishList(mail));
	System.out.println("getGoodsList : " + GoodsDAO.getGoodsList(category, keyword, startRow, rowPerPage));
	System.out.println("wishList : " + WishListDAO.getWishList(mail, startRow, rowPerPage));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>장바구니</title>
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
	
		div.main{
			text-align: center;
			border: 1px solid #EAEAEA;
			padding-top: 20px;
			padding-bottom: 20px;
			margin-bottom: 50px;
		}
		
		div.row{
			text-align: center;
		}
		
		.table{
			text-align: center;
			border-top: solid 2px;
		}
		
		.table td{
			height: 60px;
			vertical-align: middle;
		}
		
		.table td.menu{
			background-color: #EAEAEA;
			width: 200px;
			text-align: right;
			padding-right: 30px;
		}
		
		.table td.content{
			text-align: left;
			padding-left: 30px;
		}
		
		a{
			text-decoration: none;
			color: #000000;
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
		
		div.product{
			display: inline-block;
			width: 250px;
			height: 250px;
			margin-top: 50px;
			padding-left: 65px;
		}
		
		nav{
			margin-top: 70px;
		}
		
		div.header{
			padding-top: 20px;
			margin-bottom: 50px;
		}
		
		table.head{
			width: 1300px;
			height: 120px;
		}
		
		table.head td{
			text-align: center;
		}
		
		div.grid{
			display: grid;
			grid-template-columns: 1fr 1fr;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<table class="head">
			<tr>
				<td rowspan="2" style="text-align: center; width: 300px;">
					<h1>
						<a style="color: #000000;" href="/shop/customer/goodsList.jsp">
							W. B. Shoppin
						</a>
					</h1>
				</td>
				<td colspan="3" style="width: 350px;">
					<form method="get" action="/shop/customer/goodsList.jsp?keyword=<%=keyword%>">
						<select name="category">
							<option value="">카테고리(전체)</option>
						<%
						for(String c : categoryAll){
						%>
							<option value="<%=c%>"><%=c%></option>
						<%
						}
						%>
						</select>
						<input style="margin-left: 20px;" type="text" name="keyword" size="55px" placeholder="찾으시는 상품을 검색해보세요.">
						<button class="btn btn-outline-dark" type="submit" style="margin-left: 20px;">검색</button>
					</form>
				</td>
				<td rowspan="2" style="width: 70px">
					<a href="/shop/customer/form/customerOne.jsp?mail=<%=loginMember.get("mail")%>">
						<img src="/shop/img/user.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
						<%=(String)(loginMember.get("name"))%> 님
					</a>
				</td>
				<td rowspan="2" style="width: 70px">
					<%
					for(HashMap<String, Object> m : getGoodsList){
					%>
					<a href="/shop/customer/form/wishList.jsp?mail=<%=loginMember.get("mail")%>&currentPage=1">
					<%
					}
					%>
						<img src="/shop/img/cart.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
						장바구니
					</a>
				</td>
				<td rowspan="2" style="width: 70px">
					<a href="/shop/customer/action/logout.jsp">
						<img src="/shop/img/logout.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
						로그아웃
					</a>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<!-- 서브 메뉴 : 카테고리 별 상품리스트 -->
					<div>
						<a href="/shop/customer/goodsList.jsp">&nbsp;전체&nbsp;</a>
						<%
							for(HashMap m : categoryList){
						%>
								<b>| </b> 
								<a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
								&nbsp;<%=(String)(m.get("category"))%>(<%=(Integer)(m.get("cnt"))%>)&nbsp;</a>
						<%
							}
						%>
					</div>
				</td>
			</tr>
		</table>
		</div>
		<h1 style="text-align: center; margin-bottom: 30px;">장바구니</h1>
		<div class="main row">
			<!-- 메인 내용 시작 -->
			<h2 style="text-align: left; margin-bottom: 30px;">찜한상품목록</h2>
			<hr><br><br>
			<%
			if(wishList.size() != 0){
				for(HashMap<String, Object> m : wishList){
			%>
					<table class="table">
						<tr>
							<td style="width: 70px">No</td>
							<td style="width: 300px">상품이미지</td>
							<td style="width: 150px">카테고리</td>
							<td>상품명</td>
							<td style="width: 170px">판매가격</td>
							<td rowspan="2" style="width: 150px; border-left: solid 1px #EAEAEA;">
								<a style="margin-bottom: 5px" class="btn btn-outline-dark" href="/shop/customer/form/ordersGoodsForm.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=(Integer)(m.get("goodsNo"))%>">구매하기</a><br>
								<a style="margin-top: 5px"class="btn btn-outline-danger" href="/shop/customer/action/deleteWishListAction.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=(Integer)(m.get("goodsNo"))%>">삭제하기</a>
							</td>
						</tr>
						<tr>
							<td><%=(Integer)(m.get("wishNo"))%></td>
							<td><a href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&currentPage=1"><img src="/shop/img/<%=(String)(m.get("goodsImg"))%>" width="150px" height="150px"></a></td>
							<td><%=(String)(m.get("category"))%></td>
							<td><a href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&currentPage=1"><%=(String)(m.get("goodsTitle"))%></a></td>
							<td><%=(Integer)(m.get("goodsPrice"))%></td>
						</tr>
					</table>
			<%
				}
			}else{
			%>
					<h2 style="margin-bottom: 30px">장바구니에 담은 상품이 없습니다.</h2>
			<%
			}
			%>
			<!-- 페이지네이션 -->
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<%
					if(currentPage > 1 && currentPage < lastPage){
					%>
						<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=1">&laquo;</a></li>
						<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
						<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
						<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
						<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=lastPage%>">&raquo;</a></li>
					<%
					}else if(currentPage == 1){
					%>
					<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
					<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
					<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=lastPage%>">&raquo;</a></li>
					<%
					}else if(currentPage == lastPage){
					%>
					<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=1">&laquo;</a></li>
					<li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
				    <li class="page-item"><a class="page-link" href="/shop/customer/form/wishList.jsp?mail=<%=mail%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
					<%
					}
					%>
				</ul>
			</nav>
			<!-- 메인 내용 끝 -->
		</div>
	</div>
</body>
</html>