package shop.dao;

import java.sql.*;
import java.util.*;

public class OrdersDAO {
	
	// ordersInfoList의 총 개수를 가져오는 DAO
	public static int getTotalOrdersInfo(String mail) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		int totalOrdersInfo = 0;
		
		String sql = "SELECT COUNT(*) cnt FROM orders WHERE mail = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			totalOrdersInfo = rs.getInt("cnt");
		}
		
		conn.close();
		return totalOrdersInfo;
	}

	// 상품 주문을 추가하는 DAO
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
	
	// 상품 배송 현황 목록을 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getOrdersStateList(int startRow, int rowPerPage) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> ordersStateList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, goods_no goodsNo, goods_title goodsTitle, orders_date ordersDate, state FROM orders LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("ordersDate", rs.getString("ordersDate"));
			m.put("state", rs.getString("state"));
			ordersStateList.add(m);
		}
		
		conn.close();
		return ordersStateList;
	}
	
	// 주문 목록 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getOrdersListInfo(String mail, int startRow, int rowPerPage) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> ordersListInfo = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, goods_no goodsNo, goods_title goodsTitle, address_name addressName, address, phone_number phoneNumber, state FROM orders WHERE mail= ? LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
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
	
	// 주문 목록 상품들의 상세 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getOrdersInfoOne(String mail, int ordersNo) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> ordersInfoOne = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT orders_no ordersNo, goods_no goodsNo, goods_title goodsTitle, total_amount totalAmount, total_price totalPrice, orders_date ordersDate, state FROM orders WHERE mail = ? AND orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, ordersNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("ordersDate", rs.getString("ordersDate"));
			m.put("state", rs.getString("state"));
			ordersInfoOne.add(m);
		}
		
		conn.close();
		return ordersInfoOne;
	}
	
	// 상품 주문을 삭제하는 DAO
	public static boolean deleteOrders(String mail, int ordersNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean deleteOrders;
		
		String sql = "DELETE FROM orders WHERE mail = ? AND orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, ordersNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			deleteOrders = true;
		}else {
			deleteOrders = false;
		}
		
		conn.close();
		return deleteOrders;
	}
	
	// 상품 배송 현황을 변경하는 DAO
	public static boolean modifyOrdersState(int ordersNo, String state) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean modifyOrdersState;
		
		String sql = null;
		PreparedStatement stmt = null;
		
		if(state.equals("배송중")) {
			sql = "UPDATE orders SET state = ? WHERE orders_no = ? AND state = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, state);
			stmt.setInt(2, ordersNo);
			stmt.setString(3, "결제완료");
		}else if(state.equals("배송완료")) {
			sql = "UPDATE orders SET state = ? WHERE orders_no = ? AND state = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, state);
			stmt.setInt(2, ordersNo);
			stmt.setString(3, "배송중");
		}
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			modifyOrdersState = true;
		}else {
			modifyOrdersState = false;
		}
	
		conn.close();
		return modifyOrdersState;
	}
	
	// 주문 목록 페이징을 위해 주문상품의 총 개수를 가져오는 DAO
	public static int getTotalOrders() throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		int totalOrders = 0;
		
		String sql = "SELECT count(*) cnt FROM orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			totalOrders = rs.getInt("cnt");
		}
		
		conn.close();
		return totalOrders;
	}
	
}
