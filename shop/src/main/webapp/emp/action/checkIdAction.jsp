<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<%
	// 요청값 분석
	String empId = request.getParameter("empIdCheck");
	System.out.println("empId : " + empId);
	
	// 넘어온 mail이 DB에 있는값인지 체크
	boolean checkEmpId = EmpDAO.checkEmpId(empId);
	
	if(checkEmpId){
		// 중복된 ID가 있는 경우
		System.out.println("중복된 ID 입니다.");
		String errMsg = URLEncoder.encode("중복된 아이디 입니다. 다른 아이디를 사용해주세요.", "UTF-8");
		response.sendRedirect("/shop/emp/form/addEmpForm.jsp?empIdCheck=" + empId + "&errMsg=" + errMsg);
	}else{
		// 중복된 ID가 없는 경우
		System.out.println("사용할 수 있는 ID 입니다.");
		String sucMsg = URLEncoder.encode("사용 가능한 아이디 입니다.", "UTF-8");
		response.sendRedirect("/shop/emp/form/addEmpForm.jsp?empIdCheck=" + empId + "&sucMsg=" + sucMsg);
	}
	
	// DAO 디버깅 코드
	System.out.println("checkId : " + EmpDAO.checkEmpId(empId));
%>