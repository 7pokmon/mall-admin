<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
//로그인 조건에 맞지않으면 돌려보냄
Manager manager = (Manager) session.getAttribute("sessionManager");

if (manager == null || manager.getManagerLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");

	return;
}
%>
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
	//CategoryDao 메서드 호출
	ArrayList<Category> list = CategoryDao.categoryList();
	%>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- slider Area Start-->
	<div class="slider-area ">
		<!-- Mobile Menu -->
		<div class="single-slider slider-height2 d-flex align-items-center"
			data-background="<%=request.getContextPath()%>/assets/img/hero/contact_hero.jpg">
			<div class="container">
				<div class="row">
					<div class="col-xl-12">
						<div class="hero-cap text-center">
							<h2>categoryList</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- slider Area End-->
	<div class="section-top-border">
		<!-- 페이징X, 검색어X, categoryWeight(수정), 카테고리 추가 -->
		<!-- 카테고리 추가 -->
		<!-- Button trigger modal -->
		<button type="button" class="genric-btn primary-border"
			data-toggle="modal" data-target="#Category">Insert Category
		</button>
		<!-- Modal -->
		<div class="modal fade" id="Category" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Category</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form
							action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp"
							method="post">
							<table>
								<tr>
									<td>categoryName</td>
									<td><input type="text" name="categoryName"></td>
								</tr>
								<tr>
									<td>catecoryWeight</td>
									<td><select name="categoryWeight">
											<%
											for (int i = 0; i < 10; i++) {
											%>
											<option><%=i%></option>
											<%
											}
											%>
									</select></td>
								</tr>
							</table>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">add
									Category</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="progress-table-wrap">
			<div class="progress-table">
				<div class="table-head">
					<div class="country">categoryName</div>
					<div class="percentage">categoryWeight</div>
					<div class="serial">delete</div>
				</div>

				<%
				for (Category ct : list) {
				%>
				<div class="table-row">
					<div class="country"><%=ct.getCategoryName()%></div>
					<!-- categoryWeight 수정하기 -->
					<div class="percentage">
						<form
							action="<%=request.getContextPath()%>/category/updateCategoryWeightAction.jsp"
							method="post">
							<input type="hidden" name="categoryName"
								value="<%=ct.getCategoryName()%>"> <select
								name="categoryWeight">
								<%
								for (int i = 0; i < 10; i++) {
									if (ct.getCategoryWeight() == i) {
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
							<button type="submit" class="genric-btn primary-border circle">update</button>
						</form>
					</div>
					<div class="serial">
						<a
							href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=ct.getCategoryName()%>"><button
								class="genric-btn primary-border circle">delete</button></a>
					</div>
				</div>
				<%
				}
				%>

			</div>
		</div>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>