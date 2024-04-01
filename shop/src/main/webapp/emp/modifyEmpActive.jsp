<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	System.out.println("empId : " + empId);
	System.out.println("active : " + active);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// active 상태가 OFF 일 때 누르면 ON으로 변경
	String activeOnSql = "UPDATE emp SET active = 'ON' WHERE emp_id = ?";
	PreparedStatement activeOnStmt = null;
	
	activeOnStmt = conn.prepareStatement(activeOnSql);
	activeOnStmt.setString(1, empId);
	System.out.println("activeOnStmt : " + activeOnStmt);
	
	if(active.equals("OFF")){
		int onRow = activeOnStmt.executeUpdate();
		if(onRow == 1){
			System.out.println("Active 상태 변경 성공");
			response.sendRedirect("/shop/emp/empList.jsp");
			return;
		}
	}
	
	// active 상태가 ON 일 때 누르면 OFF로 변경
	String activeOffSql = "UPDATE emp SET active = 'OFF' WHERE emp_id = ?";
	PreparedStatement activeOffStmt = null;
	
	activeOffStmt = conn.prepareStatement(activeOffSql);
	activeOffStmt.setString(1, empId);
	System.out.println("activeOffStmt : " + activeOffStmt);
	
	if(active.equals("ON")){	
		int offRow = activeOffStmt.executeUpdate();
		if(offRow == 1){
			System.out.println("Active 상태 변경 성공");
			response.sendRedirect("/shop/emp/empList.jsp");
		}
	}
%>