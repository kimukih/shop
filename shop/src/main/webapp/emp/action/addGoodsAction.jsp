<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 로그인 인증 분기
	if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/shop/emp/form/empLoginForm.jsp");
	return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서 -->
<%
	HashMap<String, Object> loginMember = 
	(HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<%
	// 요청값 분석
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
	// 파라미터 디버깅 코드
	System.out.println("category : " + category);
	System.out.println("empId : " + empId);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);
	System.out.println("goodsContent : " + goodsContent);
	
	// 첨부 파일의 바이너리(정보) 그대로 받아서 part 객체 안에 저장
	Part part = request.getPart("goodsImg");
	
	// 업로드된 원본 파일 이름
	String originalName = part.getSubmittedFileName();
	
	// 원본 이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);
	System.out.println("파일 확장자 : " + ext);
	
	// part에서 file로 넘어갈 때 랜덤한 파일명 부여
	UUID uuid = UUID.randomUUID();
	// fileName 변수에 - 문자는 모두 빈 문자열로 치환한 랜덤한 파일명 저장
	String fileName = uuid.toString().replace("-", "");
	// 랜덤한 파일명. + 확장자 로 저장
	fileName = fileName + ext;
	
%>
	<!-- Controller Layer -->
<%
	//DB에 goods 정보 추가
	boolean addGoods = GoodsDAO.addGoods(category, empId, goodsTitle, goodsContent, goodsPrice, goodsAmount, fileName);
	
	if(addGoods){
		// 저장될 위치를 현재 프로젝트(톰켓 컨텍스트)안으로 지정
		String uploadPath = request.getServletContext().getRealPath("img");
		System.out.println(uploadPath);
		
		File file = new File(uploadPath, fileName);	// 랜덤한 파일이름으로 만든 빈파일 생성
		InputStream is = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴
		OutputStream os = Files.newOutputStream(file.toPath()); // 메모리로 불러온 파일(바이너리)을 빈파일에 저장
		is.transferTo(os);
		
		// Spring Framework 에서는 part.transferTo(file); 이 가능해짐
		System.out.println("상품 추가 성공");
		
		is.close();
		os.close();
		
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}else{
		System.out.println("상품 추가 실패");
		return;
	}
	
	// DAO 디버깅 코드
	System.out.println("addGoods : " + GoodsDAO.addGoods(category, empId, goodsTitle, goodsContent, goodsPrice, goodsAmount, fileName));
%>