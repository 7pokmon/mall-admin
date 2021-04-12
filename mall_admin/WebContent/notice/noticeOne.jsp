<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="java.util.*"%>
<%
// 관리자만 접근할 수 있게 하는 메소드 
Manager manager = (Manager) session.getAttribute("sessionManager");
if (manager == null || manager.getManagerLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
	return; // 코드 실행 멈춤
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
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + "<-- noticeOne의 noticeNo"); // 디버깅

	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
	%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- slider Area Start-->
	<div class="slider-area ">
		<!-- Mobile Menu -->
		<div class="single-slider slider-height2 d-flex align-items-center"
			data-background="<%=request.getContextPath()%>/assets/img/hero/about.jpg">
			<div class="container">
				<div class="row">
					<div class="col-xl-12">
						<div class="hero-cap text-center">
							<h2>Notice</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Favourite Places Start -->
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 posts-list">
					<div class="single-post">
						<div class="feature-img">
							<img class="img-fluid" src="assets/img/blog/single_blog_1.png"
								alt="">
						</div>
						<div class="blog_details">
							<h2><%=notice.getNoticeTitle()%>
							</h2>
							<ul class="blog-info-link mt-3 mb-4">
								<li><a href="#"><i class="fa fa-user"></i><%=notice.getManagerId()%></a></li>
								<li><a href="#"><i class="fa fa-comments"></i>
										Comments</a></li>
							</ul>
							<p class="excert">
								<%=notice.getNoticeContent()%>
							</p>
							<p>
								<%=notice.getNoticeDate().substring(0, 11)%>
							</p>
						</div>
					</div>
					<!-- 테두리 css -->
					<div class="navigation-top">
						<div class="d-sm-flex justify-content-between text-center">
							<p class="like-info">
								<span class="align-middle"><i class="fa fa-heart"></i></span>
								Lily and 4 people like this
							</p>
							<div class="col-sm-4 text-center my-2 my-sm-0">
								<!-- <p class="comment-count"><span class="align-middle"><i class="fa fa-comment"></i></span> 06 Comments</p> -->
							</div>
							<ul class="social-icons">
								<li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
								<li><a href="#"><i class="fab fa-twitter"></i></a></li>
								<li><a href="#"><i class="fab fa-dribbble"></i></a></li>
								<li><a href="#"><i class="fab fa-behance"></i></a></li>
							</ul>
						</div>
						<!-- 수정삭제 -->
						<div class="navigation-area">
							<div class="row">
								<div
									class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
									<div class="thumb">
										<a href="#"> <img class="img-fluid"
											src="assets/img/post/preview.png" alt="">
										</a>
									</div>
									<div class="arrow">
										<a href="#"> <span class="lnr text-white ti-arrow-left"></span>
										</a>
									</div>
									<div class="detials">
										<!-- modal update -->
										<button type="button" class="genric-btn primary-border circle"
											data-toggle="modal" data-target="#noticeUpdate"
											data-whatever="@fat">Update</button>
										<div class="modal fade" id="noticeUpdate" tabindex="-1"
											role="dialog" aria-labelledby="exampleModalLabel"
											aria-hidden="true">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLabel">Update
															Notice</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<!-- 입력폼 -->
														<form
															action="<%=request.getContextPath()%>/notice/updateNoticeOneAction.jsp"
															method="post">
															<div class="form-group">
																<label for="recipient-name" class="col-form-label">Title:</label>
																<input type="hidden" name="noticeNo"
																	value="<%=noticeNo%>"> <input type="text"
																	class="form-control" name="noticeTitle"
																	id="recipient-name"
																	placeholder="<%=notice.getNoticeTitle()%>">
															</div>
															<div class="form-group">
																<label for="message-text" class="col-form-label">Message:</label>
																<textarea class="form-control" id="message-text"
																	name="noticeContent" required="required"><%=notice.getNoticeContent()%></textarea>
															</div>
															<div class="modal-footer">

																<button type="submit" class="btn btn-primary">Save</button>
															</div>
														</form>
													</div>

												</div>
											</div>
										</div>



									</div>
								</div>
								<div
									class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
									<div class="detials">
										<!-- 삭제 -->
										<a
											href="<%=request.getContextPath()%>/notice/deleteNoticeOneAction.jsp?noticeNo=<%=notice.getNoticeNo()%>">
											<h4>
												<button class="genric-btn primary-border circle">Delete</button>
											</h4>
										</a>
									</div>

									<div class="thumb">
										<a href="#"> <img class="img-fluid"
											src="assets/img/post/next.png" alt="">
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 댓글 -->
					<div class="comments-area">
						<h4>Comments</h4>
						<!-- 시작 -->
						<%
						ArrayList<Comment> list = CommentDao.selectCommentListByNo(noticeNo);

						for (Comment c : list) {
						%>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="assets/img/comment/comment_1.png" alt="">
									</div>
									<div class="desc">
										<!-- comment -->
										<p class="comment"><%=c.getCommentContent()%></p>
										<div class="d-flex justify-content-between">
											<div class="d-flex align-items-center">
												<!-- 작성자 -->
												<h5>
													<a href="#"><%=c.getManagerId()%></a>
												</h5>
												<!-- 작성일 -->
												<p class="date"><%=c.getCommentDate().substring(0, 16)%></p>
											</div>
											<!-- 삭제 -->
											<div class="reply-btn">
												<a
													href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=noticeNo%>"
													class="btn-reply text-uppercase">reply</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%
						}
						%>
						<!-- 끝 -->
						<!-- 댓글입력 -->
						<div class="comment-form">
							<h4>Leave a Reply</h4>
							<form class="form-contact comment_form"
								action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp"
								method="post" id="commentForm">
								<div class="row">
									<div class="col-12">
										<div class="form-group">
											<!-- 현재 noticeNo 사용 -->
											<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
											<textarea class="form-control w-100" name="commentContent"
												id="commentContent" cols="30" rows="9"
												placeholder="Write Comment"></textarea>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<input class="form-control" name="managerId" id="managerId"
												type="text" value="<%=manager.getManagerId()%>"
												readonly="readonly">
										</div>
									</div>
								</div>
								<div class="form-group">
									<button type="submit"
										class="button button-contactForm btn_1 boxed-btn">Send
										Message</button>
								</div>
							</form>
						</div>
					</div>
					<!-- 댓글끝 -->
				</div>
			</div>
		</div>
	</section>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>