<%@page import="gdu.mall.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용 
		1) 관리자 로그인 폼
		2) 관리자 인증 화면 & 몰 메인페이지
	-->
	<%
	if (session.getAttribute("sessionManager") == null) { //로그인 안했을때(세션이 비어있을때)
	%>
	<!-- bt.s -->
	<!-- slider Area Start-->
	<main>
		<div class="slider-area ">
			<!-- Mobile Menu -->
			<div class="slider-active">
				<div
					data-background="<%=request.getContextPath()%>/assets/img/hero/h1_hero.jpg"
					class="single-slider hero-overly  slider-height d-flex align-items-center">
					<div class="container">
						<div class="row">
							<div class="col-xl-9 col-lg-9 col-md-9">
								<div class="hero__caption">
									<h1>
										Manager <span>Index</span>
									</h1>
									<p>Hello</p>
								</div>
							</div>
						</div>
						<!-- Search Box -->
						<div class="row">
							<div class="col-xl-12">
								<!-- form -->

								<div class="row">
									<div class="col-lg-8 col-md-8">
										<form
											action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp"
											method="post">
											<div class="mt-10">
												<input type="text" name="managerId"
													placeholder="enter your ID" onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'enter your ID'" required
													class="single-input">
											</div>
											<div class="mt-10">
												<input type="password" name="managerPw"
													placeholder="enter your Password"
													onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'enter your Password'" required
													class="single-input">
											</div>
											<div class="button-group-area mt-40">
												<button type="submit"
													class="genric-btn warning circle arrow">
													Login<span class="lnr lnr-arrow-right"></span>
												</button>
											</div>

										</form>
										<!-- Button trigger modal -->

									</div>

								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- slider Area End-->
		<!-- bt.s -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h3 class="mb-30">Waiting Manager list</h3>
				<button type="button" class="genric-btn primary-border"
					data-toggle="modal" data-target="#exampleModal">add
					Manager</button>
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">Insert Manager</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form
									action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp"
									method="post">
									<table>
										<tr>
											<td>ID</td>
											<td><input type="text" name="managerId"
													placeholder="" onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'ID'" required
													class="single-input"></td>
										</tr>
										<tr>
											<td>PW</td>
											<td><input type="text" name="managerPw"
													placeholder="" onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'Pw'" required
													class="single-input"></td>
										</tr>
										<tr>
											<td>NAME</td>
											<td><input type="text" name="managerName"
													placeholder="" onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'Name'" required
													class="single-input"></td>
										</tr>
									</table>
									<div class="modal-footer">
								<button type="submit" class="btn btn-primary">add</button>
							</div>
								</form>
							</div>
							
						</div>
					</div>
				</div>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="serial">#</div>
							<div class="country">managerId</div>
							<div class="visit">manageDate</div>
						</div>

						<%
						// 승인대기 메서드호출
						ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
						for (Manager m : list) {
						%>
						<div class="table-row">
							<div class="serial"><%=m.getManagerNo()%></div>
							<div class="country"><%=m.getManagerId()%></div>
							<div class="visit"><%=m.getManagerDate().substring(0, 10)%></div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<%
		} else {
		// getAttribute(String name) 세션 속성명이 name인 속성의 값을 Object 타입으로 리턴한다. 해당 되는 속성명이 없을 경우에는 null 값을 리턴한다.
		Manager manager = (Manager) (session.getAttribute("sessionManager"));
		%>
		<!-- 로그인 성공,유지시 화면 -->
		<div>
			<div class="slider-area ">
				<!-- Mobile Menu -->
				<div class="single-slider slider-height2 d-flex align-items-center"
					data-background="assets/img/hero/contact_hero.jpg">
					<div class="container">
						<div class="row">
							<div class="col-xl-12">
								<div class="hero-cap text-center">
									<h2>
										반갑습니다
										<%=manager.getManagerName()%>님 <br> Level :
										<%=manager.getManagerLevel()%>

									</h2>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 목록 5개씩 미리 보여주기 -->
		<%
		// 모든 목록 메서드 호출 5개씩만 요약해서 보여주고 자세히보기 링크
		ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
		ArrayList<Manager> Manager = ManagerDao.selectManagerList(5, 0);
		ArrayList<Client> clientList = ClientDao.selectClientByPage(5, 0, ""); // search issue ""처리
		String categoryName = request.getParameter("categoryName");
		ArrayList<Ebook> ebookList = EbookDao.ebookList(5, 0, categoryName); // categoryName issue 보류
		ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersByList(5, 0);
		%>
		<!-- 최근 등록한 공지 5개 -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h2>
					noticeList <a
						href="<%=request.getContextPath()%>/notice/noticeList.jsp">[more]</a>
				</h2>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="country">NoticeTitle</div>
							<div class="visit">ManagerId</div>
						</div>

						<%
						for (Notice n : noticeList) {
						%>
						<div class="table-row">
							<div class="country"><%=n.getNoticeTitle()%></div>
							<div class="visit"><%=n.getManagerId()%></div>
						</div>
						<%
						}
						%>

					</div>
				</div>
			</div>
		</div>
		<!-- 최근 가입한 관리자 5개 -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h2>
					Manager <a
						href="<%=request.getContextPath()%>/manager/managerList.jsp">[more]</a>
				</h2>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="country">NoticeTitle</div>
							<div class="visit">ManagerId</div>
						</div>

						<%
						for (Manager m : Manager) {
						%>
						<div class="table-row">
							<div class="country"><%=m.getManagerId()%></div>
							<div class="visit"><%=m.getManagerName()%></div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<!-- 최근 가입한 고객 5개 -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h2>
					clientList <a
						href="<%=request.getContextPath()%>/client/clientList.jsp">[more]</a>
				</h2>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="country">ClientMail</div>
							<div class="visit">ClientDate</div>
						</div>

						<%
						for (Client c : clientList) {
						%>
						<div class="table-row">
							<div class="country"><%=c.getClientMail()%></div>
							<div class="visit"><%=c.getClientDate().substring(0, 10)%></div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<!-- 최근 등록한 상품(Ebook) 5개 -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h2>
					ebookList <a
						href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[more]</a>
				</h2>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="country">EbookTitle</div>
							<div class="visit">EbookPrice</div>
						</div>
						<%
						for (Ebook e : ebookList) {
						%>
						<div class="table-row">
							<div class="country"><%=e.getEbookTitle()%></div>
							<div class="visit"><%=e.getEbookPrice()%></div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<!-- 최근 주문한 상품 5개 -->
		<div class="container box_1170 border-top-generic">
			<div class="section-top-border">
				<h2>
					oecList <a
						href="<%=request.getContextPath()%>/orders/ordersList.jsp">[more]</a>
				</h2>
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="serial">OrdersNo</div>
							<div class="country">EbookTitle</div>
							<div class="visit">ClientMail</div>
						</div>
						<%
						for (OrdersAndEbookAndClient oec : oecList) {
						%>
						<div class="table-row">
							<div class="serial"><%=oec.getOrders().getOrdersNo()%></div>
							<div class="country"><%=oec.getEbook().getEbookTitle()%></div>
							<div class="visit"><%=oec.getClient().getClientMail()%></div>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</main>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>