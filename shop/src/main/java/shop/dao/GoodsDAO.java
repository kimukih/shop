package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	
	public static int getCategoryListCnt(String category, String keyword) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		String categoryListCntSql = "";
		PreparedStatement categoryListCntStmt = null;
		
		if(category.equals("")){
			// SELECT * FROM category
			categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ?";
			categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
			categoryListCntStmt.setString(1, "%"+keyword+"%");
			categoryListCntStmt.setString(2, "%"+keyword+"%");
			System.out.println("categoryListCntStmt : " + categoryListCntStmt);
		}else{
			// SELECT * FROM category WHERE category = ?
			categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?)";
			categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
			categoryListCntStmt.setString(1, category);
			categoryListCntStmt.setString(2, "%"+keyword+"%");
			categoryListCntStmt.setString(3, "%"+keyword+"%");
			System.out.println("categoryListCntStmt : " + categoryListCntStmt);
		}
		ResultSet categoryListCntRs =  categoryListCntStmt.executeQuery();
		
		int categoryListCnt = 0;
		if(categoryListCntRs.next()){
			categoryListCnt = categoryListCntRs.getInt("cnt");
		}
		
		conn.close();
		return categoryListCnt;
	}
	
	public static ArrayList<HashMap<String, Object>> getGoodsList(String category, String keyword, int startRow, int rowPerPage) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		
		String goodsListSql = "";
		PreparedStatement goodsListStmt = null;
		ResultSet goodsListRs = null;
		
		if(category.equals("")){
			// SELECT * FROM category
			goodsListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, goods_price goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ? LIMIT ?, ?";
			goodsListStmt = conn.prepareStatement(goodsListSql);
			goodsListStmt.setString(1, "%"+keyword+"%");
			goodsListStmt.setString(2, "%"+keyword+"%");
			goodsListStmt.setInt(3, startRow);
			goodsListStmt.setInt(4, rowPerPage);
		}else{
			// SELECT * FROM category WHERE category = ?
			goodsListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, goods_price goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?) LIMIT ?, ?";
			goodsListStmt = conn.prepareStatement(goodsListSql);
			goodsListStmt.setString(1, category);
			goodsListStmt.setString(2, "%"+keyword+"%");
			goodsListStmt.setString(3, "%"+keyword+"%");
			goodsListStmt.setInt(4, startRow);
			goodsListStmt.setInt(5, rowPerPage);
		}
		goodsListRs = goodsListStmt.executeQuery();
		
		while(goodsListRs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("goodsNo", goodsListRs.getInt("goodsNo"));
			m.put("category", goodsListRs.getString("category"));
			m.put("goodsTitle", goodsListRs.getString("goodsTitle"));
			m.put("empId", goodsListRs.getString("empId"));
			m.put("goodsPrice", goodsListRs.getInt("goodsPrice"));
			m.put("goodsAmount", goodsListRs.getInt("goodsAmount"));
			m.put("goodsImg", goodsListRs.getString("goodsImg"));
			goodsList.add(m);
		}
		
		conn.close();
		return goodsList;
	}
	
	public static ArrayList<HashMap<String, Object>> getCategoryCnt() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String categoryCntSql = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category";
		PreparedStatement categoryCntStmt = conn.prepareStatement(categoryCntSql);
		ResultSet categoryCntRs = categoryCntStmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryCntList = new ArrayList<HashMap<String, Object>>();
		
		while(categoryCntRs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", categoryCntRs.getString("category"));
			m.put("cnt", categoryCntRs.getInt("cnt"));
			categoryCntList.add(m);
		}
		conn.close();
		return categoryCntList;
	}
	
	public static int getCategoryListCnt(String category) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String categoryListCntSql = "";
		
		if(category == null){
			// SELECT * FROM category
			categoryListCntSql = "SELECT COUNT(*) cnt FROM goods";
		}else{
			// SELECT * FROM category WHERE category = ?
			categoryListCntSql = "SELECT COUNT(*) cnt FROM goods WHERE category = ?";
		}
		PreparedStatement categoryListCntStmt = null;
		ResultSet categoryListCntRs = null;
				
		categoryListCntStmt = conn.prepareStatement(categoryListCntSql);
		categoryListCntStmt.setString(1, category);
		System.out.println("categoryListCntStmt : " + categoryListCntStmt);
		
		categoryListCntRs = categoryListCntStmt.executeQuery();
		
		int categoryListCnt = 0;
		if(categoryListCntRs.next()){
			categoryListCnt = categoryListCntRs.getInt("cnt");
		}
		conn.close();
		return categoryListCnt;
	}
	
	public static ArrayList<HashMap<String, Object>> getGoodsBoardList(String category, int startRow, int rowPerPage) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> goodsBoardList = new ArrayList<>();
		
		String goodsBoardListSql = "";
		PreparedStatement goodsBoardListStmt = null;
		ResultSet goodsBoardListRs = null;
		
		if(category == null){
			// SELECT * FROM category
			goodsBoardListSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, emp_id empId, goods_price goodsPrice FROM goods LIMIT ?, ?";
			goodsBoardListStmt = conn.prepareStatement(goodsBoardListSql);
			goodsBoardListStmt.setInt(1, startRow);
			goodsBoardListStmt.setInt(2, rowPerPage);
			System.out.println("goodsBoardListStmt : " + goodsBoardListStmt);
		}else{
			// SELECT * FROM category WHERE category = ?
			goodsBoardListSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, emp_id empId, goods_price goodsPrice FROM goods WHERE category = ? LIMIT ?, ?";
			goodsBoardListStmt = conn.prepareStatement(goodsBoardListSql);
			goodsBoardListStmt.setString(1, category);
			goodsBoardListStmt.setInt(2, startRow);
			goodsBoardListStmt.setInt(3, rowPerPage);
			System.out.println("goodsBoardListStmt : " + goodsBoardListStmt);
		}
		goodsBoardListRs = goodsBoardListStmt.executeQuery();
		
		while(goodsBoardListRs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("goodsNo", goodsBoardListRs.getInt("goodsNo"));
			m.put("category", goodsBoardListRs.getString("category"));
			m.put("goodsTitle", goodsBoardListRs.getString("goodsTitle"));
			m.put("empId", goodsBoardListRs.getString("empId"));
			m.put("goodsPrice", goodsBoardListRs.getInt("goodsPrice"));
			goodsBoardList.add(m);
		}
		
		conn.close();
		return goodsBoardList;
	}
	
	public static ArrayList<HashMap<String, Object>> getGoodsOne(int goodsNo) throws Exception {
		
		ArrayList<HashMap<String, Object>> goodsOne = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String goodsOneSql = "SELECT category, emp_id empId, goods_img goodsImg, goods_no goodsNo, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount FROM goods WHERE goods_no = ?";
		PreparedStatement goodsOneStmt = null;
		ResultSet goodsOneRs = null;
			
		goodsOneStmt = conn.prepareStatement(goodsOneSql);
		goodsOneStmt.setInt(1, goodsNo);
		System.out.println("goodsNo : " + goodsNo);
			
		goodsOneRs = goodsOneStmt.executeQuery();
		
		while(goodsOneRs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", goodsOneRs.getString("category"));
			m.put("empId", goodsOneRs.getString("empId"));
			m.put("goodsImg", goodsOneRs.getString("goodsImg"));
			m.put("goodsNo", goodsOneRs.getInt("goodsNo"));
			m.put("goodsTitle", goodsOneRs.getString("goodsTitle"));
			m.put("goodsContent", goodsOneRs.getString("goodsContent"));
			m.put("goodsPrice", goodsOneRs.getInt("goodsPrice"));
			m.put("goodsAmount", goodsOneRs.getInt("goodsAmount"));
			goodsOne.add(m);
		}
		
		conn.close();
		return goodsOne;
	}
	
	public static ArrayList<HashMap<String, Object>> getGoodsBoardOne(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> goodsBoardOne = new ArrayList<>();
		
		String goodsBoardOneSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, emp_id empId, goods_img goodsImg FROM goods WHERE goods_no = ?";
		PreparedStatement goodsBoardOneStmt = null;
		ResultSet goodsBoardOneRs = null;
		goodsBoardOneStmt = conn.prepareStatement(goodsBoardOneSql);
		goodsBoardOneStmt.setInt(1, goodsNo);
		System.out.println("goodsBoardOneStmt : " + goodsBoardOneStmt);
		
		goodsBoardOneRs = goodsBoardOneStmt.executeQuery();
		
		while(goodsBoardOneRs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("goodsNo", goodsBoardOneRs.getInt("goodsNo"));
			m.put("category", goodsBoardOneRs.getString("category"));
			m.put("goodsTitle", goodsBoardOneRs.getString("goodsTitle"));
			m.put("goodsContent", goodsBoardOneRs.getString("goodsContent"));
			m.put("goodsPrice", goodsBoardOneRs.getInt("goodsPrice"));
			m.put("empId", goodsBoardOneRs.getString("empId"));
			m.put("goodsImg", goodsBoardOneRs.getString("goodsImg"));
			goodsBoardOne.add(m);
		}
		
		conn.close();
		return goodsBoardOne;
	}
	
	public static boolean addGoods(
			String category,
			String empId,
			String goodsTitle,
			String goodsContent,
			int goodsPrice,
			int goodsAmount,
			String fileName
			) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean addGoods;
		
		String addGoodsSql = "INSERT INTO goods(category, emp_id, goods_title, goods_content, goods_price, goods_amount, goods_img) VALUES(?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement addGoodsStmt = null;
		addGoodsStmt = conn.prepareStatement(addGoodsSql);
		addGoodsStmt.setString(1, category);
		addGoodsStmt.setString(2, empId);
		addGoodsStmt.setString(3, goodsTitle);
		addGoodsStmt.setString(4, goodsContent);
		addGoodsStmt.setInt(5, goodsPrice);
		addGoodsStmt.setInt(6, goodsAmount);
		addGoodsStmt.setString(7, fileName);
		
		System.out.println("addGoodsStmt : " + addGoodsStmt);
		
		int addGoodsRow = addGoodsStmt.executeUpdate();
		if(addGoodsRow == 1){
			addGoods = true;
		}else{
			addGoods = false;
		}
		
		conn.close();
		return addGoods;
	}
	
	public static boolean updateGoods(String goodsTitle, String fileName, String goodsContent, String goodsPrice, int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		boolean updateGoods;
		
		String updateGoodsSql = "UPDATE goods SET goods_title = ?, goods_img = ?, goods_price = ?, goods_content = ? WHERE goods_no = ?";
		PreparedStatement updateGoodsStmt = null;
		
		updateGoodsStmt = conn.prepareStatement(updateGoodsSql);
		updateGoodsStmt.setString(1, goodsTitle);
		updateGoodsStmt.setString(2, fileName);
		updateGoodsStmt.setString(3, goodsPrice);
		updateGoodsStmt.setString(4, goodsContent);
		updateGoodsStmt.setInt(5, goodsNo);
		System.out.println("updateGoodsStmt : " + updateGoodsStmt);
		
		int updateGoodsRow = updateGoodsStmt.executeUpdate();
		
		if(updateGoodsRow == 1) {
			updateGoods = true;
		}else{
			updateGoods = false;
		}
		
		conn.close();
		return updateGoods;
	}
	
	public static boolean deleteGoods(int goodsNo) throws Exception {
			
			Connection conn = DBHelper.getConnection();
			
			boolean deleteGoods;
			
			String deleteGoodsSql = "DELETE FROM goods WHERE goods_no = ?";
			PreparedStatement deleteGoodsStmt = null;
			deleteGoodsStmt = conn.prepareStatement(deleteGoodsSql);
			deleteGoodsStmt.setInt(1, goodsNo);
			System.out.println("deleteGoodsStmt : " + deleteGoodsStmt);
			
			int deleteGoodsRow = deleteGoodsStmt.executeUpdate();
			
			if(deleteGoodsRow == 1){
				deleteGoods = true;
			}else{
				deleteGoods = false;
			}
			
			conn.close();
			return deleteGoods;
	}
	
	public static void setGoodsAmountMinus(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE goods SET goods_amount = goods_amount-1 WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			return;
		}
		
		conn.close();
	}
	
	public static void setGoodsAmountPlus(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE goods SET goods_amount = goods_amount+1 WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			return;
		}
		
		conn.close();
	}
}
