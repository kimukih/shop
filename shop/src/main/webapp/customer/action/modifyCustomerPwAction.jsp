<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
	response.sendRedirect("/shop/customer/form/loginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String newPw = request.getParameter("newPw");
	
	System.out.println("mail : " + mail);
	System.out.println("pw : " + pw);
	System.out.println("newPw : " + newPw);
	
	
	// 현재비밀번호가 일치하지 않으면 비밀번호 변경작업 실패
	boolean pwCheck = CustomerDAO.pwCheck(mail, pw);
	System.out.println("pwCheck : " + pwCheck);
	
	if(!pwCheck){
		String msg = URLEncoder.encode("현재 비밀번호가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/modifyCustomerPwForm.jsp?mail=" + mail + "&msg=" + msg);
		return;
	}else{
		// 현재 비밀번호가 일치하지만, 새로운 비밀번호가 원래 비밀번호와 같을 때
		if(newPw.equals(pw)){
			String msg2 = URLEncoder.encode("사용중인 비밀번호 입니다. 다른 비밀번호를 입력해주세요.", "UTF-8");
			response.sendRedirect("/shop/customer/form/modifyCustomerPwForm.jsp?mail=" + mail + "&msg2=" + msg2);
			return;
		}else{
			// 현재 비밀번호 일치여부 확인 후 새로운 비밀번호로 변경
			boolean modifyCustomerPw = CustomerDAO.modifyCustomerPw(mail, pw, newPw);
	
			if(modifyCustomerPw){
				System.out.println("비밀번호가 변경되었습니다.");
				response.sendRedirect("/shop/customer/form/customerOne.jsp?mail=" + mail);
			}
		}
	}
%>