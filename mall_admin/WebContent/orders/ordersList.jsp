<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>
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
	<!-- 인클루드 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>


	<%
	// rowPerPage별 페이징
	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이지당 행의 수 
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	// 시작행
	int beginRow = (currentPage - 1) * rowPerPage;

	// 전체 행의수 메서드 호출
	int totalRow = OrdersDao.totalCount();
	// 디버깅
	System.out.println(totalRow + "<-- OrdersDao의 totalRow");
	// 목록메서드 호출
	ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersByList(rowPerPage, beginRow);
	// 링크
	String ebookISBN = request.getParameter("ebookISBN");
	%>
	<!-- 테이블 -->
	<div class="section-top-border">
		<div class="section-top-border">
			<h1 class="mb-30">OrdersList</h1>
			<div class="row">
				<div class="col-md-4">
					<div class="single-defination">
						<!-- 페이지 골라보기 -->
						<form action="<%=request.getContextPath()%>/orders/ordersList.jsp"
							method="post">
							<select name="rowPerPage">
								<%
								for (int i = 10; i <= 30; i += 5) {
									if (rowPerPage == i) {
								%>
								<!-- 선택한 개수만큼 행이 보임 -->
								<option value=<%=i%> selected="selected"><%=i%></option>
								<%
								} else {
								%>
								<option value=<%=i%>><%=i%></option>
								<%
								}
								}
								%>
							</select>
							<button type="submit" class="genric-btn primary-border">view</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="progress-table-wrap">
			<div class="progress-table">
				<div class="table-head">
					<div class="serial">ordersNo</div>
					<div class="serial">ebookNo</div>
					<div class="serial">clientNo</div>
					<div class="serial">ebookTitle</div>
					<div class="serial">clientMail</div>
					<div class="serial">ordersDate</div>
					<div class="serial">ordersState</div>
				</div>
				<%
				for (OrdersAndEbookAndClient o : list) {
				%>
				<div class="table-row">
					<div class="serial"><%=o.getOrders().getOrdersNo()%></div>
					<div class="serial"><%=o.getOrders().getEbookNo()%></div>
					<div class="serial"><%=o.getOrders().getClientNo()%></div>
					<div class="serial"><%=o.getEbook().getEbookTitle()%></div>

					<div class="serial"><%=o.getClient().getClientMail()%></div>
					<div class="serial"><%=o.getOrders().getOrdersDate().substring(0, 10)%></div>
					<!-- 상태수정 -->
					<div class="serial">
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary" data-toggle="modal"
							data-target="#exampleModal">
							<%=o.getOrders().getOrdersState()%>
						</button>
						<!-- Modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">State</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form
											action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp"
											method="post">
											<input type="hidden" value="<%=o.getOrders().getOrdersNo()%>"
												name="ordersNo">
											<div class="serial">
												<input type="hidden" value="<%=rowPerPage%>"
													name="rowPerPage"> <input type="hidden"
													value="<%=currentPage%>" name="currentPage"> <select
													name="ordersState">
													<%
													String[] ordersStateList = { "주문완료", "주문취소" };

													for (int i = 0; i < ordersStateList.length; i++) {
													%>
													<option value="<%=ordersStateList[i]%>"><%=ordersStateList[i]%></option>
													<%
													}
													%>
												</select>
											</div>
											<div class="modal-footer">
												<button type="submit" class="btn btn-primary">State
													changes</button>
											</div>
										</form>
									</div>

								</div>
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
		<!-- 페이징 -->
		<%
		if (currentPage > 1) { // 현재 페이지가 첫페이지가 아니면 이전버튼 생성
		%>
		<a
			href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>"><button class="genric-btn primary-border">prev</button></a>
		<%
		}

		int lastPage = totalRow / rowPerPage; // 마지막 페이지
		if (totalRow % rowPerPage != 0) { // 나머지가 0이아니면
		lastPage += 1;
		System.out.println("lastPage : " + lastPage);
		}
		if (currentPage < lastPage) { // 현재 페이지가 마지막페이지가 아니면 다음버튼 생성
		%>
		<a
			href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>"><button class="genric-btn primary-border">next</button></a>
		<%
		}
		%>
		<!-- footer include -->
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
</body>
</html>