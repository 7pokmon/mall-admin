<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
	// login
	
	// 1. id,pw 요청 수집(전처리)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	// 수집후 출력
	System.out.println(managerId+" <-- managerId");
	System.out.println(managerPw+" <-- managerPw");
	// 2. 처리
	Manager manager = ManagerDao.login(managerId, managerPw);
	
	if(manager != null){ // 테이블에 정보가 있으면
		System.out.println("로그인 성공");
	
		//setAttribute(String name, Object value) 세션 속성명이 name인 속성에 속성값으로 value를 할당한다.
		session.setAttribute("sessionManager", manager);
	}
	// 3. 출력 or redirect(다른page 재요청)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>