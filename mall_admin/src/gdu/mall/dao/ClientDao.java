package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class ClientDao {
	
	// 삭제(DELETE)
	public static int deleteClient(String clientMail) throws Exception {
		//1. sql
		String sql = "DELETE FROM client WHERE client_mail=?";
		//2. 리턴값 초기화
		int rowCnt = 0;
		//3. DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt+"<-- 삭제stmt");
		
		//4. 리턴
		return rowCnt;
	}
	// 수정(UPDATE)
	public static int updateClient(String clientPw, String clientMail) throws Exception {
		
		//1. sql
		String sql = "UPDATE client SET client_pw = PASSWORD(?) WHERE client_mail=? ";
		//2. 리턴값 초기화
		int rowCnt = 0;
		//3. DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,clientPw);
		stmt.setString(2,clientMail);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt+"<-- 수정stmt");
		//4. 리턴
		return rowCnt;
	}
	
	// 전체 행의 수
	public static int totalCount(String searchWord) throws Exception {
		
		//1. 리턴값 초기화
		int totalRow = 0;
		
		//2. DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		//3. 조건에맞는 쿼리생성 (동적쿼리)
		String sql = "";
		if(searchWord.equals("")) { // 검색값이 없으면
			sql = "SELECT count(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
			
		} else { // 검색값이 존재하면 like 연산자를 통해 연관된 검색어의 행만 표시
			sql = "SELECT count(*) cnt FROM client WHERE client_mail like ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,"%"+searchWord+"%");
		}
	
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt+"<-- 행의 수stmt");
		
		while(rs.next()) {
			totalRow = rs.getInt("cnt"); 
			System.out.println("totalRow : " + totalRow);
		}
		
		//4. 리턴
		return totalRow;
	}
	
	// 목록,검색어
	public static ArrayList<Client> selectClientByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
		
		//1. 리턴값 초기화 
		ArrayList<Client> list = new ArrayList<>();
		
		//2. DB연결
		Connection conn = DBUtil.getConnection();	
		PreparedStatement stmt = null;
		//3. 조건에맞는 쿼리생성 (동적쿼리)
		String sql = "";
		if(searchWord.equals("")){ // 검색값이 없으면
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {	// 검색값이 존재하면 like 연산자를 통해 연관된 검색어 찾음
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt+"<-- 목록,검색stmt");
		
		// 입력값 저장
		while(rs.next()) {
			//초기화
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		
		//4. 리턴
		return list;
	}
}
