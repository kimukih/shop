package shop.dao;

import java.sql.*;
import java.util.*;

public class OrdersDAO {

	public static boolean createOrders(String mail, int goodsNo, String goodsTitle, int totalAmount, int totalPrice, String addressName, String address, String phoneNumber) throws Exception {
		
		boolean createOrders;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO orders(mail, goods_no, goods_title, total_amount, total_price, address_name, address, phone_number) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setString(3, goodsTitle);
		stmt.setInt(4, totalAmount);
		stmt.setInt(5, totalPrice);
		stmt.setString(6, addressName);
		stmt.setString(7, address);
		stmt.setString(8, phoneNumber);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			createOrders = true;
		}else {
			createOrders = false;
		}
		
		conn.close();
		return createOrders;
	}
	
	public static ArrayList<HashMap<String, Object>> getOrdersListInfo(String mail) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> ordersListInfo = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, goods_no goodsNo, goods_title goodsTitle, address_name addressName, address, phone_number phoneNumber, state FROM orders WHERE mail= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getString("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("addressName", rs.getString("addressName"));
			m.put("address", rs.getString("address"));
			m.put("phoneNumber", rs.getString("phoneNumber"));
			m.put("state", rs.getString("state"));
			ordersListInfo.add(m);
		}
		
		conn.close();
		return ordersListInfo;
	}
}
