package shop.dao;

import java.sql.*;
import java.util.*;

public class CommentDAO {
	
	public static boolean addGoodsComment(int ordersNo, int goodsNo, int score, String comment) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		boolean addGoodsComment;
		
		String sql = "INSERT INTO comment(orders_no, goods_no, score, comment) VALUES(?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, score);
		stmt.setString(4, comment);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			addGoodsComment = true;
		}else {
			addGoodsComment = false;
		}
		
		conn.close();
		return addGoodsComment;

	}
	
	public static ArrayList<HashMap<String, Object>> getGoodsCommentList(int goodsNo) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> goodsCommentList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, score, comment, create_date createDate FROM comment WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("score", rs.getInt("score"));
			m.put("comment", rs.getString("comment"));
			m.put("createDate", rs.getString("createDate"));
			goodsCommentList.add(m);
		}
		
		conn.close();
		return goodsCommentList;
	}
	
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
}
