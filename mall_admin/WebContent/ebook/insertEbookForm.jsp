<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
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
		
	<%
		// 목록 메서드 가져오기
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		System.out.println(categoryNameList.size()+" <-- categoryNameList.size");
	%>
<div class="container box_1170">
	<h1>insertEbookForm</h1>	
	<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
		<table>
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<option value="">=Select=</option>
						<%
							for(String st : categoryNameList) {
						%>
							<option value="<%=st%>"><%=st%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>ebookISBN</td>
				<td><input type="text" name="ebookISBN" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookTitle</td>
				<td><input type="text" name="ebookTitle" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookAuthor</td>
				<td><input type="text" name="ebookAuthor" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookCompany</td>
				<td><input type="text" name="ebookCompany" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookPageCount</td>
				<td><input type="text" name="ebookPageCount" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookPrice</td>
				<td><input type="text" name="ebookPrice" class="single-input"></td>
			</tr>
			<tr>
				<td>ebookSummary</td>
				<td><textarea rows="10" cols="80"  wrap="hard" name="ebookSummary" class="single-textarea"></textarea></td>
			</tr>
		</table>
		<button type="submit"  class="genric-btn primary">ebook add</button>
	</form>
</div>	
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>