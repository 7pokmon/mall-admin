package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;

public class EbookDao {
	
	public static int linkEbookISBN(String ebookISBN) throws Exception {
		int rowCnt = 0;
		
		return rowCnt;
	}
	
	// ebookOne 수정
	public static int updateEbookOne(Ebook ebook) throws Exception {
		// 1. sql
		String sql = "UPDATE ebook SET category_name=?, ebook_title=?, ebook_author=?, ebook_company=?, ebook_price=?, ebook_page_count=? WHERE ebook_isbn=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getCategoryName());
		stmt.setString(2, ebook.getEbookTitle());
		stmt.setString(3, ebook.getEbookAuthor());
		stmt.setString(4, ebook.getEbookCompany());
		stmt.setInt(5, ebook.getEbookPrice());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setString(7, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println(stmt + "<-- ebookOne수정stmt");
		// 4. 리턴
		return rowCnt;
	}
	
	// 삭제
	public static int deleteEbookOne(Ebook ebook) throws Exception {
		// 1. sql
		String sql ="DELETE FROM ebook WHERE ebook_isbn=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println(stmt + "<-- 삭제Onestmt");
		// 4. 리턴
		return rowCnt;
	}
	
	// Summary수정
	public static int updateEbookSummary(Ebook ebook) throws Exception {
		// 1. sql
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println(stmt + "<-- Summary수정stmt");
		
		// 4. 리턴
		return rowCnt;
	}
	
	// State수정
	public static int updateEbookState(Ebook ebook) throws Exception {
		// 1. sql
		String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookState());
		stmt.setString(2, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		//디버깅
		System.out.println(stmt + "<-- State수정stmt");
		// 4. 리턴
		return rowCnt;
	}
	
	// Img수정
	public static int updateEbookImg(Ebook ebook) throws Exception {
		// 1. sql
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- Img수정stmt");
		// 4.리턴
		return rowCnt;
	}
	
	// 중복검사
	public static String selectEbookISBN(String ebookISBN) throws Exception {
		// 1. sql
		String sql ="SELECT ebook_isbn ebookISBN FROM ebook WHERE ebook_isbn = ?";
		// 2. 리턴값 초기화
		String returnEbookISBN = null;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		ResultSet rs = stmt.executeQuery();
		//디버깅
		System.out.println(stmt + "<-- 중복검사stmt");
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebookISBN");
		}
		// 4.리턴
		return returnEbookISBN;
	}
	
	// 상세보기
	public static Ebook selectEbookOne(String ebookISBN) throws Exception {
		// 1. sql
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_summary ebookSummary, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		// 2. 리턴값 초기화
		Ebook ebook = new Ebook();
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		ResultSet rs = stmt.executeQuery();
		//디버깅
		System.out.println(stmt + "<-- 상세보기stmt");
		if(rs.next()) {
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookDate(rs.getString("ebookDate"));
			ebook.setEbookState(rs.getString("ebookState"));
		}
		// 4. 리턴
		return ebook;
	}
	
	//입력
	public static int insertEbook(Ebook ebook) throws Exception {
		// 1.sql
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?,?,?,?,?,?,?,?,'default.jpg',now(),'판매중')";
		// 2. 리턴값 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- 행의 수stmt");
		
		// 4. 리턴
		return rowCnt;
	}
	
	// 목록
	public static ArrayList<Ebook> ebookList(int rowPerPage, int beginRow, String categoryName) throws Exception {
		// 1. 초기화
		String sql = null;
		PreparedStatement stmt = null;
		ArrayList<Ebook> list = new ArrayList<>();
		// 2. 동적쿼리 DB
		Connection conn = DBUtil.getConnection();
		if(categoryName == null) {
			sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_img ebookImg FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_img ebookImg FROM ebook WHERE category_name = ? ORDER BY ebook_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<-- 목록&카테고리?stmt");

		// 입력값 저장
		while (rs.next()) {
			// 초기화
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookImg(rs.getString("ebookImg"));
			list.add(e);
		}
		// 4. 리턴
		return list;
	}

	// 전체 행의 수
	public static int totalCount() throws Exception {
		
		// 1. sql
		String sql = "SELECT count(*) cnt FROM ebook ";
		// 2. 리턴값 초기화
		int totalRow = 0;

		// 3. DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<-- 행의 수stmt");
		while (rs.next()) {
			totalRow = rs.getInt("cnt");
			System.out.println("totalRow : " + totalRow);
		}
		// 4. 리턴
		return totalRow;
	}

}
