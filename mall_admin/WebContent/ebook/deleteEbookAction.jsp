<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*" %>
<%
	//로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)session.getAttribute("sessionManager");

	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;
	}
	
	// 수집코드 구현
	String ebookISBN = request.getParameter("ebookISBN");
	
	//전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	// 메소드 호출
	EbookDao.deleteEbookOne(ebook);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>