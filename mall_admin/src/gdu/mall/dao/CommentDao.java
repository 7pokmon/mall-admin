package gdu.mall.dao;
import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class CommentDao {
	// 댓글 유무에따른 삭제알림 메서드
	public static int selectCommentCnt(int noticeNo) throws Exception {
		String sql = "SELECT count(*) cnt from comment WHERE notice_no=?";
		int rowCnt = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + " <--삭제알림 stmt");
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		
		return rowCnt;
	}
	
	
	// 입력 메서드
	public static int insertComment(Comment comment) throws Exception {
		// 1. sql
		String sql = "INSERT INTO comment(notice_no, manager_id, comment_content, comment_date) VALUES (?,?,?,NOW())";
		// 2. 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + " <--입력 stmt");
		// 4. 리턴
		return rowCnt;
	}
	// 목록 메서드
	public static ArrayList<Comment> selectCommentListByNo(int noticeNo) throws Exception {
		// 1. sql
		String sql = "SELECT comment_no commentNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		// 2. 초기화
		ArrayList<Comment> list = new ArrayList<>();
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + " <--목록 stmt");
		// 데이터 입력
		while(rs.next()){
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("commentNo"));
			c.setManagerId(rs.getString("managerId"));
			c.setCommentContent(rs.getString("commentContent"));
			c.setCommentDate(rs.getString("commentDate"));
			list.add(c);
		}
		// 4. 리턴
		return list;
	}
	// 삭제 메서드
	// 오버로딩 deleteComment 메서드이름은 동일하지만 매개변수값(타입)이 다른경우
	public static int deleteComment(int commentNo) throws Exception {
		// 1. sql
		String sql = "DELETE FROM comment WHERE comment_no=?";
		// 2. 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + " <--삭제(commentNo) stmt");
		// 4. 리턴
		return rowCnt;
	}
	// 오버로딩
	public static int deleteComment(int commentNo, String managerId) throws Exception {
		
		String sql = "DELETE FROM comment WHERE comment_no=? and managerId=?";
		// 2. 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + " <--삭제(commentNo,managerId) stmt");
		// 4. 리턴
		return rowCnt;
	}
}
