package shop.dao;

import java.sql.*;
import java.util.*;

public class WishListDAO {
	
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
	
	public static ArrayList<HashMap<String, Object>> getWishList(String mail) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> wishList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT wish_no wishNo, goods_no goodsNo, goods_img goodsImg, category, goods_title goodsTitle, goods_price goodsPrice FROM wishlist WHERE mail = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		
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
}