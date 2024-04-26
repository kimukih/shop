<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		a{
			color: #000000;
			text-decoration: none;
		}
	</style>
</head>
<body>
	<div>
		<a href="/shop/emp/empList.jsp">사원관리</a>&nbsp;&nbsp;|&nbsp;&nbsp; 
		<!-- category CRUD page-->
		<a href="/shop/emp/categoryList.jsp">카테고리관리</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		<a href="/shop/emp/goodsList.jsp">상품관리</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		<a href="/shop/emp/ordersStateList.jsp?currentPage=1">배송관리</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		<span>
			<!-- 개인정보수정 -->
			<a href="/shop/emp/form/empOne.jsp?empId=<%=(String)(loginMember.get("empId"))%>">
				(M) <%=(String)(loginMember.get("empName"))%>
				님 반갑습니다.
			</a>
		</span>
	</div>
	<br>
</body>
</html>