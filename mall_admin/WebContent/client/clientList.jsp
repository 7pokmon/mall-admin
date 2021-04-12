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
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
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
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;

	//검색어설정
	// 초기화
	String searchWord = "";
	if (request.getParameter("searchWord") != null) { // 검색어가 존재하면
		searchWord = request.getParameter("searchWord"); // 검색어불러옴
	}

	// ClientDao 메서드 호출
	// 전체 행의 수
	int totalRow = ClientDao.totalCount(searchWord);
	System.out.println(totalRow + "<--totalRow");
	// 목록,검색어
	ArrayList<Client> list = ClientDao.selectClientByPage(rowPerPage, beginRow, searchWord);
	%>
	<!-- slider Area Start-->
	<div class="slider-area ">
		<!-- Mobile Menu -->
		<div class="single-slider slider-height2 d-flex align-items-center"
			data-background="<%=request.getContextPath()%>/assets/img/hero/contact_hero.jpg">
			<div class="container">
				<div class="row">
					<div class="col-xl-12">
						<div class="hero-cap text-center">
							<h2>ClientList</h2>
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
					<div class="single-defination">
						<form action="<%=request.getContextPath()%>/client/clientList.jsp"
							method="post">
							<input type="hidden" name="searchWord" value="<%=searchWord%>">
							<select name="rowPerPage">
								<%
								for (int i = 10; i <= 30; i += 5) {
									if (rowPerPage == i) {
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
							<button type="submit" class="genric-btn primary-border">View</button>
						</form>
					</div>
				</div>
				<div class="col-md-4">
					<div class="single-defination">
						<form action="<%=request.getContextPath()%>/client/clientList.jsp"
							method="post">
							<!-- rowPerPage 보내지않을시 연동되지않음 -->
							<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
							<div>
								<input type="text" name="searchWord">
								<button type="submit" class="genric-btn primary-border small">Search Mail</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="progress-table-wrap">
			<div class="progress-table">
				<div class="table-head">
					<div class="country">mail</div>
					<div class="country">date</div>
					<div class="country">update</div>
					<div class="country">delete</div>
				</div>
				<%
				for (Client c : list) {
				%>
				<div class="table-row">
					<div class="country"><%=c.getClientMail()%></div>
					<div class="country"><%=c.getClientDate().substring(0, 11)%></div>
					<div class="country">
	<!-- Button trigger modal -->
<button type="button" class="genric-btn primary-border circle" data-toggle="modal" data-target="#Client">
  Update
</button>
<!-- Modal -->
<div class="modal fade" id="Client" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Client</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
<!-- clientPw 수정 -->
	<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post">
		<table>	
			<tr>
				<th>clientMail</th>
				<th>clientPw</th>
			</tr>
			<tr>
				<td><%=c.getClientMail()%></td>
				<td>
					<!-- clientMail은 수정하지않고 Action으로 보내기위해서 hidden -->
					<input type="hidden" name="clientMail" value="<%=c.getClientMail()%>">
					<input type="text" name="clientPw">
				</td>
			</tr>
		</table>	
		<div class="modal-footer">
        <button type="submit" class="btn btn-primary">Save changes</button>
      </div>
	</form>
      </div>
      
    </div>
  </div>
</div>
					</div>
					<div class="country">
						<a
							href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button
								class="genric-btn primary-border circle">delete</button></a>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<%
	if (currentPage > 1) { // 현재 페이지가 첫페이지가 아니면 이전버튼 생성
	%>
	<a
		href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
		<button class="genric-btn primary-border">prev</button>
	</a>
	<%
	}

	int lastPage = totalRow / rowPerPage; // 마지막 페이지

	if (totalRow % rowPerPage != 0) { //나머지가 0이아니면
	lastPage += 1;
	//System.out.println("lastPage : " + lastPage);
	}
	if (currentPage < lastPage) { // 현재 페이지가 마지막페이지가 아니면 다음버튼 생성
	%>
	<a
		href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
		<button class="genric-btn primary-border">next</button>
	</a>
	<%
	}
	%>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>