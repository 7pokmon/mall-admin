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
	
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	// 디버깅
	System.out.println(rowPerPage+ "<-- 상태수정 rowPerPage");
	System.out.println(currentPage+ "<-- 상태수정 currentPage");
	System.out.println(ordersNo+ "<-- 상태수정 ordersNo");
	System.out.println(ordersState+ "<-- 상태수정 ordersState");
	//전처리
	Orders orders = new Orders();
	orders.setOrdersNo(ordersNo);
	orders.setOrdersState(ordersState);
	
	// 상태수정 메서드 호출
	OrdersDao.updateOrdersState(orders);
	// 돌아가기
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp?rowPerPage="+rowPerPage+"&currentPage="+currentPage);
%>