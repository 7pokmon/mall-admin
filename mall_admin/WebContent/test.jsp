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
<%
		//현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// 페이지당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		// 전체 행의 수
		int totalRow = EbookDao.totalCount();
		System.out.println(totalRow+"<--totalRow");
		
		// EbookDao 목록 메서드 호출
		String categoryName = request.getParameter("categoryName");
		System.out.println(categoryName + "<-- 보고싶은categoryName");
		ArrayList<Ebook> list = EbookDao.ebookList(rowPerPage,beginRow,categoryName);
%>
	
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 카테고리별 목록을 볼수 있는 메뉴(네비게이션) -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String st : categoryNameList){
		%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=st%>">[<%=st%>]</a>
		<%		
			}
		%>
	</div>
	<h1>ebookList</h1>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp">
	<button type="button">ebook 추가</button></a>
	<!-- 페이지 보는 개수 골라보기 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10; i<=30; i+=5) {
					if(rowPerPage == i) {
			%>
				<option value="<%=i%>" selected="selected"><%=i%></option>
			<%			
					} else {
			%>
					<option value="<%=i%>"><%=i%></option>
			<%	
					}
		
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	<!-- 리스트 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Ebook e : list) {
			%>
				<tr>
					<td><%=e.getCategoryName()%></td>
					<td><%=e.getEbookISBN()%></td>
					<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a></td>
					<td><%=e.getEbookAuthor()%></td>
					<td><%=e.getEbookDate()%></td>
					<td><%=e.getEbookPrice()%></td>
				</tr>	
			<%
				}
			%>
		</tbody>
	</table>
<%
	if(currentPage > 1) { // 현재 페이지가 첫페이지가 아니면 이전버튼 생성
%>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
		이전</a>
<%		
	}
	
	int lastPage = totalRow / rowPerPage; // 마지막 페이지
	
	if(totalRow % rowPerPage != 0){ //나머지가 0이아니면
		lastPage += 1;
		//System.out.println("lastPage : " + lastPage);
	}
	if(currentPage < lastPage) { // 현재 페이지가 마지막페이지가 아니면 다음버튼 생성
%>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
		다음</a>
<%	
	}
%>
</body>
</html>