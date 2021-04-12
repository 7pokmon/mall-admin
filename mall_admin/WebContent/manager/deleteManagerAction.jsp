<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager"%>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
	// 로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)(session.getAttribute("sessionManager"));

	if(manager == null) {
		
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
	
	return;
	
	} else if(manager.getManagerLevel() < 2) {
		
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;	
	}
	// 수집 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	// 디버깅
	System.out.println(managerNo + "<-- managerNo");
	
	// dao 삭제메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>	
