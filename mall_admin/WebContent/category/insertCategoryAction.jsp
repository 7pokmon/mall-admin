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
	request.setCharacterEncoding("utf-8");
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	// 디버깅
	System.out.println(categoryName + "<-- 추가 categoryName");
	System.out.println(categoryWeight + "<-- 추가 categoryWeight");	
	
	// categoryDao 중복 메서드 호출
	
	String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
	// 중복된 categoryName 있는지 없는지 확인 null이면 중복없음(사용가능) 아니면(사용불가) 홈으로
	if(returnCategoryName != null) { // ID중복이면
		System.out.println("중복된 카테고리 입니다");
		response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
		return; //끝내기
	}
	
	
	// CategoryDao 추가 메서드 호출
	CategoryDao.insertCategory(categoryName,categoryWeight);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>