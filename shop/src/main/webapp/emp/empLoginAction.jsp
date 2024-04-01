<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	
	// 로그인 실패 empLoginForm.jsp
	// 로그인 성공 empList.jsp
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// 로그인 시도한 정보와 일치하는 DB 계정정보 찾기
	String loginSql = "SELECT emp_id empId, emp_pw empPw FROM emp WHERE active = 'ON' AND emp_id = ? AND emp_pw = PASSWORD(?)";
	PreparedStatement loginStmt = conn.prepareStatement(loginSql);
	loginStmt.setString(1, empId);
	loginStmt.setString(2, empPw);
	System.out.println("loginStmt : " + loginStmt);
	
	ResultSet loginRs = loginStmt.executeQuery();
	
	// 로그인 성공하면 empList로 이동
	// 로그인 실패하면 empLoginForm으로 이동하며 에러메시지 출력
	if(loginRs.next()){
		session.setAttribute("loginEmp", loginRs.getString("empId"));
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}else{
		String msg = URLEncoder.encode("로그인 정보가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?msg=" + msg);
		return;
	}
%>