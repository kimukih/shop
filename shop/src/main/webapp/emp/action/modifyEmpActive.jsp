<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	System.out.println("empId : " + empId);
	System.out.println("active : " + active);

	
	// active 상태가 OFF 일 때 누르면 ON으로, ON 일 때 누르면 OFF로 변경
	boolean modifyEmpActive = EmpDAO.modifyEmpActive(empId, active);
	if(modifyEmpActive){
		System.out.println("Active 상태 변경 성공");
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
	// DAO 디버깅 코드
	System.out.println("modifyEmpActive : " + EmpDAO.modifyEmpActive(empId, active));
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String activeSwitchSql = null;
	PreparedStatement activeSwitchStmt = null;
	
	if(active.equals("OFF")){
		activeSwitchSql = "UPDATE emp SET active = 'ON' WHERE emp_id = ?";
		activeSwitchStmt = conn.prepareStatement(activeSwitchSql);
		activeSwitchStmt.setString(1, empId);
	}else{
		activeSwitchSql = "UPDATE emp SET active = 'OFF' WHERE emp_id = ?";
		activeSwitchStmt = conn.prepareStatement(activeSwitchSql);
		activeSwitchStmt.setString(1, empId);
	}
	System.out.println("activeSwitchStmt : " + activeSwitchStmt);
	
	int onRow = activeSwitchStmt.executeUpdate();
	*/
%>