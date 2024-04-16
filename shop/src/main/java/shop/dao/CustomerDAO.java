package shop.dao;

import java.sql.*;

public class CustomerDAO {
		
	public static ResultSet getCusName(String name) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String cusNameSql = "SELECT name FROM customer WHERE name = ?";
		PreparedStatement cusNameStmt = null;
		ResultSet cusNameRs = null;
		
		cusNameStmt = conn.prepareStatement(cusNameSql);
		cusNameStmt.setString(1, name);
		System.out.println("cusNameStmt : " + cusNameStmt);
		
		cusNameRs = cusNameStmt.executeQuery();
		
		conn.close();
		return cusNameRs;
	}
	
	public static ResultSet getCustomerOne(String mail) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String customerOneSql = "SELECT mail, name, birth, gender, update_date updateDate, create_date createDate FROM customer WHERE mail = ?";
		PreparedStatement customerOneStmt = null;
		ResultSet customerOneRs = null;
		
		customerOneStmt = conn.prepareStatement(customerOneSql);
		customerOneStmt.setString(1, mail);
		System.out.println("customerOneStmt : " + customerOneStmt);
		
		customerOneRs = customerOneStmt.executeQuery();
		
		conn.close();
		return customerOneRs;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
