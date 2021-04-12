<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)session.getAttribute("sessionManager");
	
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;
	}
	// 수집 코드 구현
	String clientPw = request.getParameter("clientPw");
	String clientMail = request.getParameter("clientMail");
	// 디버깅
	System.out.println(clientPw + "<-- clientPw");
	System.out.println(clientMail + "<-- clientMail");
	// ClientDao 수정 메서드 호출
	ClientDao.updateClient(clientPw,clientMail);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>