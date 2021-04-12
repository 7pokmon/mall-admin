<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)session.getAttribute("sessionManager");
	
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;
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
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>카테고리 추가</h1>
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>categoryName</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
			<tr>
				<td>catecoryWeight</td>
				<td>
					<select name="categoryWeight">
					<%
						for(int i=0; i<10; i++) {
					%>	
							<option><%=i%></option>
					<%		
						}
					%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">카테고리 등록</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>