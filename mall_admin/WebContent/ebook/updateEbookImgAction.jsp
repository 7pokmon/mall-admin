<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 이미지관련 임포트 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%

	// 수집코드구현
	/* enctype="multipart/form-data" 로 넘겼기때문에 기본 매커니즘으로 받을수없음.
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	System.out.println(ebookISBN); --> null
	System.out.println(ebookImg);  --> null
	*/
	// 파일을 다운로드 받을 위치
	// String path = application.getRealPath("img"); //img 폴더에 getRealPath(OS상의 실제경로) 호출
	String path = "D:/goodee/web/mall_admin/WebContent/img";
	System.out.println(path + "<-- 실제경로");

	// 파일크기 허용범위
	int size = 1024 * 1024 * 100; //  100MB
												//request,경로,파일크기 허용범위,인코딩,중복된이름변경후처리
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	// 수집코드구현
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	System.out.println(ebookISBN + "<-- Img수정 ebookISBN");
	System.out.println(ebookImg + "<-- Img수정 ebookImg");
	
	Ebook ebook = new Ebook();
	ebook.setEbookImg(ebookImg);
	ebook.setEbookISBN(ebookISBN);
	
	// ebookDao Img수정 메서드 호출
	EbookDao.updateEbookImg(ebook);
	
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>