package shop.dao;

import java.sql.*;
import java.util.*;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {
	
	// 관리자 회원가입 DAO
		public static boolean addEmp(String empId, String empPw, String empName, String empJob, String hireDate) throws Exception {
			
			Connection conn = DBHelper.getConnection();
			
			boolean addEmp;
			
			String addEmpSql = "INSERT INTO emp(emp_id, emp_pw, emp_name, emp_job, hire_date) VALUES(?, PASSWORD(?), ?, ?, ?)";
			PreparedStatement addEmpStmt = null;
			
			addEmpStmt = conn.prepareStatement(addEmpSql);
			addEmpStmt.setString(1, empId);
			addEmpStmt.setString(2, empPw);
			addEmpStmt.setString(3, empName);
			addEmpStmt.setString(4, empJob);
			addEmpStmt.setString(5, hireDate);
			
			int addEmpRow = addEmpStmt.executeUpdate();
			
			if(addEmpRow == 1){
				addEmp = true;
			}else{
				addEmp = false;
			}
			
			conn.close();
			return addEmp;
		}
		
	// 회원가입 ID 충복체크 DAO
	public static boolean checkEmpId(String empId) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		boolean checkEmpId;
		
		String checkEmpIdSql = "SELECT emp_id empId FROM emp WHERE emp_id = ?";
		PreparedStatement checkEmpIdStmt = null;
		ResultSet checkEmpIdRs = null;
		
		checkEmpIdStmt = conn.prepareStatement(checkEmpIdSql);
		checkEmpIdStmt.setString(1, empId);
		
		checkEmpIdRs = checkEmpIdStmt.executeQuery();
		if(checkEmpIdRs.next()) {
			checkEmpId = true;
		}else {
			checkEmpId = false;
		}
		
		conn.close();
		return checkEmpId;
	}
	
	// 관리자 정보 중 이름을 가져오는 DAO
	public static HashMap<String, Object> getEmpName(String empName) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		HashMap<String, Object> getEmpName = new HashMap<>();
		
		String empNameSql = "SELECT emp_name empName FROM emp WHERE emp_name = ?";
		PreparedStatement empNameStmt = null;
		ResultSet empNameRs = null;
		
		empNameStmt = conn.prepareStatement(empNameSql);
		empNameStmt.setString(1, empName);
		System.out.println("cusNameStmt : " + empNameStmt);
		
		empNameRs = empNameStmt.executeQuery();
		
		if(empNameRs.next()) {
			getEmpName.put("empName", empNameRs.getString("empName"));
		}
		
		conn.close();
		return getEmpName;
	}
	
	// 관리자 계정의 비밀번호를 체크하는 DAO
	public static boolean empPwCheck(String empId, String empPw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean pwCheck;
		
		String sql = "SELECT emp_pw FROM emp WHERE emp_id = ? AND emp_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2,empPw);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			pwCheck = true;
		}else {
			pwCheck = false;
		}
		
		conn.close();
		return pwCheck;
	}
	
	// 관리자 계정 비밀번호를 변경하는 DAO
	public static boolean modifyEpmPw(String empId, String empPw, String newEmpPw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean modifyEmpPw;
		
		String sql = "UPDATE emp SET emp_pw = PASSWORD(?) WHERE emp_id = ? AND emp_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newEmpPw);
		stmt.setString(2, empId);
		stmt.setString(3, empPw);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			modifyEmpPw = true;
		}else{
			modifyEmpPw = false;
		}
		
		conn.close();
		return modifyEmpPw;
	}
	
	// 관리자 계정을 추가하는 DAO
	public static int insertEmp(
			String empId,
			String empPw,
			String empName,
			String empJob,
			String hireDate
			) throws Exception {
		int row = 0;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		/*
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		*/
		String addEmpSql = "INSERT INTO emp(emp_id, emp_pw, emp_name, emp_job, hire_date) VALUES(?, PASSWORD(?), ?, ?, ?)";
		PreparedStatement addEmpStmt = conn.prepareStatement(addEmpSql);
		addEmpStmt.setString(1, empId);
		addEmpStmt.setString(2, empPw);
		addEmpStmt.setString(3, empName);
		addEmpStmt.setString(4, empJob);
		addEmpStmt.setString(5, hireDate);
		
		row = addEmpStmt.executeUpdate();
		
		conn.close();
		return row;
	}

	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// String empId, String empPw : 로그인 폼에서 사용자가 입력한 ID/PW
	
	// 호출코드 : HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	// 관리자 로그인 DAO
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception{
		
		// 세션으로 사용될 HashMap변수 resultMap
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		
		// 로그인 시도한 정보와 일치하는 DB 계정정보 찾기
		String loginSql = "SELECT emp_id empId, emp_name empName, grade, emp_pw empPw FROM emp WHERE active = 'ON' AND emp_id = ? AND emp_pw = PASSWORD(?)";
		PreparedStatement loginStmt = conn.prepareStatement(loginSql);
		loginStmt.setString(1, empId);
		loginStmt.setString(2, empPw);
		System.out.println("loginStmt : " + loginStmt);
		
		ResultSet loginRs = loginStmt.executeQuery();
		
		if(loginRs.next()) {	// 입력한 로그인 정보가 DB 정보와 일치 하는 경우 ( -> 로그인성공)
			// 세션에 저장 할 HashMap 변수인 resultMap에 필요한 DB 정보를 저장
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", loginRs.getString("empId"));
			resultMap.put("empName", loginRs.getString("empName"));
			resultMap.put("grade", loginRs.getInt("grade"));
		}
		conn.close();
		return resultMap;
	}
	// 관리자 리스트 페이징을 위해 관리자 목록의 총 개수를 가져오는 DAO
	public static int getEmpCnt() throws Exception {
			
			Connection conn = DBHelper.getConnection();
			
			String empCntSql = "SELECT COUNT(*) cnt FROM emp";
			PreparedStatement empCntStmt = conn.prepareStatement(empCntSql);
			ResultSet empCntRs = empCntStmt.executeQuery();
			
			int empCnt = 0;
			if(empCntRs.next()){
				empCnt = empCntRs.getInt("cnt");
			}
			conn.close();
			return empCnt;
		}
	
	// 관리자 리스트의 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getEmpList(
		int startRow,
		int rowPerPage
		) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String empListSql = "SELECT emp_id empId, emp_name empName, grade, emp_job empJob, hire_date hireDate, active FROM emp ORDER BY active, hire_date DESC LIMIT ?, ?";
		PreparedStatement empListStmt = conn.prepareStatement(empListSql);
		empListStmt.setInt(1, startRow);
		empListStmt.setInt(2, rowPerPage);

		ResultSet empListRs = null;
		System.out.println("empListStmt : " + empListStmt);
		
		empListRs = empListStmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
		
		while(empListRs.next()){
			HashMap<String, Object>m = new HashMap<String, Object>();
			m.put("empId", empListRs.getString("empId"));
			m.put("empName", empListRs.getString("empName"));
			m.put("empJob", empListRs.getString("empJob"));
			m.put("hireDate", empListRs.getString("hireDate"));
			m.put("active", empListRs.getString("active"));
			m.put("grade", empListRs.getInt("grade"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	// 관리자 활동 상태를 변경하는 DAO
	public static boolean modifyEmpActive(String empId, String active) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean modifyEmpActive;
		
		String activeSwitchSql = null;
		PreparedStatement activeSwitchStmt = null;
		
		if(active.equals("OFF")){
			activeSwitchSql = "UPDATE emp SET active = 'ON' WHERE emp_id = ?";
			activeSwitchStmt = conn.prepareStatement(activeSwitchSql);
			activeSwitchStmt.setString(1, empId);
		}else{
			activeSwitchSql = "UPDATE emp SET active = 'OFF' WHERE emp_id = ?";
			activeSwitchStmt = conn.prepareStatement(activeSwitchSql);
			activeSwitchStmt.setString(1, empId);
		}
		System.out.println("activeSwitchStmt : " + activeSwitchStmt);
		
		int modifyActiveRow = activeSwitchStmt.executeUpdate();
		
		if(modifyActiveRow == 1){
			modifyEmpActive = true;
		}else {
			modifyEmpActive = false;
		}
		
		conn.close();
		return modifyEmpActive;
	}
	
	// 관리자 상세 정보를 가져오는 DAO
	public static ArrayList<HashMap<String, Object>> getEmpListOne(String empId) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> empListOne = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT emp_id empId, emp_name empName, emp_job empJob, grade, create_date createDate, update_date updateDate FROM emp WHERE emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("grade", rs.getInt("grade"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			empListOne.add(m);
		}
		
		conn.close();
		return empListOne;
	}
	
	// 관리자 상세 정보를 변경하는 DAO
	public static boolean updateEmpOne(String empName, String empJob, int grade, String empId, String empPw) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean updateEmpOne;
		
		String sql = "UPDATE emp SET emp_name = ?, emp_job = ?, grade = ? WHERE emp_id = ? AND emp_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empName);
		stmt.setString(2, empJob);
		stmt.setInt(3, grade);
		stmt.setString(4, empId);
		stmt.setString(5, empPw);
		
		int row = stmt.executeUpdate();
		if(row == 1) {	// 정보 업데이트 성공
			updateEmpOne = true;
		}else{	// 정보 업데이트 실패
			updateEmpOne = false;
		}
		
		conn.close();
		return updateEmpOne;
	}
	
}
