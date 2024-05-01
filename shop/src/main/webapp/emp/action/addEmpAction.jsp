<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	
	// 파라미터 디버깅 코드
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	System.out.println("empName : " + empName);
	System.out.println("empJob : " + empJob);
	System.out.println("hireDate : " + hireDate);
	
	// 회원가입 시 작성한 내용을 DB안의 customer table에 추가하는 코트
	boolean addEmp = EmpDAO.addEmp(empId, empPw, empName, empJob, hireDate);
	
	if(addEmp){
		System.out.println("회원가입이 성공적으로 완료되었습니다.");
		response.sendRedirect("/shop/emp/form/addEmpResult.jsp?empName=" + URLEncoder.encode(empName, "UTF-8"));
	}else{
		System.out.println("회원가입에 실패하였습니다.");
		response.sendRedirect("/shop/emp/form/addEmpForm.jsp");
	}
%>