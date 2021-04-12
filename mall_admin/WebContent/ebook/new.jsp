<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="java.util.*" %>

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
	// 수집
	String ebookISBN = request.getParameter("ebookISBN");
	//디버깅
	System.out.println(ebookISBN + "<-- ebookOne수정 ebookISBN");

	
	// EbookDao 상세보기 메서드 호출
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	// 목록 메서드 가져오기
	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
	System.out.println(categoryNameList.size()+" <-- categoryNameList.size");
	
%>
	<h1>updateEbookOneForm</h1>
	<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebookISBN%>"><button type="button">돌아가기</button></a>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookOneAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>ebookNo</td>
				<td>
					<%=ebook.getEbookNo()%>
				</td>
			</tr>
			
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<option value="">=선택=</option>
						<%
							for(String ct : categoryNameList) {
						%>
							<option value="<%=ct%>"><%=ct%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>ebookTitle</td>
				<td>
					<input type="text" name="ebookTitle" value="<%=ebook.getEbookTitle()%>">
				</td>
			</tr>
			
			<tr>
				<td>ebookState</td>
				<td>
					<%=ebook.getEbookState()%>
				</td>
			</tr>
			
			<tr>
				<td>ebookAuthor</td>
				<td>
					<input type="text" name="ebookAuthor" value="<%=ebook.getEbookAuthor()%>">
				</td>
			</tr>
			
			<tr>
				<td>ebookImg</td>
				<td>
					<img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>">
				</td>
			</tr>
			
			<tr>
				<td>ebookISBN</td>
				<td>
					<input type="text" name="ebookISBN" value="<%=ebook.getEbookISBN()%>" readonly="readonly">
				</td>
			</tr>
			
			<tr>
				<td>ebookCompany</td>
				<td>
					<input type="text" name="ebookCompany" value="<%=ebook.getEbookCompany()%>">
				</td>
			</tr>
			
			<tr>
				<td>ebookDate</td>
				<td>
					<%=ebook.getEbookDate()%>
				</td>
			</tr>
			
			<tr>
				<td>ebookSummary</td>
				<td>
					<%=ebook.getEbookSummary()%>
				</td>
			</tr>
			
			<tr>
				<td>ebookPrice</td>
				<td>
					<input type="text" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
				</td>
			</tr>
			
			<tr>
				<td>ebookPageCount</td>
				<td>
					<input type="text" name="ebookPageCount" value="<%=ebook.getEbookPageCount()%>">
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>