package shop.dao;

import java.sql.*;
import java.util.*;

public class CategoryDAO {

	public static ArrayList<HashMap<String, String>> getCategoryList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String categoryListSql = "SELECT category, create_date createDate FROM category";
		PreparedStatement categoryListStmt = null;
		ResultSet categoryListRs = null;
		
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListRs = categoryListStmt.executeQuery();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<>();
		while(categoryListRs.next()){
			HashMap<String, String> m = new HashMap<>();
			m.put("category", categoryListRs.getString("category"));
			m.put("createDate", categoryListRs.getString("createDate"));
			
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
