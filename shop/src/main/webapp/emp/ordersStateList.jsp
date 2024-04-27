<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.OrdersDAO"%>
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
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));

	// 결제 완료된 상품의 총 개수를 가져오기
	int totalOrders = OrdersDAO.getTotalOrders();
	
	// 상품 리뷰 페이징 변수
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
	
	// 마지막 페이지
	int lastPage = totalOrders / rowPerPage;
	if(totalOrders % rowPerPage != 0){
		lastPage = (totalOrders / rowPerPage) + 1;
	}

	// 파라미터 디버깅 코드
	System.out.println("currentPage : " + currentPage);
	
	// 주문 완료된 상품의 배송현황 리스트 가져오기
	ArrayList<HashMap<String, Object>> ordersStateList = OrdersDAO.getOrdersStateList(startRow, rowPerPage);
	
	// DAO 디버깅 코드
	System.out.println("totalOrders : " + OrdersDAO.getTotalOrders());
	System.out.println("ordersStateList : " + OrdersDAO.getOrdersStateList(startRow, rowPerPage));
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>배송 상태 관리</title>
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
	<span><a class="btn btn-outline-dark" href="/shop/emp/empList.jsp">이전</a></span>
	</div>
		<div class="row">
			<div class="col"></div>
			<div class="main col-8">
			<!-- 메인 내용 시작 -->
				<h1>배송 상태 리스트</h1>
				<br>
				<table class="table" border=1>
					<tr>
						<td>주문번호</td>
						<td>상품번호</td>
						<td>상품명</td>
						<td>주문일시</td>
						<td>배송상태</td>
					</tr>
					<%
					for(HashMap<String, Object> m : ordersStateList){
					%>
					<tr>
						<td><%=(Integer)(m.get("ordersNo"))%></td>
						<td><%=(Integer)(m.get("goodsNo"))%></td>
						<td><%=(String)(m.get("goodsTitle"))%></td>
						<td><%=(String)(m.get("ordersDate"))%></td>
						<td>
					<%
						if(m.get("state").equals("결제완료")){
					%>
							<a class="btn btn-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=<%=m.get("state")%>">결제완료</a>
							<a class="btn btn-outline-dark" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=배송중">배송중</a>
							<a class="btn btn-outline-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=배송완료">배송완료</a>
					<%
						}else if(m.get("state").equals("배송중")){
					%>
							<a class="btn btn-outline-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=결재완료%>">결제완료</a>
							<a class="btn btn-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=<%=m.get("state")%>">배송중</a>
							<a class="btn btn-outline-dark" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=배송완료">배송완료</a>
					<%
						}else if(m.get("state").equals("배송완료")){
					%>
							<a class="btn btn-outline-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=결재완료">결제완료</a>
							<a class="btn btn-outline-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=배송중">배송중</a>
							<a class="btn btn-dark disabled" href="/shop/emp/action/modifyStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=<%=m.get("state")%>">배송완료</a>
					<%
						}
					%>
						</td>
					</tr>
					<%
					}
					%>
				</table>
				<br>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<%
						if(currentPage > 1 && currentPage < lastPage){
						%>
							<li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=1">&laquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
						<%
						}else if(currentPage == 1){
						%>
							<li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=1"><%=currentPage%></a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage+1%>">&rsaquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=lastPage%>">&raquo;</a></li>
						<%
						}else if(currentPage == lastPage){
						%>
							<li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=1">&laquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage-1%>">&lsaquo;</a></li>
						    <li class="page-item"><a class="page-link" href="/shop/emp/ordersStateList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
						<%
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