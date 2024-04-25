<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<!-- Controller Layer -->
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	int grade = Integer.parseInt(request.getParameter("grade"));
	String empPw = request.getParameter("empPw");
	
	System.out.println("empId : " + empId);
	System.out.println("empName : " + empName);
	System.out.println("empJob : " + empJob);
	System.out.println("grade : " + grade);
	System.out.println("empPw : " + empPw);
	
	// 수정된 정보에 맞게 DB 업데이트
	boolean updateEmpOne = EmpDAO.updateEmpOne(empName, empJob, grade, empId, empPw);
	
	if(updateEmpOne){	// 정보 수정 성공
		System.out.println("관리자 정보 수정에 성공하였습니다.");
		response.sendRedirect("/shop/emp/form/empOne.jsp?empId=" + empId);
	}else{	// 정보 수정 실패
		System.out.println("관리자 정보 수정에 실패하였습니다.");
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/emp/form/updateEmpOneForm.jsp?empId=" + empId + "&msg=" + msg);
	}
%>
