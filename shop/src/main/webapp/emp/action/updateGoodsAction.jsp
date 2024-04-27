<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.GoodsDAO"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsImg = request.getParameter("goodsImg");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsContent = request.getParameter("goodsContent");
	
	// 파라미터 디버깅 코드
	System.out.println("goodsNo : " + goodsNo);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsImg : " + goodsImg);
	System.out.println("goodsPrice : " + goodsPrice);
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
	
	// 상품 상세 정보를 수정한 내용을 DB에 저장하기
	boolean updateGoods = GoodsDAO.updateGoods(goodsTitle, fileName, goodsContent, goodsPrice, goodsNo);
	
	if(updateGoods){
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
		
		System.out.println("상품 상세 정보 수정에 성공하였습니다.");
		response.sendRedirect("/shop/emp/form/goodsBoardOne.jsp?goodsNo=" + goodsNo);
	}else{
		System.out.println("상품 상세 정보 수정에 실패하였습니다.");
		response.sendRedirect("/shop/emp/form/updateGoodsForm.jsp?goodsNo=" + goodsNo);
	}
	
	// DAO 디버깅 코드
	System.out.println("updateGoods : " + GoodsDAO.updateGoods(goodsTitle, fileName, goodsContent, goodsPrice, goodsNo));
%>