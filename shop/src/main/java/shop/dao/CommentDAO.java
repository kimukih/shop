package shop.dao;

import java.sql.*;

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
}
