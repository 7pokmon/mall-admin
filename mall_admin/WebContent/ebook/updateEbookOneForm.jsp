<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="java.util.*"%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Travel HTML-5 Template</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/assets/img/favicon.png">
<!-- Place favicon.ico in the root directory -->
<!-- CSS here -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/slicknav.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/animate.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/fontawesome-all.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/themify-icons.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/slick.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/nice-select.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/responsive.css">
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
	System.out.println(categoryNameList.size() + " <-- categoryNameList.size");
	%>
	<!-- 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<div class="container">
			<!-- Section Tittle -->
			<div class="row">
				<div class="col-lg-12">
					<div class="section-tittle text-center">
						<span>Goodee</span>
						<h2>UpdateEbookOne</h2>
						<h4><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebookISBN%>"><button class="button rounded-0 primary-bg text-white  boxed-btn">ebookOne</button></a></h4>
					</div>
				</div>
			</div>
</div>	
	<form
		action="<%=request.getContextPath()%>/ebook/updateEbookOneAction.jsp"
		method="post">
		<div class="support-company-area servic-padding fix">
			<div class="container">
				<div class="row align-items-center">
					<div class="col-xl-6 col-lg-6">
						<div class="support-location-img mb-50">
							<img
								src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"
								alt=""> <span> <!-- img modal --> <br> <!-- Button trigger modal -->
							</span>
							<div class="support-img-cap">
								<span><%=ebook.getEbookState()%></span>
							</div>
						</div>
					</div>
					<div class="col-xl-6 col-lg-6">
						<div class="right-caption">
							<!-- Section Tittle -->
							<div class="section-tittle section-tittle2">
								<h2>
									<input type="text" name="ebookTitle"
										value="<%=ebook.getEbookTitle()%>">
								</h2>
								<h4>
									<input type="text" name="ebookCompany"
										value="<%=ebook.getEbookCompany()%>"> / <input
										type="text" name="ebookAuthor"
										value="<%=ebook.getEbookAuthor()%>">
								</h4>
							</div>
							<div class="support-caption">
								<p><%=ebook.getEbookSummary()%>
									<br>

									<!-- 끝 -->
								</p>
								<div class="section-tittle section-tittle2">
									<span>
										<table>
											<tr>
												<td>date</td>
												<td>: <%=ebook.getEbookDate().substring(0, 10)%></td>
											</tr>
											<tr>
												<td>ISBN</td>
												<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>" readonly="readonly">
												<td>: <%=ebook.getEbookISBN()%></td>
											</tr>
											<tr>
												<td>No</td>
												<td>: <%=ebook.getEbookNo()%></td>
											</tr>
											<tr>
												<td>Category</td>
												<td><select name="categoryName">
														<option value="">=선택=</option>
														<%
														for (String ct : categoryNameList) {
														%>
														<option value="<%=ct%>"><%=ct%></option>
														<%
														}
														%>
												</select></td>
											</tr>
											<tr>
												<td>Page</td>
												<td>: <input type="text" name="ebookPageCount"
													value="<%=ebook.getEbookPageCount()%>"></td>
											</tr>
											<tr>
												<td>Price</td>
												<td>: <input type="text" name="ebookPrice"
													value="<%=ebook.getEbookPrice()%>">₩
												</td>
											</tr>
										</table>

									</span>
								</div>
								<a
									href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebookISBN%>"
									><button class="btn border-btn">Update</button></a> 
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>