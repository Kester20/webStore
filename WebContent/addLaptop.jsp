<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<c:if test="${sessionScope.admin == null}">
	<%
		response.sendRedirect("admin.jsp");
	%>
</c:if>

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />

<sql:query dataSource="${ws}" sql="select * from producer"
	var="producer"></sql:query>
<sql:query dataSource="${ws}" sql="select * from CPU" var="CPU"></sql:query>
<sql:query dataSource="${ws}" sql="select * from screenResolution"
	var="screenResolution"></sql:query>
<sql:query dataSource="${ws}" sql="select * from videoCard"
	var="videoCard"></sql:query>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<title><fmt:message key="titleAddLaptop" bundle="${b}"
		var="titleAddLaptop" /></title>
</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>

				<h2 align="center" style="font-size: x-large; font-weight: 200;">${titleAddLaptop}</h2>



				<div id="form">
					<form action="AddLaptop?action=add" method="post"
						style="text-align: center;">
						<label for="producer"><fmt:message key="producerAddLaptop"
								bundle="${b}"></fmt:message></label><br> <select name="producer">
							<c:forEach var="producer" items="${producer.rows}"
								varStatus="row">
								<option value="${producer.producer}">${producer.producer}</option>
							</c:forEach>
						</select><br> <label for="model"><fmt:message
								key="modelAddLaptop" bundle="${b}" /></label><br> <input
							type="text" name="model" required><br> <label
							for="CPU"><fmt:message key="CPUAddLaptop" bundle="${b}"></fmt:message></label><br>
						<select id="CPU" name="CPU">
							<c:forEach var="CPU" items="${CPU.rows}" varStatus="row">
								<option value="${CPU.CPU}">${CPU.CPU}</option>
							</c:forEach>
						</select><br> <label for="RAM">RAM</label><br> <input
							type="number" name="RAM" min="1" max="192" required><br>

						<label for="screen"><fmt:message key="screenAddLaptop"
								bundle="${b}" /></label><br> <select name="screen">

							<option value="9">9"</option>
							<option value="13">13"</option>
							<option value="15">15"</option>
							<option value="17">17"</option>

						</select><br> <label for="screenResolution"><fmt:message
								key="screenResAddLaptop" bundle="${b}" /></label><br> <select
							name="screenResolution">
							<c:forEach var="screenResolution"
								items="${screenResolution.rows}" varStatus="row">
								<option value="${screenResolution.screenRes}">${screenResolution.screenRes}</option>
							</c:forEach>
						</select><br> <label for="amountHardDrive"><fmt:message
								key="amountAddLaptop" bundle="${b}" /></label><br> <input
							type="number" name="amountHardDrive" min="150" max="10000"
							required><br> <label for="color"><fmt:message
								key="colorAddLaptop" bundle="${b}" /></label><br> <input
							type="text" name="color" required><br> <label
							for="weight"><fmt:message key="weightAddLaptop"
								bundle="${b}" /></label><br> <input type="number" name="weight"
							required><br> <label for="videoCard"><fmt:message
								key="videoCardAddLaptop" bundle="${b}" /></label><br> <select
							name="videoCard">
							<c:forEach var="videoCard" items="${videoCard.rows}"
								varStatus="row">
								<option value="${videoCard.video}">${videoCard.video}</option>
							</c:forEach>
						</select><br> <label for="guarantee"><fmt:message
								key="guaranteeAddLaptop" bundle="${b}" /></label><br> <input
							type="number" name="guarantee" required><br> <label
							for="price"><fmt:message key="priceAddLaptop"
								bundle="${b}" /></label><br> <input type="number" name="price"
							required><br> <br> 

						<fmt:message var="submitAdd" key="submitAdd" bundle="${b}"></fmt:message>
						<input type="submit" value="${submitAdd}">
					</form>
				</div>

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
<script type='text/javascript' src='js/scrollUp.js'></script>
</html>