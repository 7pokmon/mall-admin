package gdu.mall.dao;

import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;

public class CategoryDao {
	// 목차
	public static ArrayList<String> categoryNameList() throws Exception {
		// 1. sql
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight desc";
		// 2. 리턴값 초기화
		ArrayList<String> list = new ArrayList<>();
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<-- 목록stmt");

		// 입력값 저장
		while (rs.next()) {
			// 초기화
			String st = rs.getString("categoryName");
			list.add(st);
		}
		// 4. 리턴
		return list;
	}

	// 추가
	public static int insertCategory(String categoryName, int categoryWeight) throws Exception {
		// 1. sql
		String sql = "INSERT INTO category(category_name,category_weight,category_date) VALUES(?,?,NOW())";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, categoryWeight);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- 추가stmt");
		// 4. 리턴
		return rowCnt;
	}

	// 중복확인
	public static String selectCategoryName(String categoryName) throws Exception {
		// 1. sql
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		// 2. 리턴값 초기화
		String returnCategoryName = null;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<--  중복확인stmt");

		if (rs.next()) {
			returnCategoryName = rs.getString("categoryName");
		}
		// 4. 리턴
		return returnCategoryName;
	}

	// 수정
	public static int updateCategoryWeight(String categoryName, int categoryWeight) throws Exception {
		// 1. sql
		String sql = "UPDATE category SET category_weight=? WHERE category_name=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setString(2, categoryName);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- 수정stmt");
		// 4. 리턴
		return rowCnt;
	}

	// 삭제
	public static int deleteCategory(String categoryName) throws Exception {
		// 1. sql
		String sql = "DELETE FROM category WHERE category_name =?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- 삭제stmt");
		// 4. 리턴
		return rowCnt;
	}

	// 목록
	public static ArrayList<Category> categoryList() throws Exception {
		// 1. sql
		String sql = "SELECT category_name categoryName, category_weight categoryWeight, category_date categoryDate FROM category";
		// 2. 리턴값 초기화
		ArrayList<Category> list = new ArrayList<>();
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<-- 목록stmt");

		// 입력값 저장
		while (rs.next()) {
			// 초기화
			Category ct = new Category();
			ct.setCategoryName(rs.getString("categoryName"));
			ct.setCategoryWeight(rs.getInt("categoryWeight"));
			ct.setCategoryDate(rs.getString("categoryDate"));
			list.add(ct);
		}
		// 4. 리턴
		return list;
	}
}
