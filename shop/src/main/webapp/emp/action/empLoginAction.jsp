<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.*"%>	<!-- shop.dao 패키지안에 있는 클래스들의 static 메서드를 사용-->
<%
	//로그인 인증 분기
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	// contoller code
	// 요청값 분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	// 파라미터 디버깅 코드
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	
	// 로그인 실패 empLoginForm.jsp
	// 로그인 성공 empList.jsp
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	// 로그인 성공하면 empList로 이동
	// 로그인 실패하면 empLoginForm으로 이동하며 에러메시지 출력
	if(loginEmp != null){	// 로그인 성공
		
		// session 변수 "loginEmp"를 생성하고 그 안에 HashMap 타입의 loginEmp를 넣는다
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		String msg = URLEncoder.encode("로그인 정보가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/emp/form/empLoginForm.jsp?msg=" + msg);
	}
	
	// DAO 디버깅 코드
	System.out.println("loginEmp : " + EmpDAO.empLogin(empId, empPw));
%>