package shop.dao;

import java.sql.*;
import java.util.*;

public class OrdersDAO {

	public static boolean createOrders(String mail, int goodsNo, String goodsTitle, int totalAmount, int totalPrice) throws Exception {
		
		boolean createOrders;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO orders(mail, goods_no, goods_title, total_amount, total_price) VALUES(?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setString(3, goodsTitle);
		stmt.setInt(4, totalAmount);
		stmt.setInt(5, totalPrice);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			createOrders = true;
		}else {
			createOrders = false;
		}
		
		conn.close();
		return createOrders;
	}
}
