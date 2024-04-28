package shop.dao;

import java.sql.*;
import java.util.*;

public class CommentDAO {
	
	// 상품 리뷰를 추가하는 DAO
	public static boolean addGoodsComment(int ordersNo, int goodsNo, String mail, String name, int score, String comment) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		boolean addGoodsComment;
		
		String sql = "INSERT INTO comment(orders_no, goods_no, mail, name, score, comment) VALUES(?, ?, ?, RPAD(SUBSTR(?, 1, 1), LENGTH(?), '*'), ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, goodsNo);
		stmt.setString(3, mail);
		stmt.setString(4, name);
		stmt.setString(5, name);
		stmt.setInt(6, score);
		stmt.setString(7, comment);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			addGoodsComment = true;
		}else {
			addGoodsComment = false;
		}
		
		conn.close();
		return addGoodsComment;

	}
	
	// 상품 리뷰 리스트를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getGoodsCommentList(int goodsNo, int startRow, int rowPerPage) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> goodsCommentList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, mail, name, score, comment, create_date createDate FROM comment WHERE goods_no = ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			m.put("score", rs.getInt("score"));
			m.put("comment", rs.getString("comment"));
			m.put("createDate", rs.getString("createDate"));
			goodsCommentList.add(m);
		}
		
		conn.close();
		return goodsCommentList;
	}
	
	// 해당 상품의 리뷰 작성 여부를 판단하는 DAO
	public static boolean checkGoodsComment(int ordersNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean checkGoodsComment;
		
		String sql = "SELECT comment FROM comment WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			checkGoodsComment = false;
		}else{
			checkGoodsComment = true;
		}
		
		conn.close();
		return checkGoodsComment;
	}
	
	// 상품 리뷰를 삭제하는 DAO
	public static boolean deleteGoodsComment(int ordersNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean deleteGoodsComment;
		
		String sql = "DELETE FROM comment WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			deleteGoodsComment = true;
		}else {
			deleteGoodsComment = false;
		}
		
		conn.close();
		return deleteGoodsComment;
	}
	
	// 상품 리뷰 페이징을 위해 상품리뷰의 전체 개수를 가져오는 DAO
	public static int getTotalGoodsComment(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		int totalGoodsComment = 0;
		
		String sql = "SELECT count(*) totalComment FROM comment WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			totalGoodsComment = rs.getInt("totalComment");
		}
		
		conn.close();
		return totalGoodsComment;
	}
}
