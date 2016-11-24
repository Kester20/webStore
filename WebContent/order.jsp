<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.HashMap"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<c:if test="${sessionScope.client == null}">
	<%
		response.sendRedirect("#registr");
	%>
</c:if>

<%
	HashMap list = (HashMap) session.getAttribute("list");
%>
<c:if test="<%=list == null || list.size() == 0%>">
	<%
		response.sendRedirect("index.jsp");
	%>
</c:if>

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />

<sql:query dataSource="${ws}"
	sql="select * from client where client.id = '${sessionScope.clientId }'"
	var="client"></sql:query>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/page.css">

<style type="text/css">
label {
	color: #204a87;
}

input[type="radio"] {
	display: none;
}

input[type="radio"]+label {
	color: $DarkBrown;
	font-family: Arial, sans-serif;
	font-size: 14px;
}

input[type="radio"]+label span {
	display: inline-block;
	width: 19px;
	height: 19px;
	margin: -1px 4px 0 0;
	vertical-align: middle;
	cursor: pointer;
	-moz-border-radius: 50%;
	border-radius: 50%;
}

input[type="radio"]+label span {
	background-color: white;
	border: 1px solid black;
}

input[type="radio"]:checked+label span {
	background-color: #3465a4;
}

input[type="radio"]+label span, input[type="radio"]:checked+label span {
	-webkit-transition: background-color 0.4s linear;
	-o-transition: background-color 0.4s linear;
	-moz-transition: background-color 0.4s linear;
	transition: background-color 0.4s linear;
}
</style>

<title>Insert title here</title>
</head>
<body>

	<div id="all">
		<div id="main">
			<div id="content">


				<jsp:include page="menubar.jsp"></jsp:include>

				<c:set var="list" value="${sessionScope.list}"></c:set>

				<h2 align="center" style="font-size: x-large; font-weight: 200;">
					<fmt:message key="orderMaking" bundle="${b }" />
				</h2>

				<div style="float: right; height: 500px; width: 500px;">
					<h2 align="center" style="font-size: x-large; font-weight: 200;">
						<fmt:message key="yourOrder" bundle="${b }" />
					</h2>
					<h3 align="center"
						style="text-decoration: underline; font-size: larger;;; font-weight: 200;">
						<fmt:message key="orderCost" bundle="${b }" />
						<span>${sessionScope.cost}</span>
						<fmt:message key="money" bundle="${b }" />
						,
						<fmt:message key="in_an_amount" bundle="${b }" />
						<span>${sessionScope.quantity} <fmt:message key="n" bundle="${b }" /></span>
					</h3>

					<table border="1"
						style="width: 100%; text-align: center; border-collapse: collapse;">
						<c:forEach var="list" items="${list}">
							<c:set var="q"
								value='SELECT laptop.id,producer.producer,laptop.guarantee,laptop.price,laptop.image,laptop.model 
					FROM `laptop` INNER JOIN producer ON laptop.producer = producer.id  WHERE laptop.id = ${list.key}'></c:set>
							<sql:query dataSource="${ws}" var="query" sql="${q}"></sql:query>

							<c:forEach var="laptop" items="${query.rows}" varStatus="row">

								<tr>
									<td width="30%"><a href="laptop.jsp?id=${laptop.id}"><img
											style="margin-top: 10px;"
											src="${pageContext.request.contextPath}${laptop.image}"
											width="80px;" height="50px;"></a></td>
									<td>${laptop.producer}</td>
									<td>${laptop.price}<fmt:message key="money" bundle="${b }" /></td>

								</tr>

							</c:forEach>
						</c:forEach>
						<tr>

							<td colspan="3"><a href="#cart"
								style="text-decoration: underline; color: #204a87"><fmt:message
										key="updatethisOrder" bundle="${b }" /></a></td>
						</tr>
					</table>

				</div>


				<c:forEach var="client" items="${client.rows}" varStatus="row">

					<c:set var="tdW" value="500px;"></c:set>
					<div id="form">
						<form
							action="OrderServlet?cost=${cost}&id=${sessionScope.clientId}&list=${sessionScope.list}"
							method="post"
							style="text-align: left; float: left; background-color: #b9bff9; border: 1px solid #204a87; border-radius: 10px;">
							<label for="name"><fmt:message key="yourName"
									bundle="${b }" /></label><br> <input type="text" name="name"
								readonly value="${client.name}" style="width: ${tdW}"> <br>
							<label for="phone"><fmt:message key="yourPhone"
									bundle="${b }" /></label><br> <input type="tel"
								style="width: ${tdW}" name="phone" readonly
								value="${client.phone}"><br> <label for="town"><fmt:message
									key="city" bundle="${b }" /></label> <br> <input type="text"
								name="town" style="width: ${tdW}" id="town" required
								value="${client.town}"><br> <label for="street"><fmt:message
									key="street" bundle="${b }" /></label><br> <input type="text"
								style="width: ${tdW}" name="street" required
								value="${client.street}"><br> <label for="house"><fmt:message
									key="house" bundle="${b }" /></label><br> <input type="text"
								name="house" style="width: ${tdW}" required maxlength="5"
								value="${client.house}"><br>

							<hr>
							<table style="width: 500px; text-align: left;" align="left"
								style="border: 1px solid #ddd;background: red;">
								<tr>
									<td><label for=""><fmt:message key="typePay"
												bundle="${b }" /></label></td>
									<td><input type="radio" name="typePayment" checked
										value="cash" id="radio1"> <label for="radio1"><span></span>
											<fmt:message key="nal" bundle="${b }" /></label></td>
								</tr>

								<tr>
									<td></td>
									<td><input type="radio" name="typePayment" value="credit"
										id="radio2"> <label for="radio2"><span></span>
											<fmt:message key="credit" bundle="${b }" /></label></td>
								<tr>
									<td></td>
									<td><input type="radio" name="typePayment" value="card"
										id="radio3"> <label for="radio3"><span></span>
											<fmt:message key="card" bundle="${b }" /></label></td>
								</tr>
								<tr>
								<tr />
								<tr>
								<tr />


								<tr>
									<td colspan="3"><hr></td>

								</tr>

								<tr>
									<td><label for=""><fmt:message key="typeRec"
												bundle="${b }" /></label></td>
									<td><input type="radio" name="typeReceipt" value="post"
										id="radio5"> <label for="radio5"><span></span>
											<fmt:message key="newMail" bundle="${b }" /></label></td>
								</tr>

								<tr>
									<td></td>
									<td><input type="radio" name="typeReceipt" checked
										value="pickup" id="radio4"> <label for="radio4"><span></span>
											<fmt:message key="pickUp" bundle="${b }" /></label></td>
								</tr>


								<tr>
									<td></td>
									<td><input type="radio" name="typeReceipt" value="courier"
										id="radio6"> <label for="radio6"><span></span>
											<fmt:message key="courier" bundle="${b }" /></label></td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>

								</tr>

							</table>

							<fmt:message var="okOrder" key="okOrder" bundle="${b }" />

							<br> <br> <br> <input type="submit"
								value="${okOrder }" style="width: 100%;">
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

	<script type='text/javascript' src='js/scrollUp.js'></script>
</body>
</html>