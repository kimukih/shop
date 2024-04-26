<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<%@ page import="shop.dao.CategoryDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	// loginCustomer == null <--- 세션이 존재하지 않는다 == 로그인 기록이 없다
	if(session.getAttribute("loginCustomer") == null){
		
	// 로그인 기록이 없으므로 로그인 화면으로 재요청
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
	System.out.println("category : " + category);
	
	String keyword = request.getParameter("keyword");
	if(keyword == null){
		keyword = "";
	}
	System.out.println("keyword : " + keyword);
	
	String mail = request.getParameter("mail");
	System.out.println("mail : " + mail);
	
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
%>

<!-- Model Layer -->
<%
	// 카테고리 테이블 내용 DB에서 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.getCategoryCnt();
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String categoryCntSql = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category";
	PreparedStatement categoryCntStmt = null;
	ResultSet categoryCntRs = null;
	
	categoryCntStmt = conn.prepareStatement(categoryCntSql);
	categoryCntRs = categoryCntStmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(categoryCntRs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", categoryCntRs.getString("category"));
		m.put("cnt", categoryCntRs.getInt("cnt"));
		categoryList.add(m);
	}
	*/
	
	// 페이지네이션
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 시작 번호와, 페이지당 보여줄 게시물 개수
	int rowPerPage = 15;
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 총 게시물 개수 구하기
	// 카테고리 별 검색어에 해당하는 결과물만 가져오도록 분기
	int categoryListCnt = GoodsDAO.getCategoryListCnt(category, keyword);
	
	/*
	String categoryListCntSql = "";
	PreparedStatement categoryListCntStmt = null;
	
	if(category.equals("")){
		// SELECT * FROM category
		categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ?";
		categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
		categoryListCntStmt.setString(1, "%"+keyword+"%");
		categoryListCntStmt.setString(2, "%"+keyword+"%");
		System.out.println("categoryListCntStmt : " + categoryListCntStmt);
	}else{
		// SELECT * FROM category WHERE category = ?
		categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?)";
		categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
		categoryListCntStmt.setString(1, category);
		categoryListCntStmt.setString(2, "%"+keyword+"%");
		categoryListCntStmt.setString(3, "%"+keyword+"%");
		System.out.println("categoryListCntStmt : " + categoryListCntStmt);
	}
	ResultSet categoryListCntRs = null;
	
	categoryListCntRs = categoryListCntStmt.executeQuery();
	
	int categoryListCnt = 0;
	if(categoryListCntRs.next()){
		categoryListCnt = categoryListCntRs.getInt("cnt");
	}
	System.out.println("categoryListCnt : " + categoryListCnt);
	*/
	
	// 마지막 페이지
	// 총 게시물 개수를 페이지당 게시물 수로 나눔
	int lastPage = categoryListCnt / rowPerPage;
	if(categoryListCnt % rowPerPage != 0){
		lastPage = categoryListCnt / rowPerPage + 1;
	}
	System.out.println("lastPage : " + lastPage);
	
	// 카테고리에 해당하는 상품리스트를 가져오는 코드 작성
	ArrayList<HashMap<String, Object>> getGoodsList = GoodsDAO.getGoodsList(category, keyword, startRow, rowPerPage);
	
	/*
	String categoryListSql = "";
	PreparedStatement categoryListStmt = null;
	ResultSet categoryListRs = null;
	
	if(category.equals("")){
		// SELECT * FROM category
		categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ? LIMIT ?, ?";
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListStmt.setString(1, "%"+keyword+"%");
		categoryListStmt.setString(2, "%"+keyword+"%");
		categoryListStmt.setInt(3, startRow);
		categoryListStmt.setInt(4, rowPerPage);
		System.out.println("categoryListStmt : " + categoryListStmt);
	}else{
		// SELECT * FROM category WHERE category = ?
		categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?) LIMIT ?, ?";
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListStmt.setString(1, category);
		categoryListStmt.setString(2, "%"+keyword+"%");
		categoryListStmt.setString(3, "%"+keyword+"%");
		categoryListStmt.setInt(4, startRow);
		categoryListStmt.setInt(5, rowPerPage);
		System.out.println("categoryListStmt : " + categoryListStmt);
	}
	categoryListRs = categoryListStmt.executeQuery();
	*/
	
	// 검색을 위한 카테고리 목록 가져오기
	ArrayList<String> categoryAll = CategoryDAO.getCategoryAll();
	
	/*
	String categoryAllSql = "SELECT category FROM category";
	PreparedStatement categoryAllStmt = null;
	ResultSet categoryAllRs = null;
	
	categoryAllStmt = conn.prepareStatement(categoryAllSql);
	categoryAllRs = categoryAllStmt.executeQuery();
	*/
	
	// DAO 디버깅 코드
	System.out.println("CategoryDAO.getCategoryCnt() : " + CategoryDAO.getCategoryCnt());
	System.out.println("GoodsDAO.getCategoryListCnt(category, keyword) : " + GoodsDAO.getCategoryListCnt(category, keyword));
	System.out.println("GoodsDAO.getGoodsList(category, keyword, startRow, rowPerPage) : " + GoodsDAO.getGoodsList(category, keyword, startRow, rowPerPage));
	System.out.println("CategoryDAO.getCategoryAll() : " + CategoryDAO.getCategoryAll());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>W.B.Shoppin</title>
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
		
		a{
			text-decoration: none;
			color: #000000;
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
	</style>
</head>
<body>
<div class="container">
	<div class="header">
	<!-- empMenu.jsp include : 서버 기준으로 페이지 요청 vs redirect(클라이언트 기준) -->
	<!-- 주체가 서버이기 때문에 include할 때에는 절대주소가 /shop/... 으로 시작하지 않는다 -->
	<!-- 메인 메뉴 -->
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
		<div class="main row">
			<!-- 메인 내용 시작 -->
				<br>
				<!-- 상품리스트 보여주는 코드 시작 -->
				<%
					for(HashMap<String, Object> m : getGoodsList){
				%>
						<div class="product">
							<a href="/shop/customer/form/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&currentPage=1">
								<%
								if(m.get("goodsImg").equals("")){
								%>
									<img src="/shop/img/noImage.png" width="200px" height="200px"><br>
								<%
								}else{
								%>
									<img src="/shop/img/<%=(String)(m.get("goodsImg"))%>" width="200px" height="200px"><br>
								<%
								}
								%>
								<%=(Integer)(m.get("goodsNo"))%>. <%=(String)(m.get("goodsTitle"))%>...<br>
								판매가격 : <%=(Integer)(m.get("goodsPrice"))%>원<br>
								판매수량 : <%=(Integer)(m.get("goodsAmount"))%>개<br>
							</a>
						</div>
				<%
					}
				%>
				<!-- 상품리스트 보여주는 코드 시작 끝-->
				<br><br><br><br><br><br>
				
		<!-- 페이지네이션 --> 
			<div>
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				  <%
				  if(category.equals("")){
				  	if(currentPage > 1 && currentPage < lastPage){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
				   		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}else if(lastPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				  <%
				  	}else if(currentPage == lastPage){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				  <%
				  	}else if(currentPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}
				  }else{
					  if(currentPage > 1 && currentPage < lastPage){
				  %>
					  	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
					   	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
					    <li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}else if(lastPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				  <%
				  	}else if(currentPage == lastPage){
				  %>
					  	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				  <%
				  	}else if(currentPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
					 }
				  }
				  %>
				  </ul>
				</nav>
			</div>
			<!-- 메인 내용 끝 -->
		</div>
	</div>
	
</body>
</html>