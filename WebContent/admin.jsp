<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<%
	session.setAttribute("admin", null);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<title><fmt:message var="titleAdmin" key="titleAdmin"
		bundle="${b}" /></title>
</head>
<body>

	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>
				<c:if test="${not empty error}">
					<c:set var="error" value="Ошибка ввода логина или пароля"></c:set>
				</c:if>

				<h3 style="font-family: fontawesome; font-weight: normal;"
					align="center">${titleAdmin}</h3>

				<form action="AdminServlet" method="post" align="center"
					style="margin-top: 100px;">

					<fmt:message var="login" key="login" bundle="${b}"></fmt:message>
					<fmt:message var="pass" key="pass" bundle="${b}"></fmt:message>
					<fmt:message var="ok" key="ok" bundle="${b}"></fmt:message>

					<label style="color: red; font-size: 18px;"> ${error} </label><br>
					<input type="text" name="login" placeholder="${login}" autofocus
						required> <input type="password" name="pass"
						placeholder="${pass }" required><br> <input
						type="submit" name="submit" value="${ok }" style="width: 50%;">

				</form>
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