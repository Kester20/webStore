<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha"%>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />

<c:if test="${sessionScope.admin == null}">
	<c:set var="admin" value="${sessionScope.admin}"></c:set>
</c:if>
<c:if test="${sessionScope.admin != null}">
	<%
		session.setAttribute("client", null);
	%>
</c:if>

<c:choose>
	<c:when test="${sessionScope.client != null}">
		<c:set var="login" value="${sessionScope.client}"></c:set>
		<%
			session.setAttribute("admin", null);
		%>
	</c:when>

	<c:when test="${sessionScope.client == null}">
		<fmt:message key="logIn" bundle="${b}" var="logIn" />
		<fmt:message key="registr" bundle="${b}" var="registr"></fmt:message>
	</c:when>
</c:choose>

<c:set var="list" value="${sessionScope.list}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<script type='text/javascript' src='js/new.js'></script>
<script type='text/javascript' src='js/validateRegisterClientForm.js'></script>
<script type="text/javascript">
	function logOut() {
		var form = document.getElementById("formOut");
		form.submit();
	}
</script>


<link rel="stylesheet" type="text/css" href="css/icons.css">
<link rel="stylesheet" type="text/css" href="css/modal.css">
<link rel="stylesheet" type="text/css" href="css/bar.css">
<link rel="stylesheet" type="text/css" href="css/form.css">
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">

<style type="text/css">
#fam {
	font-size: 24px;
	color: #afaecc;
}
</style>

</head>
<body class="menubar">

	<nav class="header">

		<ul class="main-menu">
			<li class="q"><a href="index.jsp"><i id="fam"
					class="fa fa-home"></i> <fmt:message key="main" bundle="${b}"></fmt:message>
			</a></li>
			<li class="q"><a href="#services"><i
					class="fa fa-folder-open" id="fam"></i> <fmt:message key="catalog"
						bundle="${b}"></fmt:message></a>
				<ul class="sub-menu">
					<li><a href="laptops.jsp?nextPage=laptop.jsp?id="><i
							class="fa fa-laptop" id="fam"></i> <fmt:message key="laptops"
								bundle="${b}"></fmt:message></a></li>

				</ul></li>
			<li class="q"><a href="#cart"><i id="fam"
					class="fa fa-cart-arrow-down"></i> <fmt:message key="cart"
						bundle="${b}" /></a></li>

			<c:if test="${ not empty admin}">
				<li class="q" style="float: right;"><a href="#">${admin} </a>
					<ul class="sub-menu-right">
						<li><a href="adminMenu.jsp"><fmt:message key="menu"
									bundle="${b}" /></a></li>
						<li><a href="admin.jsp"><fmt:message key="exit"
									bundle="${b }" /></a></li>
					</ul></li>
			</c:if>



			<c:if test="${ not empty login }">
				<li class="q" style="float: right; margin-right: 50px;"><a
					href=""><i id="fam" class="fa fa-user"></i> ${login}</a>
					<ul class="sub-menu-right" style="width: 100px;">
						<li><a href="clientMenu.jsp"><fmt:message
									key="personalMenu" bundle="${b }" /></a></li>
						<li><a href="#" onclick="logOut()"><fmt:message
									key="exit" bundle="${b }" /></a></li>
					</ul></li>
			</c:if>

			<c:if test="${empty login && empty admin }">
				<li class="q" style="float: right;"><a href="#registr"><i
						id="fam" class="fa fa-registered"></i> ${registr}</a></li>
				<li class="q" style="float: right;"><a href="#logIn" id="href"><i
						id="fam" class="fa fa-key"></i> ${logIn}</a></li>
			</c:if>


		</ul>


	</nav>
	<form action="ClientServlet?action=logOut" method="post"
		style="display: none;" id="formOut"></form>
	<div id="cart" class="modalDialog" style="overflow: auto;">

		<%
			HashMap list = (HashMap) session.getAttribute("list");
		%>

		<c:if test="<%=list == null || list.size() == 0%>">
			<c:set var="test" value="0"></c:set>
		</c:if>

		<c:choose>
			<c:when test="${test==0}">
				<div>
					<a href="#close" title="Закрыть" class="close">X</a>
					<h2 align="center" style="font-size: 24px;">
						<fmt:message key="cartIsEmpty" bundle="${b }" />
					</h2>
					<p align="center" style="font-size: 20px;">
						<fmt:message key="it_s_time_to_fix_it" bundle="${b }" />
					</p>
				</div>
			</c:when>
			<c:otherwise>
				<c:set var="tdWidth" value="100px"></c:set>
				<c:set var="total" value="0"></c:set>

				<div>
					<a href="#close" title="Закрыть" class="close">X</a>
					<h2 align="center" style="font-size: 24px;">
						<fmt:message key="cart" bundle="${b }" />
					</h2>

					<table style="width: 100%; border-collapse: collapse;" border="1"
						id="table">
						<tr>
							<th><fmt:message key="product" bundle="${b }" /></th>
							<th><fmt:message key="model" bundle="${b }" /></th>
							<th><fmt:message key="number" bundle="${b }" /></th>
							<th><fmt:message key="price" bundle="${b }" /></th>
							<th><fmt:message key="delete" bundle="${b }" /></th>

						</tr>

						<c:set var="quantity" value="0"></c:set>
						<c:forEach var="list" items="${list}">

							<c:set var="q"
								value='SELECT laptop.id,producer.producer,CPU.CPU,laptop.screen,
		screenResolution.screenRes,laptop.RAM,laptop.amountHardDrive,laptop.color,laptop.weight,
		videoCard.video,laptop.guarantee,laptop.price,laptop.image,laptop.model
		 FROM `laptop` INNER JOIN producer ON laptop.producer = producer.id 
		INNER JOIN CPU ON laptop.CPU = CPU.id INNER JOIN screenResolution ON laptop.screenResolution = screenResolution.id 
		INNER JOIN videoCard ON laptop.videoCard = videoCard.id WHERE laptop.id = ${list.key}'></c:set>
							<sql:query dataSource="${ws}" var="query" sql="${q}">
							</sql:query>


							<c:forEach var="laptop" items="${query.rows}" varStatus="row">

								<tr>
									<td style="text-align:center;width: ${tdWidth};"><a
										href="laptop.jsp?id=${laptop.id}"><img
											style="margin-top: 10px;"
											src="${pageContext.request.contextPath}${laptop.image}"
											width="80px;" height="50px;"></a></td>
									<td style="text-align:center;width: ${tdWidth}">${laptop.producer}
										${laptop.model}</td>
									<td style="text-align:center;width: ${tdWidth}"><input
										style="width: 100px;" type="number" value="${list.value}"
										name="number" min="1" max="10"
										onchange="updateTotal('${laptop.id}',this.value)"></td>
									<td style="text-align:center;width: ${tdWidth}">${laptop.price}
										<fmt:message key="money" bundle="${b }" />
									</td>
									<td style="text-align:center;width: ${tdWidth}"><i
										class="fa fa-times fa-2x" id="faa"
										onclick="deleteId(${list.key})"></i></td>
								</tr>


								<c:set var="total" value="${total + laptop.price}"></c:set>
							</c:forEach>

							<c:set var="quantity" value="${quantity + 1}"></c:set>

						</c:forEach>
					</table>
					<br>

					<fmt:message var="makeOrder" key="makeOrder" bundle="${b }"></fmt:message>
					<div align="right">
						<div
							style="font-size: 20px; font-weight: bold; float: left; text-decoration: underline;">
							<fmt:message key="total" bundle="${b }" />
							: <span id="total">${total} </span>
							<fmt:message key="money" bundle="${b }" />
						</div>
						<form action="CartServlet?action=setCostToSession" method="post"
							style="display: none;" id="f">
							<input name="cost" id="cost" type="hidden" value="${total}" /> <input
								name="quantity" id="quantity" type="hidden" value="${quantity}" />
						</form>
						<input type="submit" value="${makeOrder}" form="f"
							style="margin-top: -10px; width: 150px; font-size: 16px;">
					</div>

				</div>
			</c:otherwise>
		</c:choose>



	</div>

	<fmt:message var="login" key="login" bundle="${b}"></fmt:message>
	<fmt:message var="pass" key="pass" bundle="${b}"></fmt:message>
	<fmt:message var="ok" key="ok" bundle="${b}"></fmt:message>

	<div id="logIn" class="modalDialog" style="overflow: auto;">

		<div>
			<a href="#close" title="Закрыть" class="close">X</a>
			<h2 align="center" style="font-size: 24px;">
				<fmt:message key="enter" bundle="${b }" />
			</h2>

			<div id="form">
				<form action="ClientServlet?action=logIn" method="post"
					style="float: center;" align="center">

					<c:if test="${not empty errorClient}">
						<c:set var="error" value="Ошибка ввода логина или пароля"></c:set>
					</c:if>
					<label style="color: red; font-size: 18px;"> ${errorClient}
					</label><br> <input type="text" name="login" placeholder="${login }"
						autofocus required> <input type="password" name="pass"
						placeholder="${pass }" required><br> <input
						type="submit" name="submit" value="${ok }" style="width: 50%;">
					<input type="hidden" value="${order}" name="order">
				</form>
			</div>
		</div>
	</div>

	<div id="logInToOrder" class="modalDialog" style="overflow: auto;">

		<div>
			<a href="#close" title="Закрыть" class="close">X</a>
			<h2 align="center" style="font-size: 24px;">
				<fmt:message key="enter" bundle="${b }" />
			</h2>

			<div id="form">
				<form action="ClientServlet?action=toOrder" method="post"
					style="float: center;" align="center">

					<input type="text" name="login" placeholder="${login }" autofocus
						required> <input type="password" name="pass"
						placeholder="${pass }" required><br> <input
						type="submit" name="submit" value="${ok }" style="width: 50%;">
					<input type="hidden" value="${order}" name="order">
				</form>
			</div>
		</div>
	</div>

	<div id="blackListMessage" class="modalDialog" style="overflow: auto;">

		<div>
			<a href="#close" title="Закрыть" class="close">X</a>
			<h2 align="center" style="font-size: 24px;">
				<fmt:message key="mess" bundle="${b }" />
			</h2>

			<h3 align="center" style="font-size: 20px;">
				<fmt:message key="messInfo" bundle="${b }" />
			</h3>
		</div>
	</div>

	<fmt:message var="yourName" key="yourName" bundle="${b }" />
	<fmt:message var="city" key="city" bundle="${b }" />
	<fmt:message var="street" key="street" bundle="${b }" />
	<fmt:message var="house" key="house" bundle="${b }" />
	<fmt:message var="tel" key="tel" bundle="${b }" />

	<div id="registr" class="modalDialog" style="overflow: auto;">
		<div>
			<a href="#close" title="Закрыть" class="close">X</a>
			<h2 align="center" style="font-size: 24px;">
				<fmt:message key="register" bundle="${b }" />
			</h2>

			<div id="form">
				<form action="ClientServlet" align="center" method="post"
					onsubmit="return validate_form ();">

					<table align="center" style="text-align: left; width: 100%;">

						<c:set var="tdWidth" value="300px"></c:set>
						<tr>
							<td width="70%"><input type="text" name="name"
								placeholder="${yourName }" autofocus required
								style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="text" name="login" placeholder="${login}"
								required onblur="checkLogin(this.value,'${language}')"
								style="width: ${tdWidth}; float: right;"></td>
							<td><label id="check_login"></label></td>
						</tr>

						<tr>
							<td><input type="email" name="mail" placeholder="E-mail"
								required style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="text" name="town" placeholder="${city }"
								required style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="text" name="street"
								placeholder="${street }" required
								style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="text" name="house" placeholder="${house }"
								required style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="tel" name="phone"
								placeholder="${tel } 80 *********" required pattern="80[0-9]{9}"
								maxlength="11" style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="password" name="pass"
								placeholder="${pass }" required
								style="width: ${tdWidth}; float: right;"></td>
						</tr>

						<tr>
							<td><input type="submit" name="submit" value="${ok }"
								style="width: ${tdWidth}; float: right;"></td>
						</tr>

					</table>
				</form>
			</div>

		</div>
	</div>
</body>
</html>