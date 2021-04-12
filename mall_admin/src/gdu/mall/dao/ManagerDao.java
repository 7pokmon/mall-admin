package gdu.mall.dao;
import gdu.mall.vo.Manager;
import gdu.mall.util.*;
import java.sql.*;
import java.util.ArrayList;

public class ManagerDao {
	// admin 대기명단
	public static ArrayList<Manager>  selectManagerListByZero() throws Exception {
		// 1. sql
		String sql = "SELECT manager_id managerId, manager_date managerDate, manager_no managerNo FROM manager WHERE manager_level=0";
		// 2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		// 3.DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<-- 목록메서드stmt");
				
		ResultSet rs = stmt.executeQuery();
				
		// 입력값 저장
		while(rs.next()) {
			// 초기화
			Manager m = new Manager();
			// 쿼리에서 이름 변경했기떄문에 manager_no대신 managerNo 사용가능
			m.setManagerId(rs.getString("managerId"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerNo(rs.getInt("managerNo"));
			list.add(m);
		}
					
		// 4 리턴
		return list;
	}
	
	// 수정 메서드
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception {
		// 1.sql
		String sql = "UPDATE manager SET manager_level=? WHERE manager_no=?";
		
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3.DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,managerLevel);
		stmt.setInt(2,managerNo);
		
		System.out.println(stmt+"<-- 수정메서드stmt");
		
		rowCnt = stmt.executeUpdate();
	
		
		// 4. 리턴
		return rowCnt;
	}
	
	// 삭제 메서드
	public static int deleteManager(int managerNo) throws Exception {
		// 1.sql
		String sql = "DELETE FROM manager WHERE manager_no=?";
		
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3.DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,managerNo);
		
		System.out.println(stmt+"<-- 삭제메서드stmt");
		
		rowCnt = stmt.executeUpdate();
		
		// 4. 리턴 
		return rowCnt;
	}
	

	// 목록 메서드
	public static ArrayList<Manager> selectManagerList(int rowPerPage, int beginRow) throws Exception {
		// 1.sql
		String sql = "SELECT manager_no managerNo,manager_id managerId,manager_name managerName,manager_date managerDate,manager_level managerLevel FROM manager order by manager_date desc LIMIT ?,?";
		
		// 2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		// 3.DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+"<-- 목록메서드stmt");
		
		ResultSet rs = stmt.executeQuery();
		
		// 입력값 저장
		while(rs.next()) {
			// 초기화
			Manager m = new Manager();
			// 쿼리에서 이름 변경했기떄문에 manager_no대신 managerNo 사용가능
			m.setManagerNo(rs.getInt("manager_no"));
			m.setManagerId(rs.getString("manager_id"));
			m.setManagerName(rs.getString("manager_name"));
			m.setManagerDate(rs.getString("manager_date"));
			m.setManagerLevel(rs.getInt("manager_level"));
			list.add(m);
		}
			
		// 4 리턴
		return list;
		
		}
	
	// 입력 받는 메서드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		
		// 1. 쿼리
		String sql = "INSERT INTO manager(manager_id,manager_pw,manager_name,manager_date,manager_level) VALUES(?,?,?,now(),0)";
		
		// 2. 리턴타입
		int rowCnt = 0; // 입력성공시 1, 실패시 0
		
		// DB 연결 메서드
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,managerId);
		stmt.setString(2,managerPw);
		stmt.setString(3,managerName);
		
		System.out.println(stmt+"<-- 입력받는메서드stmt");
		
		rowCnt = stmt.executeUpdate();
		
		//3. DB 처리
		
		return rowCnt;
	}
	
	// id 사용가능여부											//오류 예외문
	public static String selectManagerId(String managerId) throws Exception {
		// 1. sql문
		String sql="SELECT manager_id FROM manager WHERE manager_id=?";
		// 2. 리턴타입 초기화
		String returnManagerId = null;
		
		// 3. DB 처리
		
		// DB 연결 메서드
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		System.out.println(stmt + " <-- id사용가능여부 메서드stmt");
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		// 4. 리턴
		return returnManagerId;
	}
	
	
	// 로그인 메서드												// 메소드에서 예외가 발생시 던짐?
	public static Manager login(String managerId, String managerPw) throws Exception {
		
		Manager manager = null; 
		
		//manager_id 와 manager_pw가 동일하고 manager_level>0 일떄 manager_id,manager_name 가져옴
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0 ";
		
		// DB 연결 메서드 
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		
		System.out.println(stmt + " <-- 로그인 메서드stmt");
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { 
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager; // return 해서 정보가들어감
	}
	
}
