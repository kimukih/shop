<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 요청값 분석
	String mailCheck = request.getParameter("mailCheck");
	System.out.println("mailCheck : " + mailCheck);
	
	// 넘어온 mail이 DB에 있는값인지 체크
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String checkIdSql = "SELECT mail FROM customer WHERE mail = ?";
	PreparedStatement checkIdStmt = null;
	ResultSet checkIdRs = null;
	
	checkIdStmt = conn.prepareStatement(checkIdSql);
	checkIdStmt.setString(1, mailCheck);
	System.out.println("checkIdStmt : " + checkIdStmt);
	
	checkIdRs = checkIdStmt.executeQuery();
	
	if(checkIdRs.next()){
		// 중복된 ID가 있는 경우
		System.out.println("중복된 ID 입니다.");
		String errMsg = URLEncoder.encode("중복된 메일 주소 입니다. 다른 이메일 주소를 사용해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/addCustomerForm.jsp?mailCheck=" + mailCheck + "&errMsg=" + errMsg);
	}else{
		// 중복된 ID가 없는 경우
		System.out.println("사용할 수 있는 ID 입니다.");
		String sucMsg = URLEncoder.encode("사용 가능한 이메일 주소 입니다.", "UTF-8");
		response.sendRedirect("/shop/customer/form/addCustomerForm.jsp?mailCheck=" + mailCheck + "&sucMsg=" + sucMsg);
	}
%>