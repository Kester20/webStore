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
<title><fmt:message var="titleLaptopUpdate"
		key="titleLaptopUpdate" bundle="${b }" /></title>
</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>

				<fmt:message var="updaetbutton" key="updaetbutton" bundle="${b }" />

				<c:set var="id" value='<%=request.getParameter("id")%>'></c:set>
				<c:set var="q"
					value='SELECT laptop.id,producer.producer,CPU.CPU,laptop.screen,
		screenResolution.screenRes,laptop.RAM,laptop.amountHardDrive,laptop.color,laptop.weight,
		videoCard.video,laptop.guarantee,laptop.price,laptop.image,laptop.model
		 FROM `laptop` INNER JOIN producer ON laptop.producer = producer.id 
		INNER JOIN CPU ON laptop.CPU = CPU.id 
		INNER JOIN screenResolution ON laptop.screenResolution = screenResolution.id 
		INNER JOIN videoCard ON laptop.videoCard = videoCard.id WHERE laptop.id = ${id}'></c:set>

				<sql:query dataSource="${ws}" var="query" sql="${q}"></sql:query>

				<c:forEach var="laptop" items="${query.rows}" varStatus="row">

					<h2 align="center" style="font-size: x-large; font-weight: 200;">${titleLaptopUpdate }</h2>




					<div id="form">
						<form action="AddLaptop?action=update&id=${id}" method="post"
							style="text-align: center;">

							<table style="background: #eeeeec; border-collapse: collapse;"
								border="1" align="center">
								<tr>
									<th width="500px;"><fmt:message key="parameters"
											bundle="${b }" /></th>
									<th width="500px;"><fmt:message key="value" bundle="${b }" /></th>

								</tr>
								<tr>
									<td><label for="model"><fmt:message
												key="modelAddLaptop" bundle="${b}" /></label></td>
									<td><input type="text" name="model" style="width: 200px;"
										value="${laptop.model}"></td>
								</tr>
								<tr>
									<td><label for="producer"><fmt:message
												key="producerAddLaptop" bundle="${b}" /></label></td>
									<td><select name="producer" style="width: 200px;">
											<option>${laptop.producer}</option>
											<c:forEach var="producer" items="${producer.rows}"
												varStatus="row">
												<option value="${producer.producer}">${producer.producer}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td><label for="CPU"><fmt:message
												key="CPUAddLaptop" bundle="${b}"></fmt:message></label></td>
									<td><select id="CPU" name="CPU" style="width: 200px;">
											<option>${laptop.CPU}</option>
											<c:forEach var="CPU" items="${CPU.rows}" varStatus="row">
												<option value="${CPU.CPU}">${CPU.CPU}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td><label for="RAM">RAM</label></td>
									<td><input type="number" id="RAM" name="RAM"
										style="width: 200px;" min="1" max="192" required
										value="${laptop.RAM}"></td>
								</tr>
								<tr>
									<td><label for="screen"><fmt:message
												key="screenAddLaptop" bundle="${b}" /></label></td>
									<td><select name="screen" style="width: 200px;">
											<option selected>${laptop.screen}</option>
											<option value="9">9"</option>
											<option value="13">13"</option>
											<option value="15">15"</option>
											<option value="17">17"</option>

									</select></td>
								</tr>
								<tr>
									<td><label for="screenResolution"><fmt:message
												key="screenResAddLaptop" bundle="${b}" /></label></td>
									<td><select name="screenResolution" style="width: 200px;">
											<option selected>${laptop.screenRes}</option>
											<c:forEach var="screenResolution"
												items="${screenResolution.rows}" varStatus="row">
												<option value="${screenResolution.screenRes}">${screenResolution.screenRes}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td><label for="amountHardDrive"><fmt:message
												key="amountAddLaptop" bundle="${b}" /></label></td>
									<td><input type="number" value="${laptop.amountHardDrive}"
										name="amountHardDrive" min="150" max="10000" required
										style="width: 200px;"></td>
								</tr>
								<tr>
									<td><label for="color"><fmt:message
												key="colorAddLaptop" bundle="${b}" /></label></td>
									<td><input type="text" value="${laptop.color}"
										name="color" style="width: 200px;" required></td>
								</tr>
								<tr>
									<td><label for="weight"><fmt:message
												key="weightAddLaptop" bundle="${b}" /></label></td>
									<td><input type="number" value="${laptop.weight}"
										name="weight" style="width: 200px;" required></td>
								</tr>
								<tr>
									<td><label for="videoCard"><fmt:message
												key="videoCardAddLaptop" bundle="${b}" /></label></td>
									<td><select name="videoCard" style="width: 200px;">
											<option selected>${laptop.video}</option>
											<c:forEach var="videoCard" items="${videoCard.rows}"
												varStatus="row">
												<option value="${videoCard.video}">${videoCard.video}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td><label for="guarantee"><fmt:message
												key="guaranteeAddLaptop" bundle="${b}" /></label></td>
									<td><input type="number" value="${laptop.guarantee}"
										name="guarantee" style="width: 200px;" required></td>
								</tr>
								<tr>
									<td><label for="price"><fmt:message
												key="priceAddLaptop" bundle="${b}" /></label></td>
									<td><input type="number" value="${laptop.price}"
										name="price" style="width: 200px;" required></td>
								</tr>


								<tr>
									<td colspan="3"><input type="submit"
										value="${updaetbutton }"></td>
								</tr>
							</table>
						</form>
					</div>

				</c:forEach>
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
</html>