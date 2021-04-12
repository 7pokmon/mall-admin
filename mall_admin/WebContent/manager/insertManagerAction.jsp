<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.dao.*" %>
<%@ page import ="gdu.mall.vo.*" %>

<%
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");
	// 1. 수집
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	
	// 디버깅 확인
	System.out.println(managerId + "<-- managerId");
	System.out.println(managerPw + "<-- managerPw");
	System.out.println(managerName + "<-- managerName");
	
	// 2-1 중복된 아이디가 있는지 없는지 확인 null이면 중복없음(사용가능) 아니면(사용불가) 홈으로
	String returnMangerId = ManagerDao.selectManagerId(managerId);
	
	if(returnMangerId != null) { // ID중복이면
		System.out.println("중복된 아이디 입니다");
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp");
		return; //끝내기
	}
	
	
	// 2-2. 입력
	ManagerDao.insertManager(managerId, managerPw, managerName);
	// 3. 돌아가기	
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>
