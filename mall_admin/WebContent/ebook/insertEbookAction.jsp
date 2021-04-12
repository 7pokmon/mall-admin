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
	
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	String ebookSummary = request.getParameter("ebookSummary");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	// 디버깅
	System.out.println(categoryName+" <--입력 categoryName");
	System.out.println(ebookISBN+" <--입력 ebookISBN");
	System.out.println(ebookTitle+" <--입력 ebookTitle");
	System.out.println(ebookAuthor+" <--입력 ebookAuthor");
	System.out.println(ebookCompany+" <--입력 ebookCompany");
	System.out.println(ebookSummary+" <--입력 ebookSummary");
	System.out.println(ebookPageCount+" <--입력 ebookPageCount");
	System.out.println(ebookPrice+" <--입력 ebookPrice");
	
	// 전처리
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	
	// EbookDao 중복확인 메서드 호출
	String returnEbookISBN = EbookDao.selectEbookISBN(ebookISBN);
	// 중복된 ebookISBN 있는지 없는지 확인 null이면 중복없음(사용가능) 아니면(사용불가) 홈으로
	if(returnEbookISBN != null) { //중복된값이 있으면
		System.out.println("중복된 ISBN 입니다");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return; //끝내기
	}
	// EbookDao 입력 메소드 호출
	EbookDao.insertEbook(ebook);
	
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>