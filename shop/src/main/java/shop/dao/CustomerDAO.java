package shop.dao;

import java.sql.*;
import java.util.*;

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
	
	public static ResultSet getUpdateCustomerInfo(String mail) throws Exception {
			
			Connection conn = DBHelper.getConnection();
			
			String updateCustomerInfoSql = "SELECT mail, name, birth, gender FROM customer WHERE mail = ?";
			PreparedStatement updateCustomerInfoStmt = null;
			ResultSet updateCustomerInfoRs = null;
			
			updateCustomerInfoStmt = conn.prepareStatement(updateCustomerInfoSql);
			updateCustomerInfoStmt.setString(1, mail);
			System.out.println("updateCustomerInfoStmt : " + updateCustomerInfoStmt);
			
			updateCustomerInfoRs = updateCustomerInfoStmt.executeQuery();
			
			conn.close();
			return updateCustomerInfoRs;
	}
	
	public static HashMap<String, String> customerLogin(String mail, String pw) throws Exception{
		
		HashMap<String, String> customerLogin = null;
		
		Connection conn = DBHelper.getConnection();
		
		String loginSql = "SELECT mail, pw, name, birth, gender FROM customer WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement loginStmt = null;
		ResultSet loginRs = null;
		
		// 파라미터로 받은 이메일과 비밀번호에 대응하는 DB정보를 불러오기
		loginStmt = conn.prepareStatement(loginSql);
		loginStmt.setString(1, mail);
		loginStmt.setString(2, pw);
		
		loginRs = loginStmt.executeQuery();
		
		// true인 경우 DB정보와 일치하는 로그인정보가 있다는 것 --> 로그인 성공
		
		if(loginRs.next()){
			// 로그인 성공 시 HashMap 타입의 변수 loginCustomer 안에
			// 로그인 정보에 해당하는 DB안의 mail, name 값을 저장
			// 2개 이상의 정보를 session으로 다루기 위해 HashMap 사용
			customerLogin = new HashMap<String, String>();
			customerLogin.put("mail", loginRs.getString("mail"));
			customerLogin.put("name", loginRs.getString("name"));
		}
		
		conn.close();
		return customerLogin;
	}
	
	public static int updateCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String updateCustomerSql = "UPDATE customer SET name = ?, birth = ?, gender = ?, update_date = NOW() WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement updateCustomerStmt = null;
		
		updateCustomerStmt = conn.prepareStatement(updateCustomerSql);
		updateCustomerStmt.setString(1, name);
		updateCustomerStmt.setString(2, birth);
		updateCustomerStmt.setString(3, gender);
		updateCustomerStmt.setString(4, mail);
		updateCustomerStmt.setString(5, pw);
		System.out.println("updateCustomerStmt : " + updateCustomerStmt);
		
		int updateCustomerRow = updateCustomerStmt.executeUpdate();
		
		conn.close();
		return updateCustomerRow;
	}

}
