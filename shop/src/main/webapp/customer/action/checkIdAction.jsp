<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.CustomerDAO"%>
<%
	// 요청값 분석
	String mail = request.getParameter("mailCheck");
	System.out.println("mail : " + mail);
	
	// 넘어온 mail이 DB에 있는값인지 체크
	boolean checkId = CustomerDAO.checkId(mail);
	
	if(checkId){
		// 중복된 ID가 있는 경우
		System.out.println("중복된 ID 입니다.");
		String errMsg = URLEncoder.encode("중복된 메일 주소 입니다. 다른 이메일 주소를 사용해주세요.", "UTF-8");
		response.sendRedirect("/shop/customer/form/addCustomerForm.jsp?mailCheck=" + mail + "&errMsg=" + errMsg);
	}else{
		// 중복된 ID가 없는 경우
		System.out.println("사용할 수 있는 ID 입니다.");
		String sucMsg = URLEncoder.encode("사용 가능한 이메일 주소 입니다.", "UTF-8");
		response.sendRedirect("/shop/customer/form/addCustomerForm.jsp?mailCheck=" + mail + "&sucMsg=" + sucMsg);
	}
	
	// DAO 디버깅 코드
	System.out.println("checkId : " + CustomerDAO.checkId(mail));
%>