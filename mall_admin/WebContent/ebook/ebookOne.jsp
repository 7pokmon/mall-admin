<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
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
<!-- modal css -->

</head>
<body>
	<%
	// 수집코드 구현
	String ebookISBN = request.getParameter("ebookISBN");
	// 디버깅
	System.out.println(ebookISBN + "<-- 상세보기ebookISBN");
	// EbookDao 상세보기 메서드 호출
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
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
						<h2>Ebook One</h2>
						<h4><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><button class="button rounded-0 primary-bg text-white  boxed-btn">ebookList</button></a></h4>
					</div>
				</div>
			</div>
</div>			
	<div class="support-company-area servic-padding fix">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-xl-6 col-lg-6">
					<div class="support-location-img mb-50">
						<img
							src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"
							alt=""> <span> <!-- img modal --> <br> <!-- Button trigger modal -->
							<button type="button" class="btn border-btn" data-toggle="modal"
								data-target="#img">Img Update</button> <!-- Modal -->
							<div class="modal fade" id="img" tabindex="-1" role="dialog"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">Img Update</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form
												action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp"
												method="post" enctype="multipart/form-data">
												<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
												<input type="file" name="ebookImg">
												<div class="modal-footer">
													<button type="submit" class="btn btn-primary">Save
														changes</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div> <!-- state modal --> <!-- Button trigger modal -->
							<button type="button" class="btn border-btn" data-toggle="modal"
								data-target="#State">State Update</button> <!-- Modal -->
							<div class="modal fade" id="State" tabindex="-1" role="dialog"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">State Update</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form
												action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp"
												method="post">
												<table>
													<tr>
														<td>ebookState</td>
														<td><input type="hidden" name="ebookISBN"
															value="<%=ebookISBN%>"> <select name="ebookState">
																<option value="">==Select==</option>
																<%
																String[] ebookStateList = { "판매중", "품절", "절판", "구편절판" };
																for (String s : ebookStateList) {
																%>
																<option value="<%=s%>"><%=s%></option>
																<%
																}
																%>
														</select></td>
													</tr>
												</table>
												<div class="modal-footer">
													<button type="submit" class="btn btn-primary">Save
														changes</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>

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
							<h2><%=ebook.getEbookTitle()%></h2>
							<h4><%=ebook.getEbookCompany()%>
								/
								<%=ebook.getEbookAuthor()%></h4>
						</div>
						<div class="support-caption">
							<p><%=ebook.getEbookSummary()%>
								<br>
								<!-- modal -->
								<button type="button" class="btn border-btn"
									data-toggle="modal" data-target="#exampleModal"
									data-whatever="@fat">Summary Update</button>
							<div class="modal fade" id="exampleModal" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">New
												Summary</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form
												action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp"
												method="post">
												<div class="form-group">
													<label for="message-text" class="col-form-label">Summary:</label>
													<input type="hidden" name="ebookISBN"
														value="<%=ebookISBN%>">
													<textarea class="form-control" id="message-text"
														name="ebookSummary"></textarea>
												</div>
												<div class="modal-footer">
													<button type="submit" class="btn btn-primary">Save
														changes</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
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
											<td>: <%=ebook.getEbookISBN()%></td>
										</tr>
										<tr>
											<td>No</td>
											<td>: <%=ebook.getEbookNo()%></td>
										</tr>
										<tr>
											<td>Category</td>
											<td>: <%=ebook.getCategoryName()%></td>
										</tr>
										<tr>
											<td>Page</td>
											<td>: <%=ebook.getEbookPageCount()%></td>
										</tr>
										<tr>
											<td>Price</td>
											<td>: <%=ebook.getEbookPrice()%>₩
											</td>
										</tr>
									</table>

								</span>
							</div>

							<a
								href="<%=request.getContextPath()%>/ebook/updateEbookOneForm.jsp?ebookISBN=<%=ebookISBN%>"
								class="btn border-btn">Update</a> <a
								href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>"
								class="btn border-btn">Delete</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>