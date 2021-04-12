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
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>

	<!-- rowPerPage별 페이징 -->
	<%
	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
	}

	// 페이지 당 행의 수
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
	}

	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;

	// 전체 행의 개수
	int totalRow = NoticeDao.totalCount();
	System.out.println(totalRow + "<-- NoticeDao의 totalRow"); // 디버깅

	// list 생성	
	ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow);
	%>

		 <!-- slider Area Start-->
        <div class="slider-area ">
            <!-- Mobile Menu -->
            <div class="single-slider slider-height2 d-flex align-items-center" data-background="<%=request.getContextPath()%>/assets/img/hero/contact_hero.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="hero-cap text-center">
                                <h2>NoticeList</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- slider Area End-->
	<div class="section-top-border">
		<div class="section-top-border">
			<div class="row">
				<div class="col-md-4">

					<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
					<form action="<%=request.getContextPath()%>/notice/noticeList.jsp"
						method="post">
						<select name="rowPerPage">
							<%
							for (int i = 10; i < 31; i += 5) {
								if (rowPerPage == i) {
							%>
							<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
							<option value=<%=i%> selected="selected"><%=i%></option>
							<%
							} else {
							%>
							<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
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
		<!-- 공지 추가 버튼 -->
		<button type="button" class="genric-btn primary-border"
			data-toggle="modal" data-target="#notice" data-whatever="@fat">add
			Notice</button>
		<div class="modal fade" id="notice" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">New Notice</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="<%=request.getContextPath()%>/notice/InsertNoticeAction.jsp" method="post">
							<input type="hidden" name="managerId"
								value="<%=manager.getManagerId()%>">
							<div class="form-group">
								<label for="recipient-name" class="col-form-label">Title:</label>
								<input type="text" name="noticeTitle" required="required"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="message-text" class="col-form-label">Content:</label>
								<textarea class="form-control" id="message-text"
									name="noticeContent"></textarea>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="progress-table-wrap">
			<div class="progress-table">
				<div class="table-head">
					<div class="serial">noticeNo</div>
					<div class="country">
						<a href="#" class="genric-btn link">noticeTitle</a>
					</div>
					<div class="visit">managerId</div>
					<div class="percentage">noticeDate</div>
				</div>
				<%
				for (Notice n : list) { // for each문
				%>
				<div class="table-row">
					<div class="serial"><%=n.getNoticeNo()%></div>
					<div class="country">
						<a
							href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"
							class="genric-btn link"><%=n.getNoticeTitle()%></a>
					</div>
					<div class="visit"><%=n.getManagerId()%></div>
					<div class="percentage">
						<%=n.getNoticeDate().substring(0, 10)%>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>

	</div>

	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<%
	// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
	if (currentPage > 1) {
	%>
	<a
		href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>"><button
			class="genric-btn primary-border">prev</button></a>
	<%
	}

	// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
	lastPage += 1; // lastPage = lastPage+1; lastPage++;
	}

	if (currentPage < lastPage) {
	%>
	<a
		href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>"><button
			class="genric-btn primary-border">next</button></a>
	<%
	}
	%>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>