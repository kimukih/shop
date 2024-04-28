package shop.dao;

import java.sql.*;
import java.util.*;

public class CustomerDAO {
	
	// 회원 비밀번호를 변경하는 DAO
	public static boolean modifyCustomerPw(String mail, String pw, String newPw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean modifyCustomerPw;
		
		String sql = "UPDATE customer SET pw = PASSWORD(?) WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, pw);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			modifyCustomerPw = true;
		}else {
			modifyCustomerPw = false;
		}
		
		conn.close();
		return modifyCustomerPw;
	}
	
	// 회원 비밀번호를 체크하는 DAO
	public static boolean pwCheck(String mail, String pw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean pwCheck;
		
		String sql = "SELECT pw FROM customer WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			pwCheck = true;
		}else {
			pwCheck = false;
		}
		
		conn.close();
		return pwCheck;
	}
	
	// 회원 정보 중 이름을 가져오는 DAO
	public static HashMap<String, Object> getCusName(String name) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		HashMap<String, Object> cusName = new HashMap<>();
		
		String cusNameSql = "SELECT name FROM customer WHERE name = ?";
		PreparedStatement cusNameStmt = null;
		ResultSet cusNameRs = null;
		
		cusNameStmt = conn.prepareStatement(cusNameSql);
		cusNameStmt.setString(1, name);
		System.out.println("cusNameStmt : " + cusNameStmt);
		
		cusNameRs = cusNameStmt.executeQuery();
		
		if(cusNameRs.next()) {
			cusName.put("name", cusNameRs.getString("name"));
		}
		
		conn.close();
		return cusName;
	}
	
	// 회원 상세 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getCustomerOne(String mail) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> customerOne = new ArrayList<HashMap<String, Object>>();
		
		String customerOneSql = "SELECT mail, name, birth, gender, update_date updateDate, create_date createDate FROM customer WHERE mail = ?";
		PreparedStatement customerOneStmt = null;
		ResultSet customerOneRs = null;
		
		customerOneStmt = conn.prepareStatement(customerOneSql);
		customerOneStmt.setString(1, mail);
		System.out.println("customerOneStmt : " + customerOneStmt);
		
		customerOneRs = customerOneStmt.executeQuery();
		
		while(customerOneRs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("mail", customerOneRs.getString("mail"));
			m.put("name", customerOneRs.getString("name"));
			m.put("birth", customerOneRs.getString("birth"));
			m.put("gender", customerOneRs.getString("gender"));
			m.put("updateDate", customerOneRs.getString("updateDate"));
			m.put("createDate", customerOneRs.getString("createDate"));
			customerOne.add(m);
		}
		
		conn.close();
		return customerOne;
	}
	
	// 회원의 개인 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getCustomerInfo(String mail) throws Exception {
			
			Connection conn = DBHelper.getConnection();
			
			ArrayList<HashMap<String, Object>> customerInfo = new ArrayList<>();
			
			String customerInfoSql = "SELECT mail, name, birth, gender FROM customer WHERE mail = ?";
			PreparedStatement customerInfoStmt = null;
			ResultSet customerInfoRs = null;
			
			customerInfoStmt = conn.prepareStatement(customerInfoSql);
			customerInfoStmt.setString(1, mail);
			System.out.println("customerInfoStmt : " + customerInfoStmt);
			
			customerInfoRs = customerInfoStmt.executeQuery();
			
			while(customerInfoRs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("mail", customerInfoRs.getString("mail"));
				m.put("name", customerInfoRs.getString("name"));
				m.put("birth", customerInfoRs.getString("birth"));
				m.put("gender", customerInfoRs.getString("gender"));
				customerInfo.add(m);
			}
			
			conn.close();
			return customerInfo;
	}
	
	// 회원 로그인 DAO
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
	
	// 회원 정보를 수정하는 DAO
	public static boolean updateCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean updateCustomer;
		
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
		
		if(updateCustomerRow == 1) {
			updateCustomer = true;
		}else{
			updateCustomer = false;
		}
		
		conn.close();
		return updateCustomer;
	}
	
	// 회원가입 DAO
	public static boolean addCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean addCustomer;
		
		String addCustomerSql = "INSERT INTO customer(mail, pw, name, birth, gender) VALUES(?, PASSWORD(?), ?, ?, ?)";
		PreparedStatement addCustomerStmt = null;
		
		addCustomerStmt = conn.prepareStatement(addCustomerSql);
		addCustomerStmt.setString(1, mail);
		addCustomerStmt.setString(2, pw);
		addCustomerStmt.setString(3, name);
		addCustomerStmt.setString(4, birth);
		addCustomerStmt.setString(5, gender);
		
		int addCustomerRow = addCustomerStmt.executeUpdate();
		
		if(addCustomerRow == 1){
			addCustomer = true;
		}else{
			addCustomer = false;
		}
		
		conn.close();
		return addCustomer;
	}
	
	// 회원가입 ID 충복체크 DAO
	public static boolean checkId(String mail) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		boolean checkId;
		
		String checkIdSql = "SELECT mail FROM customer WHERE mail = ?";
		PreparedStatement checkIdStmt = null;
		ResultSet checkIdRs = null;
		
		checkIdStmt = conn.prepareStatement(checkIdSql);
		checkIdStmt.setString(1, mail);
		
		checkIdRs = checkIdStmt.executeQuery();
		if(checkIdRs.next()) {
			checkId = true;
		}else {
			checkId = false;
		}
		
		conn.close();
		return checkId;
	}
	
	// 회원탈퇴 DAO
	public static boolean deleteCustomer(String mail, String pw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean deleteCustomer;
		
		String deleteCustomerSql = "DELETE FROM customer WHERE mail = ? AND pw = PASSWORD(?)";
		PreparedStatement deleteCustomerStmt = null;
		
		deleteCustomerStmt = conn.prepareStatement(deleteCustomerSql);
		deleteCustomerStmt.setString(1, mail);
		deleteCustomerStmt.setString(2, pw);
		System.out.println("deleteCustomerStmt : " + deleteCustomerStmt);
		
		int deleteCustomerRow = deleteCustomerStmt.executeUpdate();
		
		if(deleteCustomerRow == 1){
			deleteCustomer = true;
		}else{
			deleteCustomer = false;
		}
		
		conn.close();
		return deleteCustomer;
	}

}
