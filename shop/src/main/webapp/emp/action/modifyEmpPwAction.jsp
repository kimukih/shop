<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.EmpDAO"%>
<%
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
}
%>

<% 
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<%
	// 요청값 분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String newEmpPw = request.getParameter("newEmpPw");
	
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	System.out.println("newEmpPw : " + newEmpPw);
	
	// DB에 저장된 비밀번호 가져오기
	String pw = null;
	
	
	// 현재비밀번호가 일치하지 않으면 비밀번호 변경작업 실패
	boolean pwCheck = EmpDAO.empPwCheck(empId, empPw);
	System.out.println("pwCheck : " + pwCheck);
	
	if(!pwCheck){
		String msg = URLEncoder.encode("현재 비밀번호가 일치하지 않습니다. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/shop/emp/form/modifyEmpPwForm.jsp?empId=" + empId + "&msg=" + msg);
		return;
	}else{
		// 현재 비밀번호가 일치하지만, 새로운 비밀번호가 원래 비밀번호와 같을 때
		if(newEmpPw.equals(empPw)){
			String msg2 = URLEncoder.encode("사용중인 비밀번호 입니다. 다른 비밀번호를 입력해주세요.", "UTF-8");
			response.sendRedirect("/shop/emp/form/modifyEmpPwForm.jsp?empId=" + empId + "&msg2=" + msg2);
			return;
		}else{
			// 현재 비밀번호 일치여부 확인 후 새로운 비밀번호로 변경
			boolean modifyEmpPw = EmpDAO.modifyEpmPw(empId, empPw, newEmpPw);
	
			if(modifyEmpPw){
				System.out.println("비밀번호가 변경되었습니다.");
				response.sendRedirect("/shop/emp/form/empOne.jsp?empId=" + empId);
			}
		}
	}
%>