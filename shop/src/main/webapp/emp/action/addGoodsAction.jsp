<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.net.URLEncoder"%>
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
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
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
	
	// 디버깅 코드
	System.out.println("category : " + category);
	System.out.println("empId : " + empId);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);
	System.out.println("goodsContent : " + goodsContent);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String addGoodsSql = "INSERT INTO goods(category, emp_id, goods_title, goods_content, goods_price, goods_amount, goods_img) VALUES(?, ?, ?, ?, ?, ?, ?)";
	
	PreparedStatement addGoodsStmt = null;
	addGoodsStmt = conn.prepareStatement(addGoodsSql);
	addGoodsStmt.setString(1, category);
	addGoodsStmt.setString(2, empId);
	addGoodsStmt.setString(3, goodsTitle);
	addGoodsStmt.setString(4, goodsContent);
	addGoodsStmt.setInt(5, goodsPrice);
	addGoodsStmt.setInt(6, goodsAmount);
	addGoodsStmt.setString(7, fileName);
	
	System.out.println("addGoodsStmt : " + addGoodsStmt);
	
	int addGoodsRow = addGoodsStmt.executeUpdate();
%>
	<!-- Controller Layer -->
<%
	if(addGoodsRow == 1){
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

	/*
	File df = new File(filePath, rs.getString("fileName"));
	df.delete();
	*/
	// response.sendRedirect("/shop/emp/goodsList.jsp")
	
	// I/O stream은 가비지컬렉터의 대상이 아니기 때문에
	// 사용후 지워주지 않으면 심각한 메모리 누수가 발생한다
%>