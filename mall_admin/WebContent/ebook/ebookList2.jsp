<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
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
	//현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지당 행의 수
	int rowPerPage = 9;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	// 전체 행의 수
	int totalRow = EbookDao.totalCount();
	System.out.println(totalRow + "<--totalRow");

	// EbookDao 목록 메서드 호출
	String categoryName = request.getParameter("categoryName");
	System.out.println(categoryName + "<-- 보고싶은categoryName");
	ArrayList<Ebook> list = EbookDao.ebookList(rowPerPage, beginRow, categoryName);
	%>

	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 카테고리별 목록을 볼수 있는 메뉴(네비게이션) -->


	<!-- Favourite Places Start -->
	<section class="blog_area section-padding">
		<div class="container">
			<!-- Section Tittle -->
			<div class="row">
				<div class="col-lg-12">
					<div class="section-tittle text-center">
						<span>Goodee</span>
						<h2>Ebook List</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<!-- 전체 -->
				<!-- 왼쪽 -->
				<div class="col-lg-8 mb-5 mb-lg-0">
					<div class="blog_left_sidebar">
						<!-- 시작 -->
						<div class="favourite-place">
							<div class="container">
								<div class="row">
									<%
									for (Ebook e : list) {
									%>

									<div class="col-xl-4 col-lg-4 col-md-6">
										<div class="single-place mb-30">
											<div class="place-img">
												<img
													src="<%=request.getContextPath()%>/img/<%=e.getEbookImg()%>"
													alt="">
											</div>
											<div class="place-cap">
												<div class="place-cap-top">
													<span><i class="fas fa-star"></i><span>8.0
															Superb</span> </span>
													<!-- 타이틀 -->
													<h3>
														<a
															href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a>
													</h3>
													<!-- 가격 / Author -->
													<p class="dolor">
														<%=e.getEbookPrice()%>₩ <span> / <%=e.getEbookAuthor()%></span>
													</p>
												</div>
												<!-- Date -->
												<div class="place-cap-bottom">
													<ul>
														<li><i class="far fa-clock"></i>3 Days</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<%
									}
									%>
								</div>
							</div>
						</div>
						<!-- 끝 -->
					</div>
				</div>
				<!-- 왼쪽끝 -->
				<!-- 오른쪽시작 -->
				<div class="col-lg-4">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget search_widget">
							<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp">
								<button type="button"
									class="button rounded-0 primary-bg text-white w-100 btn_1 boxed-btn">ebook
									add</button>
							</a>
						</aside>
						<!-- 카테고리별 목록을 볼수 있는 메뉴(네비게이션) -->
						<aside class="single_sidebar_widget post_category_widget">
							<h4 class="widget_title">Category</h4>
							<ul class="list cat-list">
								<%
								ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
								for (String st : categoryNameList) {
								%>

								<li><a
									href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=st%>"
									class="d-flex">
										<p><%=st%></p>
								</a></li>
								<%
								}
								%>
							</ul>
						</aside>
					</div>
				</div>
				</div>
				</div>
				<!-- 오른쪽 끝 -->
				  <nav class="blog-pagination justify-content-center d-flex">
                            <ul class="pagination">
					<%
	if (currentPage > 1) { // 현재 페이지가 첫페이지가 아니면 이전버튼 생성
	%>
	   <li class="page-item">
	<a
		href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>" class="page-link" aria-label="Previous">
		<i class="ti-angle-left"></i></a>
	<%
	}

	int lastPage = totalRow / rowPerPage; // 마지막 페이지

	if (totalRow % rowPerPage != 0) { //나머지가 0이아니면
	lastPage += 1;
	//System.out.println("lastPage : " + lastPage);
	}
	if (currentPage < lastPage) { // 현재 페이지가 마지막페이지가 아니면 다음버튼 생성
	%>
	<li class="page-item">
	<a
		href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>" class="page-link" aria-label="Next"><i class="ti-angle-right"></i></a>
	<%
	}
	%>
	</ul>
	</nav>
	</section>
</body>
</html>