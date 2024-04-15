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
	
	public static ResultSet getCategoryListRs(String category, String keyword, int startRow, int rowPerPage) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String categoryListSql = "";
		PreparedStatement categoryListStmt = null;
		ResultSet categoryListRs = null;
		
		if(category.equals("")){
			// SELECT * FROM category
			categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE goods_title LIKE ? OR goods_content LIKE ? LIMIT ?, ?";
			categoryListStmt = conn.prepareStatement(categoryListSql);
			categoryListStmt.setString(1, "%"+keyword+"%");
			categoryListStmt.setString(2, "%"+keyword+"%");
			categoryListStmt.setInt(3, startRow);
			categoryListStmt.setInt(4, rowPerPage);
		}else{
			// SELECT * FROM category WHERE category = ?
			categoryListSql = "SELECT goods_no goodsNo, category, left(goods_title, 12) goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice, goods_amount goodsAmount, goods_img goodsImg FROM goods WHERE category = ? AND (goods_title LIKE ? OR goods_content LIKE ?) LIMIT ?, ?";
			categoryListStmt = conn.prepareStatement(categoryListSql);
			categoryListStmt.setString(1, category);
			categoryListStmt.setString(2, "%"+keyword+"%");
			categoryListStmt.setString(3, "%"+keyword+"%");
			categoryListStmt.setInt(4, startRow);
			categoryListStmt.setInt(5, rowPerPage);
		}
		categoryListRs = categoryListStmt.executeQuery();
		
		conn.close();
		return categoryListRs;
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
	
	public static ResultSet getGoodsBoardListRs(String category, int startRow, int rowPerPage) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String categoryListSql = "";
		PreparedStatement categoryListStmt = null;
		ResultSet categoryListRs = null;
		
		if(category == null){
			// SELECT * FROM category
			categoryListSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice FROM goods LIMIT ?, ?";
			categoryListStmt = conn.prepareStatement(categoryListSql);
			categoryListStmt.setInt(1, startRow);
			categoryListStmt.setInt(2, rowPerPage);
			System.out.println("categoryListStmt : " + categoryListStmt);
		}else{
			// SELECT * FROM category WHERE category = ?
			categoryListSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, emp_id empId, FORMAT(goods_price, 0) goodsPrice FROM goods WHERE category = ? LIMIT ?, ?";
			categoryListStmt = conn.prepareStatement(categoryListSql);
			categoryListStmt.setString(1, category);
			categoryListStmt.setInt(2, startRow);
			categoryListStmt.setInt(3, rowPerPage);
			System.out.println("categoryListStmt : " + categoryListStmt);
		}
		categoryListRs = categoryListStmt.executeQuery();
		
		conn.close();
		return categoryListRs;
	}
	
	public static ResultSet getGoodsOneRs(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String goodsOneSql = "SELECT emp_id empId, goods_img goodsImg, goods_no goodsNo, goods_title goodsTitle, goods_content goodsContent, FORMAT(goods_price, 0) goodsPrice, goods_amount goodsAmount FROM goods WHERE goods_no = ?";
		PreparedStatement goodsOneStmt = null;
		ResultSet goodsOneRs = null;
			
		goodsOneStmt = conn.prepareStatement(goodsOneSql);
		goodsOneStmt.setInt(1, goodsNo);
		System.out.println("goodsNo : " + goodsNo);
			
		goodsOneRs = goodsOneStmt.executeQuery();
		
		conn.close();
		return goodsOneRs;
	}
	
	public static ResultSet getGoodsBoardOneRs(int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String goodsBoardOneSql = "SELECT goods_no goodsNo, category, goods_title goodsTitle, goods_content goodsContent, FORMAT(goods_price, 0) goodsPrice, emp_id empId, goods_img goodsImg FROM goods WHERE goods_no = ?";
		PreparedStatement goodsBoardOneStmt = null;
		ResultSet goodsBoardOneRs = null;
		goodsBoardOneStmt = conn.prepareStatement(goodsBoardOneSql);
		goodsBoardOneStmt.setInt(1, goodsNo);
		System.out.println("goodsBoardOneStmt : " + goodsBoardOneStmt);
		
		goodsBoardOneRs = goodsBoardOneStmt.executeQuery();
		
		conn.close();
		return goodsBoardOneRs;
	}
	
	public static int getAddGoods(
			String category,
			String empId,
			String goodsTitle,
			String goodsContent,
			int goodsPrice,
			int goodsAmount,
			String fileName
			) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
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
		
		conn.close();
		return addGoodsRow;
	}
	
	public static int updateGoods(String goodsTitle, String goodsContent, String goodsPrice, int goodsNo) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String updateGoodsSql = "UPDATE goods SET goods_title = ?, goods_price = ?, goods_content = ? WHERE goods_no = ?";
		PreparedStatement updateGoodsStmt = null;
		
		updateGoodsStmt = conn.prepareStatement(updateGoodsSql);
		updateGoodsStmt.setString(1, goodsTitle);
		updateGoodsStmt.setString(2, goodsPrice);
		updateGoodsStmt.setString(3, goodsContent);
		updateGoodsStmt.setInt(4, goodsNo);
		System.out.println("updateGoodsStmt : " + updateGoodsStmt);
		
		int updateGoodsRow = updateGoodsStmt.executeUpdate();
		
		conn.close();
		return updateGoodsRow;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
