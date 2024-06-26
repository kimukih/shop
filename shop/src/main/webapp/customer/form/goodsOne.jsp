<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%@ page import="shop.dao.CategoryDAO"%>
<%@ page import="shop.dao.CommentDAO"%>
<%@ page import="shop.dao.WishListDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String category = request.getParameter("category");
	if(category == null){
		category = "";
	}
	
	String keyword = request.getParameter("keyword");
	if(keyword == null){
		keyword = "";
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	// 파라미터 디버깅 코드
	System.out.println("category : " + category);
	System.out.println("keyword : " + keyword);
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("currentPage : " + currentPage);
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<!-- Model Layer -->
<%
	// 카테고리 테이블 내용 DB에서 가져오기
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.getCategoryCnt();
	
	// goodsNo에 해당하는 정보를 DB에서 불러오기
	ArrayList<HashMap<String, Object>> goodsOne = GoodsDAO.getGoodsOne(goodsNo);
	
	// 검색을 위한 카테고리 목록 가져오기
	ArrayList<String> categoryAll = CategoryDAO.getCategoryAll();
	
	// goodsNo와 같은 상품 리뷰의 총 개수를 가져오기
	int totalGoodsComment = CommentDAO.getTotalGoodsComment(goodsNo);
	
	// 상품 리뷰 페이징 변수
	int rowPerPage = 5;
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 마지막 페이지
	int lastPage = totalGoodsComment / rowPerPage;
	if(totalGoodsComment % rowPerPage != 0){
		lastPage = (totalGoodsComment / rowPerPage) + 1;
	}
	System.out.println("lastPage : " + lastPage);
	
	// 상품 리뷰 리스트 가져오기
	ArrayList<HashMap<String, Object>> goodsCommentList = CommentDAO.getGoodsCommentList(goodsNo, startRow, rowPerPage);
	
	// 이미 장바구니에 담은 상품을 한번 더 찜하기 할 경우 메시지 출력 후 찜하기 하지 않음
	String mail = (String)(loginMember.get("mail"));
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	
	// 상품이 장바구니에 이미 담겨있는지 아닌지 조회
	boolean selectWishList = WishListDAO.selectWishList(mail, goodsNo);
	
	// DAO 디버깅 코드
	System.out.println("categoryList : " + GoodsDAO.getCategoryCnt());
	System.out.println("goodsOne : " + GoodsDAO.getGoodsOne(goodsNo));
	System.out.println("categoryAll : " + CategoryDAO.getCategoryAll());
	System.out.println("totalGoodsComment : " + totalGoodsComment);
	System.out.println("goodsCommentList : " + CommentDAO.getGoodsCommentList(goodsNo, startRow, rowPerPage));
	System.out.println("selectWishList : " + WishListDAO.selectWishList(mail, goodsNo));
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
			
		}
		
		.table td{
			height: 60px;
			vertical-align: middle;
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
		
		a.plusMinus{
			border: 1px solid #000000;
			text-align: center;
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
			<td colspan="3" style="width: 400px;">
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
				<a style="color: #000000;" href="/shop/customer/form/customerOne.jsp?mail=<%=loginMember.get("mail")%>">
					<img src="/shop/img/user.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
					<%=(String)(loginMember.get("name"))%> 님
				</a>
			</td>
			<td rowspan="2" style="width: 70px">
				<a style="color: #000000;" href="/shop/customer/form/wishList.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=goodsNo%>&currentPage=1">
					<img src="/shop/img/cart.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
					장바구니
				</a>
			</td>
			<td rowspan="2" style="width: 70px">
				<a style="color: #000000;" href="/shop/customer/action/logout.jsp">
					<img src="/shop/img/logout.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
					로그아웃
				</a>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<!-- 서브 메뉴 : 카테고리 별 상품리스트 -->
				<div>
					<a style="color: #000000" href="/shop/customer/goodsList.jsp">&nbsp;전체&nbsp;</a>
					<%
						for(HashMap m : categoryList){
					%>
							<b>| </b> 
							<a style="color: #000000" href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
							&nbsp;<%=(String)(m.get("category"))%>(<%=(Integer)(m.get("cnt"))%>)&nbsp;</a>
					<%
						}
					%>
				</div>
			</td>
		</tr>
	</table>
	</div>
		<div class="main row">
			<!-- 메인 내용 시작 -->
				<br>
				<%
				for(HashMap<String, Object> m : goodsOne){
				%>
					<div class="grid">
						<div>
							<img src="/shop/img/<%=(String)(m.get("goodsImg"))%>" width="550px" height="600px">
						</div>
						<div>
							<table class="table">
								<tr>
									<td><h2>상품명 : </h2></td>
									<td><h2><%=(String)(m.get("goodsTitle"))%></h2></td>
								</tr>
								<tr>
									<td>카테고리 : </td>
									<td><%=(String)(m.get("category"))%></td>
								</tr>
								<tr>
									<td>등록자 : </td>
									<td><%=(String)(m.get("empId"))%></td>
								</tr>
								<tr>
									<td>가격 : </td>
									<td><%=(Integer)(m.get("goodsPrice"))%>원</td>
								</tr>
								<tr>
									<td>판매재고 : </td>
									<td><%=(Integer)(m.get("goodsAmount"))%>개</td>
								</tr>
								<tr>
									<td>배송방법 : </td>
									<td>택배</td>
								</tr>
								<tr>
									<td>배송비 : </td>
									<td>2,500원 (50,000원 이상 구매 시 무료)</td>
								</tr>
							</table>
							<br>
							<form>
							<h4>
								수량 : <input id="amount" type="number" name="amount" min="1" max="100" value="1">
								<button type="button" onclick="plusBtn()"><b>&nbsp;+&nbsp;</b></button>
								<button type="button" onclick="minusBtn()"><b>&nbsp;-&nbsp;</b></button>
							</h4>
							<script>
								let amount = 0;
								function plusBtn() {
									document.getElementById("amount").value = ++amount;
								}
								
								function minusBtn() {
									document.getElementById("amount").value = --amount;
								}
							</script>
							<br>
							
							<h4>
								총 상품금액(수량) : <%=(Integer)(m.get("goodsPrice"))%>원(1개) &nbsp;&nbsp;
							</h4>
							<br>
							
							<a href="/shop/customer/form/ordersGoodsForm.jsp?mail=<%=loginMember.get("mail")%>&goodsNo=<%=goodsNo%>" class="btn btn-outline-dark">구매하기</a>
							<%
							if(!selectWishList){
							%>
								<a onclick="alert('상품을 장바구니에 담았습니다.')" 
								href="/shop/customer/action/addWishListAction.jsp?
								mail=<%=loginMember.get("mail")%>&goodsNo=<%=goodsNo%>&goodsImg=<%=(String)(m.get("goodsImg"))%>&goodsTitle=<%=(String)(m.get("goodsTitle"))%>&category=<%=(String)(m.get("category"))%>&goodsPrice=<%=(Integer)(m.get("goodsPrice"))%>" class="btn btn-outline-dark">찜하기
								</a>
							<%
							}else{
							%>
								<a onclick="alert('이미 장바구니에 추가된 상품입니다.')" 
								href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=1" class="btn btn-outline-dark">찜하기
								</a>
							<%
							}
							%>
							</form>
						</div>
					</div>
					<div style="margin-top: 30px;">
						<hr>
						<br>
						<h2>상품 설명</h2>
						<br>
						<%=m.get("goodsContent")%>
					</div>
					<div style="margin-top: 30px;">
						<hr>
						<br>
						<h2>상품 리뷰</h2>
						<br>
						<table class="table">
							<tr>
								<td style="width: 100px">주문번호</td>
								<td style="width: 150px">작성자</td>
								<td>상품평</td>
								<td style="width: 100px">별점</td>
								<td style="width: 200px">작성일자</td>
								<td style="width: 80px">&nbsp;</td>
							</tr>
						<%
						if(goodsCommentList.size() != 0) {
							for(HashMap<String, Object> m2 : goodsCommentList){
						%>
								<tr>
									<td><%=(Integer)(m2.get("ordersNo"))%></td>
									<td><%=(String)(m2.get("name"))%></td>
									<td><%=(String)(m2.get("comment"))%></td>
									<td><%=(Integer)(m2.get("score"))%>점 / 5점</td>
									<td><%=(String)(m2.get("createDate"))%></td>
									<%
									if(loginMember.get("mail").equals(m2.get("mail"))){
									%>
										<td><a class="btn btn-outline-dark" href="/shop/customer/action/deleteGoodsCommentAction.jsp?ordersNo=<%=(Integer)(m2.get("ordersNo"))%>&goodsNo=<%=goodsNo%>">삭제</a></td>
									<%
									}else{
									%>
										<td>&nbsp;</td>
									<%
									}
									%>
								</tr>
						<%
							}
						}else{
						%>
							<tr>
								<td colspan="6"><h3>현재 등록된 상품 리뷰가 없습니다.</h3></td>
							</tr>
						<%
						}
						%>
						</table>
						<nav aria-label="Page navigation example">
						  <ul class="pagination justify-content-center">
							<%
							if(currentPage > 1 && currentPage < lastPage){
							%>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=1">&laquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=lastPage%>">&raquo;</a></li>
							<%
							}else if(lastPage == 0){
							%>
								<li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
							<%
							}else if(currentPage == lastPage){
							%>
								<li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=1">&laquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
							<%
							}else if(currentPage == 1){
							%>
								<li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage%>"><%=currentPage%></a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
							    <li class="page-item"><a class="page-link" href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=lastPage%>">&raquo;</a></li>
							<%
							}
							%>		
						  </ul>
						</nav>
					</div>
				<%
				}
				%>
				<br><br><br><br><br><br>
				<span style="font-size: 13px; color: gray; margin-top: 30px;">Copyright © 2024 WBShopin Co.,Ltd. All Rights Reserved.</span>
				
			<!-- 메인 내용 끝 -->
		</div>
	</div>
	
</body>
</html>