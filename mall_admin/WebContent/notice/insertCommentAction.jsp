<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	// 수집코드 구현
	request.setCharacterEncoding("utf-8"); //한글처리

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String commentContent = request.getParameter("commentContent");
	String managerId = request.getParameter("managerId");
	// 디버깅
	System.out.println(noticeNo + "<-- 입력 noticeNo");
	System.out.println(noticeNo + "<-- 입력 commentContent");
	
	// 전처리
	Comment comment = new Comment();
	comment.setCommentContent(commentContent);
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	
	// 입력메서드 호출
	CommentDao.insertComment(comment);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>
