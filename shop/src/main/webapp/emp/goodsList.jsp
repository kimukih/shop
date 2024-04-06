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
	
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<!-- Model Layer -->
<%
	// 카테고리 테이블 내용 DB에서 가져오기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
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
	
	// 디버깅 코드
	System.out.println(categoryList);
	
	// 페이지네이션
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 시작 번호와, 페이지당 보여줄 게시물 개수
	int rowPerPage = 15;
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 총 게시물 개수 구하기
	String categoryListCntSql = "";
	
	if(category.equals("")){
		// SELECT * FROM category
		categoryListCntSql = "SELECT COUNT(*) cnt FROM goods";
	}else{
		// SELECT * FROM category WHERE category = ?
		categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE category = ?";
	}
	PreparedStatement categoryListCntStmt = null;
	ResultSet categoryListCntRs = null;
			
	categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
	categoryListCntStmt.setString(1, category);
	System.out.println("categoryListCntStmt : " + categoryListCntStmt);
	
	categoryListCntRs = categoryListCntStmt.executeQuery();
	
	int categoryListCnt = 0;
	if(categoryListCntRs.next()){
		categoryListCnt = categoryListCntRs.getInt("cnt");
	}
	System.out.println("categoryListCnt : " + categoryListCnt);
	
	// 마지막 페이지
	// 총 게시물 개수를 페이지당 게시물 수로 나눔
	int lastPage = categoryListCnt / rowPerPage;
	if(categoryListCnt % rowPerPage != 0){
		lastPage = categoryListCnt / rowPerPage + 1;
	}
	
	// 카테고리에 해당하는 상품리스트를 가져오는 코드 작성
	String categoryListSql = "";
	PreparedStatement categoryListStmt = null;
	ResultSet categoryListRs = null;
	
	if(category.equals("")){
		// SELECT * FROM category
		categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, goods_price goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ? LIMIT ?, ?";
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListStmt.setString(1, "%"+keyword+"%");
		categoryListStmt.setString(2, "%"+keyword+"%");
		categoryListStmt.setInt(3, startRow);
		categoryListStmt.setInt(4, rowPerPage);
		System.out.println("categoryListStmt : " + categoryListStmt);
	}else{
		// SELECT * FROM category WHERE category = ?
		categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, goods_price goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?) LIMIT ?, ?";
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListStmt.setString(1, category);
		categoryListStmt.setString(2, "%"+keyword+"%");
		categoryListStmt.setString(3, "%"+keyword+"%");
		categoryListStmt.setInt(4, startRow);
		categoryListStmt.setInt(5, rowPerPage);
		System.out.println("categoryListStmt : " + categoryListStmt);
	}
	categoryListRs = categoryListStmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
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
			padding-top: 50px;
			padding-bottom: 50px;
		}
		
		div.row{
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
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<span><a class="btn btn-outline-dark" href="/shop/emp/form/addGoodsForm.jsp">상품등록</a></span>
	<span><a class="btn btn-outline-dark" href="/shop/emp/goodsBoardList.jsp">상품리스트</a></span>
	
	<table class="head">
		<tr>
			<td rowspan="2" style="text-align: center; width: 300px;">
				<h1>
					<a style="color: #000000;" href="/shop/emp/goodsList.jsp">
						W. B. Shoppin
					</a>
				</h1>
			</td>
			<td colspan="3" style="width: 400px;">
				<form method="get" action="/shop/emp/goodsList.jsp?keyword=<%=keyword%>">
					<select name="category">
						<option value="">카테고리(전체)</option>
						<option value="귀멸의칼날">귀멸의칼날</option>
						<option value="나루토">나루토</option>
						<option value="스파이패밀리">스파이패밀리</option>
						<option value="원피스">원피스</option>
						<option value="짱구는못말려">짱구는못말려</option>
						<option value="포켓몬스터">포켓몬스터</option>
					</select>
					<input style="margin-left: 20px;" type="text" name="keyword" size="55px" placeholder="찾으시는 상품을 검색해보세요.">
					<button class="btn btn-outline-dark" type="submit" style="margin-left: 20px;">검색</button>
				</form>
			</td>
			<td rowspan="2" style="width: 100px">
				<a style="color: #000000;" href="/shop/emp/empOne.jsp">
					<img src="/shop/img/user.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
					<%=(String)(loginMember.get("empName"))%> 님
				</a>
			</td>
			<td rowspan="2" style="width: 100px">
				<a style="color: #000000;" href="/shop/emp/action/empLogout.jsp">
					<img src="/shop/img/logout.png" style="width: 30px; height: 30px; margin-bottom: 10px;"><br>
					로그아웃
				</a>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<!-- 서브 메뉴 : 카테고리 별 상품리스트 -->
				<div>
					<a style="color: #000000" href="/shop/emp/goodsList.jsp">&nbsp;전체&nbsp;</a>
					<%
						for(HashMap m : categoryList){
					%>
							<b>| </b> 
							<a style="color: #000000" href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
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
					while(categoryListRs.next()){
				%>
						<div class="product">
							<a style="color: #000000;" href="/shop/emp/form/goodsOne.jsp?goodsNo=<%=categoryListRs.getInt("goodsNo")%>">
								<%
								if(categoryListRs.getString("goodsImg").equals("")){
								%>
									<img src="/shop/img/noImage.png" width="200px" height="200px"><br>
								<%
								}else{
								%>
									<img src="/shop/img/<%=categoryListRs.getString("goodsImg")%>" width="200px" height="200px"><br>
								<%
								}
								%>
								<%=categoryListRs.getInt("goodsNo")%>. <%=categoryListRs.getString("goodsTitle")%>...<br>
								판매가격 : <%=categoryListRs.getString("goodsPrice")%>원<br>
								판매수량 : <%=categoryListRs.getString("goodsAmount")%>개<br>
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
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
				   		<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}else if(currentPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}else if(currentPage == lastPage){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				  <%
				  	}
				  }else{
					  if(currentPage > 1 && currentPage < lastPage){
				  %>
					  	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
					   	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&keyword=<%=keyword%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  }else if(currentPage == 1){
				  %>
				  		<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=category%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&keyword=<%=keyword%>">&rsaquo;</a></li>
				    	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&keyword=<%=keyword%>">&raquo;</a></li>
				  <%
				  	}else if(currentPage == lastPage){
				  %>
					  	<li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>&keyword=<%=keyword%>">&laquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&keyword=<%=keyword%>">&lsaquo;</a></li>
					    <li class="page-item"><a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&keyword=<%=keyword%>"><%=currentPage%></a></li>
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