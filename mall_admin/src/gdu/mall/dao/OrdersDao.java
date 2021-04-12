package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;

public class OrdersDao {
	// orders 리스트X -- > orders join ebook join client 리스트O
	/* OrdersAndEbookAndClient
	 * SELECT
	 * o.orders_no ordersNo,
	 * o.ebook_no ebookNo,
	 * e.ebook title ebookTitle,
	 * o.client_no clientNo,
	 * c.client_mail clientMail,
	 * o.orders_date ordersDate,
	 * o.orders_state ordersState
	 * FROM orders o INNER JOIN ebook e INNER JOIN client c
	 * ON o.ebook_no = e.ebook_no ABD o.client_no = c.client_no
	 * order by o.orders_no desc
	 */
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersByList(int rowPerPage, int beginRow) throws Exception {
		
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no ORDER BY o.orders_no DESC LIMIT ?,?";
		
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt + "<-- 주문목록 stmt");
		
		// INNER JOIN 해당하는 테이블 데이터 입력
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			// Oreders,Ebook,Client
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		return list;
	}
	// 전체 행의 수
	public static int totalCount() throws Exception {
		// 1. sql
		String sql = "SELECT count(*) cnt FROM orders";
		// 2. 초기화
		int totalRow = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + "<-- 전체 행의 수 stmt");
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
			System.out.println(totalRow + "<-- totalRow");
		}
		// 4. 리턴
		return totalRow;
	}
	// 주문상태 수정
	public static int updateOrdersState(Orders orders) throws Exception {
		// 1. sql
		String sql = "UPDATE orders SET orders_state=? WHERE orders_no=?";
		// 2. 초기화
		int rowCnt = 0;
		// 3. DB
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersNo());
		rowCnt = stmt.executeUpdate();
		// 디버깅
		System.out.println(stmt + "<-- 주문상태 수정 stmt");
		// 4. 리턴
		return rowCnt;
	}
}
