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
	System.out.println(categoryName + "<-- 수정 categoryName");
	System.out.println(categoryWeight + "<-- 수정 categoryWeight");
	
	// CategoryDao 수정 메서드 호출
	CategoryDao.updateCategoryWeight(categoryName,categoryWeight);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>