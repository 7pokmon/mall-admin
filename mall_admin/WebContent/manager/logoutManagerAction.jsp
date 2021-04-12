<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	//세션에서 진행한 기록을 지움(로그인 정보도 사라진다 -> 로그아웃)
	//invalidate() 현재 생성된 세션을 무효화 시킨다.
	session.invalidate();
	//초기화시키고 첫화면으로 이동하게 재요청
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>
