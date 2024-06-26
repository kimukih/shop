<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
<%
	//로그인 인증 분기
	// loginCustomer != null <--- 세션이 존재한다 == 로그인 기록이 있다(로그인 상태이다)
	if(session.getAttribute("loginCustomer") != null){
		
	// 로그인 상태이므로 쇼핑몰 화면으로 바로 재요청
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("pw : " + pw);
	
	// DB에 파라미터로 받은 이메일과 비밀번호와 같은 정보가 있는지 확인하고
	// 정보가 존재하면 session 로그인 정보로 등록
	HashMap<String, String> loginCustomer = CustomerDAO.customerLogin(mail, pw);

	// session을 사용한 로그인 기능 구현
	// session 변수 "loginCustomer"안에 HashMap 값인 loginCustomer를 넣음
	// 이후 session.getAttribute("loginCustomer") 를 통해 세션정보 사용 가능
	if(loginCustomer != null){
		session.setAttribute("loginCustomer", loginCustomer);
		response.sendRedirect("/shop/customer/goodsList.jsp?mail=" + loginCustomer.get("mail"));
	}else{
		String msg = URLEncoder.encode("로그인 정보가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/loginForm.jsp?msg=" + msg);
	}
	
	// DAO 디버깅 코드
	System.out.println("loginCustomer : " + CustomerDAO.customerLogin(mail, pw));
%>