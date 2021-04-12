<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="java.util.*"%>
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
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
	// 로그인 조건에 맞지않으면 돌려보냄
	Manager manager = (Manager)(session.getAttribute("sessionManager"));
	if(manager == null) {
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
	return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	}
	%>
	<%
		// rowPerPage별 페이징
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
		// 페이지당 행의 수 
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) { 
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		// 시작행
		int beginRow = (currentPage - 1) * rowPerPage ;
		
		ArrayList<Manager> list = ManagerDao.selectManagerList(rowPerPage, beginRow);
	%>
	 <!-- slider Area Start-->
        <div class="slider-area ">
            <!-- Mobile Menu -->
            <div class="single-slider slider-height2 d-flex align-items-center" data-background="<%=request.getContextPath()%>/assets/img/hero/contact_hero.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="hero-cap text-center">
                                <h2>managerList</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- slider Area End-->
	<div class="section-top-border">
				<div class="progress-table-wrap">
					<div class="progress-table">
						<div class="table-head">
							<div class="serial">No</div>
							<div class="country">Id</div>
							<div class="visit">Name</div>
							<div class="percentage">Date</div>
							<div class="percentage">Level</div>
							<div class="serial">Delete</div>
						</div>
				<%
				for(Manager m : list) {
				%>
				<div class="table-row">
					<div class="serial"><%=m.getManagerNo()%></div>
					<div class="country"><%=m.getManagerId()%></div>
					<div class="visit"><%=m.getManagerName()%></div>
					<div class="percentage"><%=m.getManagerDate()%></div>
					<div class="percentage">
						<!-- managerLevel 수정하기 -->
						<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
							<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
								<select name="managerLevel">
									<%
										for(int i=0; i<3; i++){
											if(m.getManagerLevel() == i) {
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
					<div class="serial"><a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>"><button class="genric-btn primary-border circle">delete</button></a></div>
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