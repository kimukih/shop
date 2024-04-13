<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	System.out.println("mail : " + mail);
	System.out.println("pw : " + pw);
	
	// DB의 mail, pw에 해당하는 회원정보 삭제하기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String deleteCustomerSql = "DELETE FROM customer WHERE mail = ? AND pw = PASSWORD(?)";
	PreparedStatement deleteCustomerStmt = null;
	
	deleteCustomerStmt = conn.prepareStatement(deleteCustomerSql);
	deleteCustomerStmt.setString(1, mail);
	deleteCustomerStmt.setString(2, pw);
	System.out.println("deleteCustomerStmt : " + deleteCustomerStmt);
	
	int deleteCustomerRow = deleteCustomerStmt.executeUpdate();
	if(deleteCustomerRow == 1){
		System.out.println("회원 정보 삭제에 성공하였습니다.");
		session.invalidate();
		response.sendRedirect("/shop/customer/form/deleteCustomerResult.jsp");
	}else{
		System.out.println("회원 정보 삭제에 실패하였습니다.");
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/deleteCustomerForm.jsp?mail=" + mail + "&msg=" + msg);
	}
	
%>