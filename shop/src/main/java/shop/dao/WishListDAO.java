package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class WishListDAO {
	
	public static boolean addWishList(String mail, String goodsImg, String category, String goodsTitle, int goodsPrice) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean addWishList;
		
		String sql = "INSERT INTO wishlist(mail, goods_img, category, goods_title, goods_price) VALUES(?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, goodsImg);
		stmt.setString(3, category);
		stmt.setString(4, goodsTitle);
		stmt.setInt(5, goodsPrice);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			addWishList = true;
		}else{
			addWishList = false;
		}
		
		conn.close();
		return addWishList;
	}
}
