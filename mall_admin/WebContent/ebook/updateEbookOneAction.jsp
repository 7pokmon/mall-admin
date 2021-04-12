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

	// 수집코드 구현
	request.setCharacterEncoding("utf-8"); //한글처리
	
	String ebookISBN = request.getParameter("ebookISBN");
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	// 디버깅
	System.out.println(ebookISBN + "<-- ebookOne수정 ebookISBN");
	System.out.println(categoryName + "<-- ebookOne수정 categoryName");
	System.out.println(ebookTitle + "<-- ebookOne수정 ebookTitle");
	System.out.println(ebookAuthor + "<-- ebookOne수정 ebookAthor");
	System.out.println(ebookCompany + "<-- ebookOne수정 ebookCompany");
	System.out.println(ebookPrice + "<-- ebookOne수정 ebookPrice");
	System.out.println(ebookPageCount + "<-- ebookOne수정 ebookPageCount");
	
	// 전처리
	Ebook ebook = new Ebook();
	
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookPageCount(ebookPageCount);
	
	// EbookDao 메소드 호출
	EbookDao.updateEbookOne(ebook);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>