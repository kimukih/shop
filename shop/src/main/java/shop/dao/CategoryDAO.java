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
	
	public static ArrayList<HashMap<String, Object>> getCategoryCnt() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String categoryCntSql = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category";
		PreparedStatement categoryCntStmt = null;
		ResultSet categoryCntRs = null;
		
		categoryCntStmt = conn.prepareStatement(categoryCntSql);
		categoryCntRs = categoryCntStmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryCnt = new ArrayList<HashMap<String, Object>>();
		
		while(categoryCntRs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", categoryCntRs.getString("category"));
			m.put("cnt", categoryCntRs.getInt("cnt"));
			categoryCnt.add(m);
		}
		conn.close();
		return categoryCnt;
	}
	
	public static ArrayList<String> getCategoryAll() throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<String> categoryAll = new ArrayList<>();
		
		String categoryAllSql = "SELECT category FROM category";
		PreparedStatement categoryAllStmt = conn.prepareStatement(categoryAllSql);
		ResultSet categoryAllRs = categoryAllStmt.executeQuery();
		
		while(categoryAllRs.next()) {
			categoryAll.add(categoryAllRs.getString("category"));
		}
		
		conn.close();
		return categoryAll;
	}
	
	public static ArrayList<String> getAddGoodsCategoryList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String categoryListSql = "SELECT category FROM category";
		PreparedStatement categoryListStmt = null;
		ResultSet categoryListRs = null;
		
		categoryListStmt = conn.prepareStatement(categoryListSql);
		categoryListRs = categoryListStmt.executeQuery();
		
		ArrayList<String> categoryList = new ArrayList<String>();
		
		while(categoryListRs.next()){
			categoryList.add(categoryListRs.getString("category"));
		}
		conn.close();
		return categoryList;
	}
	
	public static boolean addCategory(String category) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean addCategory;
		
		String addCategorySql = "INSERT INTO category(category) VALUES(?)";
		PreparedStatement addCategoryStmt = null;
		
		addCategoryStmt = conn.prepareStatement(addCategorySql);
		addCategoryStmt.setString(1, category);
		System.out.println("addCategoryStmt : " + addCategoryStmt);
		
		int addCategoryRow = addCategoryStmt.executeUpdate();
		
		if(addCategoryRow == 1){
			addCategory = true;
		}else{
			addCategory = false;
		}
		
		conn.close();
		return addCategory;
	}
	
	public static boolean deleteCategory(String category) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean deleteCategory;
		
		String deleteCategorySql = "DELETE FROM category WHERE category = ?";
		PreparedStatement deleteCategoryStmt = null;
		
		deleteCategoryStmt = conn.prepareStatement(deleteCategorySql);
		deleteCategoryStmt.setString(1, category);
		System.out.println("deleteCategoryStmt : " + deleteCategoryStmt);
		
		int deleteCategoryRow = deleteCategoryStmt.executeUpdate();
		
		if(deleteCategoryRow == 1){
			deleteCategory = true;
		}else{
			deleteCategory = false;
		}
		
		conn.close();
		return deleteCategory;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
