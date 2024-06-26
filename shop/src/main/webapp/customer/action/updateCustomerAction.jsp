<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
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
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String pw = request.getParameter("pw");
	
	// 파라미터 디버깅 코드
	System.out.println("mail : " + mail);
	System.out.println("name : " + name);
	System.out.println("birth : " + birth);
	System.out.println("gender : " + gender);
	System.out.println("pw : " + pw);

	// 수정한 회원 정보를 DB customer table에 반영하기
	boolean updateCustomer = CustomerDAO.updateCustomer(mail, pw, name, birth, gender);
	
	if(updateCustomer){
		System.out.println("회원 정보 수정에 성공하였습니다.");
		response.sendRedirect("/shop/customer/form/customerOne.jsp?mail=" + mail);
	}else{
		System.out.println("회원 정보 수정에 실패하였습니다.");
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/updateCustomerForm.jsp?mail=" + mail + "&msg=" + msg);
	}
	
	// DAO 디버깅 코드
	System.out.println("updateCustomer : " + CustomerDAO.updateCustomer(mail, pw, name, birth, gender));
%>