<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	// 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("pw : " + pw);
	System.out.println("name : " + name);
	System.out.println("birth : " + birth);
	System.out.println("gender : " + gender);

	// 회원가입 시 작성한 내용을 DB안의 customer table에 추가하는 코트
	int addCustomerRow = CustomerDAO.addCustomer(mail, pw, name, birth, gender);
	
	if(addCustomerRow == 1){
		System.out.println("회원가입이 성공적으로 완료되었습니다.");
		response.sendRedirect("/shop/customer/form/addCustomerResult.jsp?name=" + URLEncoder.encode(name, "UTF-8"));
	}else{
		System.out.println("회원가입에 실패하였습니다.");
		response.sendRedirect("/shop/customer/form/addCustomerForm.jsp");
	}
	
	/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String addCustomerSql = "INSERT INTO customer(mail, pw, name, birth, gender) VALUES(?, PASSWORD(?), ?, ?, ?)";
	PreparedStatement addCustomerStmt = null;
	
	addCustomerStmt = conn.prepareStatement(addCustomerSql);
	addCustomerStmt.setString(1, mail);
	addCustomerStmt.setString(2, pw);
	addCustomerStmt.setString(3, name);
	addCustomerStmt.setString(4, birth);
	addCustomerStmt.setString(5, gender);
	System.out.println("addCustomerStmt : " + addCustomerStmt);
	
	int addCustomerRow = addCustomerStmt.executeUpdate();
	*/
%>