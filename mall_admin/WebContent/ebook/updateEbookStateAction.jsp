<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)session.getAttribute("sessionManager");

	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;
	}
	
	// 수집코드 구현
	request.setCharacterEncoding("utf-8"); //한글처리
	
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookState = request.getParameter("ebookState");
	//디버깅
	System.out.println(ebookISBN + " <-- State수정 ebookISBN");
	System.out.println(ebookState + " <-- State수정 ebookState");
	//전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	// EbookDao State수정 메서드 호출
	EbookDao.updateEbookState(ebook);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);

%>