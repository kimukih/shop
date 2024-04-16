package shop.dao;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

public class DBHelper {
	public static Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 로컬 PC의 Propetries파일 읽어오기
		// 외부파일을 메모리로 들고올 때 사용
		// 메모장에 적인 id와 pw를 가져와서 실행하는 것이기 때문에 다른 PC에서 DB에 접근하는 것에 대한 보안이 높아짐
		FileReader fr = new FileReader("d:\\dev\\auth\\mariadb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		// System.out.println(prop.getProperty("id"));
		// System.out.println(prop.getProperty("pw"));
		
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
		return conn;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}