<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />
<sql:query var="image" dataSource="${ws}"
	sql="select image from laptop WHERE id = (SELECT MAX(id) from laptop)"></sql:query>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<title>File Upload to Database Demo</title>
</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<fmt:message var="submitAdd" key="submitAdd" bundle="${b}"></fmt:message>

				<jsp:include page="menubar.jsp"></jsp:include>
				<center>
					<h1>
						<fmt:message key="loadImage" bundle="${b }" />
					</h1>
					<form method="post" action="AddImageLaptop"
						enctype="multipart/form-data">
						<table border="0">

							<tr>
								<td><input type="file" name="photo" size="50" /></td>
							</tr>
							<tr>
								<td colspan="2"><input type="submit" value="${submitAdd}"
									style="width: 100%;"></td>
							</tr>
						</table>
					</form>
				</center>
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