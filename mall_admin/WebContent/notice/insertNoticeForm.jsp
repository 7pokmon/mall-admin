<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Travel HTML-5 Template </title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- <link rel="manifest" href="site.webmanifest"> -->
	<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/img/favicon.png">
	<!-- Place favicon.ico in the root directory -->
 <!-- CSS here -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/owl.carousel.min.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slicknav.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/animate.min.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/fontawesome-all.min.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/themify-icons.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slick.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/nice-select.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive.css">
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<!-- include 사용 시에 프로젝트명 필요없음 -->
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
	<h1>noticeInsertForm</h1>
	<!-- 공지 추가 테이블 작성 -->
	<form action="<%=request.getContextPath()%>/notice/InsertNoticeAction.jsp" method="post">
	<!-- action 파일에 managerId 값도 같이 넘겨줌 / 이미 로그인했기 때문에 managerId 값 넘어온 상태 -->
	<input type="hidden" name="managerId" value="<%=manager.getManagerId()%>">	
		<table border="1">
			<tr>
				<th>noticeTitle</th>
				<td>
					<input type="text" name="noticeTitle" required="required">
				</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td>
					<textarea rows="10" cols="80" name="noticeContent" required="required"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>