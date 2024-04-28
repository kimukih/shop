package shop.dao;

import java.sql.*;
import java.util.*;

public class WishListDAO {
	
	// 장바구니에 상품을 추가하는 DAO
	public static boolean addWishList(String mail, int goodsNo, String goodsImg, String category, String goodsTitle, int goodsPrice) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean addWishList;
		
		String sql = "INSERT INTO wishlist(mail, goods_no, goods_img, category, goods_title, goods_price) VALUES(?, ?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setString(3, goodsImg);
		stmt.setString(4, category);
		stmt.setString(5, goodsTitle);
		stmt.setInt(6, goodsPrice);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			addWishList = true;
		}else{
			addWishList = false;
		}
		
		conn.close();
		return addWishList;
	}
	
	// 장바구니 상품의 전체 목록을 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getWishList(String mail, int startRow, int rowPerPage) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> wishList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT wish_no wishNo, goods_no goodsNo, goods_img goodsImg, category, goods_title goodsTitle, goods_price goodsPrice FROM wishlist WHERE mail = ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("wishNo", rs.getInt("wishNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsImg", rs.getString("goodsImg"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			wishList.add(m);
		}
		
		conn.close();
		return wishList;
	}
	
	// 장바구니에 이미 현재 상품이 존재하는지 조회하는 DAO
	public static boolean selectWishList(String mail, int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean selectWishList;
		
		String sql = "SELECT wish_no FROM wishlist WHERE mail = ? AND goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			selectWishList = true;
		}else {
			selectWishList = false;
		}
		
		conn.close();
		return selectWishList;
	}
	
	// 장바구니 상품을 삭제하는 DAO
	public static boolean deleteWishList(String mail, int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean deleteWishList;
		
		String sql = "DELETE FROM wishlist WHERE mail = ? AND goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {	// 장바구니 상품 삭제 성공
			deleteWishList = true;
		}else {	// 장바구니 상품 삭제 실패
			deleteWishList = false;
		}
		
		conn.close();
		return deleteWishList;
	}
	
	// 장바구니 리스트를 페이징 하기위해 총 목록의 개수를 구하는 DAO
	public static int getTotalWishList(String mail) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		int totalWishList = 0;
		
		String sql = "SELECT count(*) cnt FROM wishlist WHERE mail = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			totalWishList = rs.getInt("cnt");
		}
		
		conn.close();
		return totalWishList;
	}
}
