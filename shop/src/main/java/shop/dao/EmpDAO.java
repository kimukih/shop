package shop.dao;

import java.sql.*;
import java.util.*;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {
	
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
		String addEmpSql = "INSERT INTO emp(emp_id, emp_pw, emp_name, emp_job, hire_date) VALUES(?, ?, ?, ?, ?)";
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
			resultMap.put("empid", loginRs.getString("empId"));
			resultMap.put("empName", loginRs.getString("empName"));
			resultMap.put("grade", loginRs.getInt("grade"));
		}
		conn.close();
		return resultMap;
	}
	// empList - empCnt 가져오기
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
	
	public static int modifyEmpActive(String empId, String active) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
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
		
		conn.close();
		return modifyActiveRow;
	}
	
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

}
