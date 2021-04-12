<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!-- 인클루드 -->
    <header>
        <!-- Header Start -->
       <div class="header-area">
            <div class="main-header ">
                <div class="header-top top-bg d-none d-lg-block">
                   <div class="container">
                    <div class="row justify-content-between align-items-center">
                        <div class="col-lg-8">
                            <div class="header-info-left">
                                <ul>                          
                                    <li>7pokmon@naver.com</li>
                                    <li>010 4148 7395</li>
                                    <li>LeeMinho</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="header-info-right f-right">
                                <ul class="header-social">    
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                                    <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                    <li><a href="#"><i class="fab fa-pinterest-p"></i></a></li>
                                    <li><a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                       </div>
                   </div>
                </div>
                <div class="header-bottom  header-sticky">
                    <div class="container">
                        <div class="row align-items-center">
                            <!-- Logo -->
                            <div class="col-xl-2 col-lg-2 col-md-1">
                                <div class="logo">
                                  <a href="index.html"><img src="<%=request.getContextPath()%>/assets/img/logo/logo.png" alt=""></a>
                                </div>
                            </div>
                            <div class="col-xl-10 col-lg-10 col-md-10">
                                <!-- Main-menu -->
                                <div class="main-menu f-right d-none d-lg-block">
                                    <nav>               
                                        <ul id="navigation">                                                                                                                                     
                                            <li><a href="<%=request.getContextPath()%>/adminIndex.jsp">Home</a></li>
                                           	<li><a href="">management</a>
                                            <ul class="submenu">
                                          		<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp">Manager</a></li>
                                          		<li><a href="<%=request.getContextPath()%>/client/clientList.jsp">Client</a></li>
                                          		<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">category</a></li>
                                          	</ul>
                                          	</li>
                                            <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">E-book</a>
                                                <ul class="submenu">
                                                    <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">E-book</a></li>
                                                    <%
                                                  	    String categoryName = request.getParameter("categoryName");
														ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
															for(String st : categoryNameList){
													%>
														 <li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=st%>"><%=st%></a></li>
													<%		
														}
													%>
                                                </ul>
                                            </li>
                                            <li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">Orders</a></li>
                                            <li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">Notice</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- Mobile Menu -->
                            <div class="col-12">
                                <div class="mobile_menu d-block d-lg-none"></div>
                            </div>
                        </div>
                    </div>
               </div>
            </div>
       </div>
        <!-- Header End -->
    </header>