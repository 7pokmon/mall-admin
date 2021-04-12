<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%

	//관리자만 접근할 수 있게 하는 메소드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	// 수집코드 구현
	request.setCharacterEncoding("utf-8"); //한글처리
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String managerId = request.getParameter("managerId");
	
	// 디버깅
	System.out.println(noticeNo + "<-- 삭제 noticeNo");
	System.out.println(commentNo + "<-- 삭제 commentNo");
	System.out.println(managerId + "<-- 삭제 managerId");
	
	// 경우(managerLevel)에따른 삭제 메서드 호출
	if(manager.getManagerLevel() > 1) { // managerLevel 2일때 전부 삭제가능
		CommentDao.deleteComment(commentNo);
	} else if(manager.getManagerLevel() > 0) {
		CommentDao.deleteComment(commentNo, managerId); //managerLevel 1일때 동일한 managerId만 삭제가능
	}
	
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>