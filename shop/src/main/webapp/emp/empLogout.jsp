<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	// 요청값 분석
	String loginEmp = request.getParameter("loginEmp");
	System.out.println("loginEmp : " + loginEmp);

	// 세션 변수가 존재하는 경우(login 상태인 경우)
	// 로그아웃 버튼을 누르면 session(로그인정보) 삭제
	if(session.getAttribute("loginEmp") != null){
		session.invalidate();
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
	
%>
