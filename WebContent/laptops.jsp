<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />

<sql:query dataSource="${ws}" sql="select * from producer"
	var="producer"></sql:query>
<sql:query dataSource="${ws}" sql="select * from CPU" var="CPU"></sql:query>

<sql:query dataSource="${ws}" sql="select * from videoCard"
	var="videoCard"></sql:query>

<!DOCTYPE html >
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="laptops" bundle="${b }" /></title>
<link rel="stylesheet" type="text/css" href="css/page.css">
<link rel="stylesheet" type="text/css" href="css/catalog.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
</head>

<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<c:set var="nextPage" value='<%=request.getParameter("nextPage")%>'></c:set>
				<c:set var="action" value='<%=request.getParameter("action")%>'></c:set>

				<fmt:message var="BUY" key="BUY" bundle="${b }" />
				<fmt:message var="UPDATE" key="UPDATE" bundle="${b }" />
				<fmt:message var="DELETE" key="DELETE" bundle="${b }" />
				<fmt:message var="Laptops" key="laptops" bundle="${b}"></fmt:message>
				<fmt:message var="chooseForUpdate" key="chooseForUpdate"
					bundle="${b}"></fmt:message>
				<fmt:message var="chooseForDelete" key="chooseForDelete"
					bundle="${b}"></fmt:message>
				<fmt:message var="money" key="money" bundle="${b }" />

				<%-- 	<c:out value="${nextPage}"></c:out> --%>

				<jsp:include page="menubar.jsp"></jsp:include>

				<c:choose>
					<c:when test="${nextPage=='laptop.jsp?id='}">
						<c:set var="word" value="${BUY}"></c:set>
						<c:set var="title" value="${Laptops}"></c:set>
					</c:when>
					<c:when test="${nextPage=='updateLaptop.jsp?id='}">
						<c:if test="${sessionScope.admin == null}">
							<%
								response.sendRedirect("admin.jsp");
							%>
						</c:if>
						<c:set var="word" value="${UPDATE}"></c:set>
						<c:set var="title" value="${ chooseForUpdate}"></c:set>
					</c:when>
					<c:when test="${action=='delete'}">
						<c:if test="${sessionScope.admin == null}">
							<%
								response.sendRedirect("admin.jsp");
							%>
						</c:if>

						<c:set var="word" value="${DELETE}"></c:set>
						<c:set var="title" value="${chooseForDelete }"></c:set>
					</c:when>
				</c:choose>
				<h2 align="center" style="font-size: x-large; font-weight: 200;">${title}</h2>

				<c:if test="${not empty f}">
					<div>
						<a href="laptops.jsp?nextPage=${nextPage}"
							style="font-size: large; font-weight: 200; color: red;"><fmt:message
								key="resetFilters" bundle="${b }" /></a>
					</div>
				</c:if>

				<div style="color: red;">
					<c:out value="${f}"></c:out>
				</div>

				<c:if test="${empty query}">
					<c:set var="query"
						value="SELECT laptop.id,producer.producer,CPU.CPU,laptop.screen,
		screenResolution.screenRes,laptop.RAM,laptop.amountHardDrive,laptop.color,laptop.weight,
		videoCard.video,laptop.guarantee,laptop.price,laptop.image,laptop.model
		 FROM `laptop` INNER JOIN producer ON laptop.producer = producer.id 
		INNER JOIN CPU ON laptop.CPU = CPU.id INNER JOIN screenResolution ON laptop.screenResolution = screenResolution.id 
		INNER JOIN videoCard ON laptop.videoCard = videoCard.id "></c:set>
				</c:if>

				<sql:query dataSource="${ws}" sql="${query}" var="laptop"></sql:query>

				<%-- 			<c:out value="${query}"></c:out>  --%>

				<section class="main-content">

					<table class="table"
						style="background: #eeeeec; border-collapse: collapse; width: 10%;"
						border="1">

						<tbody>

							<c:set var="i" value="1"></c:set>

							<c:forEach var="laptop" items="${laptop.rows}" varStatus="row">

								<c:if test="${title==Laptops}">
									<c:set var="word" value="${BUY} ${laptop.price} ${money}"></c:set>
								</c:if>
								<td>
									<div class="product">

										<div class="photo" data-title="${word}">
											<c:choose>
												<c:when test="${action=='delete'}">
													
													
													
													<a href="AddLaptop?action=delete&id=${laptop.id}"> <img
														src="${pageContext.request.contextPath}${laptop.image}"
														width="240px;" height="150px;">
													</a>
												</c:when>
												<c:otherwise>
													<a href="${nextPage}${laptop.id}"><img alt=""
														src="${pageContext.request.contextPath}${laptop.image}"
														width="240px;" height="150px;"></a>
												</c:otherwise>
											</c:choose>
										</div>
										<br>
										<div class="footer" style="color: #3465a4; font-weight: bold;">

											${laptop.producer} | ${laptop.CPU} | ${laptop.RAM} GB |<br>
											${laptop.video} | ${laptop.amountHardDrive} GB <br>
										</div>

									</div>
								</td>
								<c:set var="i" value="${i+1}"></c:set>
								<c:if test="${i == 5}">
									<c:set var="i" value="1"></c:set>
									<tr></tr>
								</c:if>
							</c:forEach>


						</tbody>

					</table>
				</section>

				<fmt:message var="chooseFilters" key="chooseFilters" bundle="${b }"></fmt:message>

				<aside class="aside" style="">
					<div>

						<form action="Checkboxes?nextPage=${nextPage}" method="post"
							style="border: 1px solid; font-size: 12px; width: 160px;"
							name="checkbox">

							<input type="submit" value="${chooseFilters }"
								style="width: 160px; font-size: 15px;">

							<hr>
							<div class="masonry" style="width: 180px;">

								<h4>
									<fmt:message key="priceAddLaptop" bundle="${b}" />
								</h4>
								<div id="amountVal">

									<input type="text" name="amount" id="amount"
										style="font-size: 14px; width: 77px; text-align: left;">
									-<input type="text" id="amount_1" name="amount1"
										style="font-size: 14px; width: 77px; text-align: left;">
								</div>
								<div id="slider-range" style="width: 146px; margin-left: 5px"></div>
							</div>

							<br>
							<hr>

							<h4>
								<fmt:message key="sorting" bundle="${b }" />
							</h4>
							<select name="expen" style="width: 160px; font-size: 15px;">
								<option value=""><fmt:message key="without"
										bundle="${b }"></fmt:message></option>
								<option value="less"><fmt:message key="less"
										bundle="${b }" /></option>
								<option value=">"><fmt:message key="more"
										bundle="${b }" /></option>
							</select>

							<hr>

							<h4>
								<fmt:message key="producerAddLaptop" bundle="${b}" />
							</h4>
							<c:forEach var="producer" items="${producer.rows}"
								varStatus="row">
								<input type="checkbox" value="${producer.producer}"
									name="prodBox" id="prodBox">
								<label for="prodBox" id="prodBox">${producer.producer}</label>
								<br>
							</c:forEach>
							<hr>
							<h4>
								<fmt:message key="CPUAddLaptop" bundle="${b}"></fmt:message>
							</h4>
							<c:forEach var="CPU" items="${CPU.rows}" varStatus="row">
								<input type="checkbox" value="${CPU.CPU}" name="CPUBox">
								<label for="CPUBox" id="CPUBox">${CPU.CPU}</label>
								<br>
							</c:forEach>
							<hr>
							<h4>RAM</h4>

							<input type="checkbox" value="0, 4" name="RAMBox"> <label
								for="RAMBox" id="RAMBox">< 4 GB</label><br> <input
								type="checkbox" value="4, 6" name="RAMBox"> <label
								for="RAMBox" id="RAMBox"> 4-6 GB</label><br> <input
								type="checkbox" value="8,10" name="RAMBox"> <label
								for="RAMBox" id="RAMBox"> 8-10 GB</label><br> <input
								type="checkbox" value="12,192" name="RAMBox"> <label
								for="RAMBox" id="RAMBox"> >12 GB</label><br>

							<hr>
							<h4>
								<fmt:message key="videoCardAddLaptop" bundle="${b}" />
							</h4>
							<c:forEach var="videoCard" items="${videoCard.rows}"
								varStatus="row">
								<input type="checkbox" value="${videoCard.video}"
									name="videoCardBox">
								<label for="videoCardBox" id="videoCardBox">${videoCard.video}</label>
								<br>
							</c:forEach>
							<hr>
							<h4>
								<fmt:message key="amountAddLaptop" bundle="${b}" />
							</h4>

							<input type="checkbox" value="0, 500" name="amountHardDriveBox">
							<label for="amountHardDriveBox" id="amountHardDriveBox"><
								500 GB </label><br> <input type="checkbox" value="500, 750"
								name="amountHardDriveBox"> <label
								for="amountHardDriveBox" id="amountHardDriveBox">500-750
								GB </label><br> <input type="checkbox" value="1000, 2000"
								name="amountHardDriveBox"> <label
								for="amountHardDriveBox" id="amountHardDriveBox">1-2 TB
							</label><br> <input type="checkbox" value="2000, 10000"
								name="amountHardDriveBox"> <label
								for="amountHardDriveBox" id="amountHardDriveBox">> 2 TB
							</label>
							<hr>
							<br> <input type="submit" value="${ chooseFilters}"
								style="width: 160px; font-size: 15px;">
						</form>
					</div>
				</aside>

			</div>
		</div>
		<br style="clear: both">
		<div id="empty">&nbsp;</div>
		<div id="footer">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>

	<div id="scrollup">
		<img alt="Прокрутить вверх"
			src="${pageContext.request.contextPath}/images/up.png">
	</div>
</body>
<script type='text/javascript' src='js/deleteLaptop.js'></script>
<script type='text/javascript' src='js/scrollUp.js'></script>
<script type='text/javascript' src='js/expen.js'></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script src="js/slider.js"></script>
</html>
