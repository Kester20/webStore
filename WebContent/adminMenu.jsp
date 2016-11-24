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
<sql:query dataSource="${ws}"
	sql="select laptop.id,laptop.model, laptop.image, client.login, comment.text, comment.publish, comment.date  from comment 
	inner join laptop on comment.idLaptop = laptop.id
	inner join client on comment.idClient = client.id;"
	var="comment"></sql:query>

<sql:query dataSource="${ws}"
	sql="select client.login, client.id, `order`.id, `order`.date, `order`.status, `order`.cost, `order`.typePayment, `order`.typeReceipt, `order`.idClient from `order`
	 inner join client on `order`.idClient = client.id;"
	var="order"></sql:query>

<sql:query dataSource="${ws}" sql="select * FROM client;" var="client"></sql:query>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/icons.css">
<link rel="stylesheet" type="text/css" href="css/form.css">
<link rel="stylesheet" type="text/css" href="css/modal.css">
<script type="text/javascript" src="js/new.js"></script>
<script type="text/javascript">
	function actionComment(action, idLaptop, loginClient, date) {

		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'CommentServlet?action=' + action + "&idLaptop="
				+ idLaptop + "&loginClient=" + loginClient + "&date=" + date,
				true); // Открываем
		// асинхронное
		xmlhttp.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded'); // Отправляем тип содержимого 
		xmlhttp.send();
		xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
			if (xmlhttp.readyState == 4) { // Ответ пришёл
				if (xmlhttp.status == 200) { // Сервер вернул код 200 (что
					// хорошо)
					window.location.reload();
				}
			}
		};
	}

	function updateStatusOrder(status, id) {

		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'OrderServlet?action=updateStatusOrder&status='
				+ status + "&id=" + id, true); // Открываем
		// асинхронное
		xmlhttp.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded'); // Отправляем тип содержимого 
		xmlhttp.send();
		xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
			if (xmlhttp.readyState == 4) { // Ответ пришёл
				if (xmlhttp.status == 200) { // Сервер вернул код 200 (что

					window.location.reload();
				}
			}
		};

	}
	function blackList(action, id) {
		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'BlackListServlet?action=' + action + "&id=" + id,
				true); // Открываем
		// асинхронное
		xmlhttp.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded'); // Отправляем тип содержимого 
		xmlhttp.send();
		xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
			if (xmlhttp.readyState == 4) { // Ответ пришёл
				if (xmlhttp.status == 200) { // Сервер вернул код 200 (что

					window.location.reload();
				}
			}
		};
	}
</script>

<title><fmt:message var="titleAdminMenu" key="titleAdminMenu"
		bundle="${b }" /></title>
</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>
				<div class="nick" align="right" style="line-height: 0px;"></div>
				<h2 align="center" style="font-size: 24px;">${titleAdminMenu }</h2>


				<div style="background: #eeeeec; height: 550px; margin-top: 0px;">
					<table align="center" style="text-align: center; font-size: 30px;">
						<tr>
							<td width="100px;">
								<div class="item">
									<a href="addLaptop.jsp"><i class="fa fa-plus fa-5x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="AddProd" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td width="100px;">
								<div class="item">
									<a href="laptops.jsp?nextPage=updateLaptop.jsp?id="><i
										class="fa fa-wrench fa-5x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="editProd" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td width="100px;">
								<div class="item">
									<a href="laptops.jsp?action=delete"><i
										class="fa fa-trash fa-5x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="delProd" bundle="${b }" />
									</h2>
								</div>
							</td>


						</tr>

						<tr>
							<td>
								<div class="item">
									<a href="#commentList"><i class="fa fa-comment-o fa-5x"
										id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="comments" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td>
								<div class="item">
									<a href="#orderList"><i class="fa fa-book fa-5x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="orders" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td>
								<div class="item">
									<a href="#blackList"><i class="fa fa-th-list fa-5x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="clients" bundle="${b }" />
									</h2>
								</div>
							</td>
						</tr>

					</table>
				</div>

				<fmt:message var="loginClient" key="loginClient" bundle="${b }" />

				<div id="blackList" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">${clients }</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th>${loginClient }</th>
								<th><fmt:message key="mail" bundle="${b }" /></th>
								<th><fmt:message key="name" bundle="${b }" /></th>
								<th><fmt:message key="address" bundle="${b }" /></th>
								<th><fmt:message key="blackList" bundle="${b }" /></th>



							</tr>
							<c:forEach var="client" items="${client.rows}" varStatus="row">

								<tr>

									<sql:query dataSource="${ws}"
										sql="select idClient FROM black_list WHERE idClient = ${client.id};"
										var="blackList"></sql:query>


									<c:set var="flag" value="lock"></c:set>
									<c:forEach var="blackList" items="${blackList.rows}"
										varStatus="row">

										<c:choose>
											<c:when test="${ not empty blackList.idClient}">
												<c:set var="flag" value="unclock"></c:set>
											</c:when>
										</c:choose>
									</c:forEach>


									<td><span>${client.login}</span></td>
									<td><span>${client.email}</span></td>
									<td><span>${client.name}</span></td>
									<td><span>${client.town}, ${client.street},
											${client.house}</span></td>
									<td><c:choose>
											<c:when test="${ flag == 'unclock'}">
												<button style="width: 170px;"
													onclick="blackList('unlock','${client.id}')">
													<i class="fa fa-unlock"></i>
													<fmt:message key="unlock" bundle="${b }" />
												</button>
											</c:when>

											<c:when test="${ flag == 'lock'}">
												<button style="width: 170px;"
													onclick="blackList('lock','${client.id}')">
													<i class="fa fa-lock"></i>
													<fmt:message key="lock" bundle="${b }" />
												</button>
											</c:when>

											<c:otherwise>

											</c:otherwise>
										</c:choose></td>


								</tr>

							</c:forEach>
						</table>
					</div>

				</div>


				<fmt:message var="date" key="date" bundle="${b }" />

				<div id="commentList" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">
							<fmt:message key="commentsClients" bundle="${b }" />
						</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th><fmt:message key="product" bundle="${b }" /></th>
								<th><fmt:message key="model" bundle="${b }" /></th>
								<th>${loginClient }</th>
								<th><fmt:message key="text" bundle="${b}" /></th>
								<th>${date }</th>
								<th><fmt:message key="publish" bundle="${b }" /></th>
								<th><fmt:message key="delete" bundle="${b }" /></th>

							</tr>
							<c:forEach var="comment" items="${comment.rows}" varStatus="row">
								<tr>
									<td><a href="laptop.jsp?id=${comment.id}"><img
											style="margin-top: 10px;"
											src="${pageContext.request.contextPath}${comment.image}"
											width="80px;" height="50px;"></a></td>
									<td><span>${comment.model}</span></td>
									<td><span>${comment.login}</span></td>
									<td><span>${comment.text}</span></td>
									<td><span>${comment.date}</span></td>

									<fmt:message var="publishComment" key="publishComment"
										bundle="${b }"></fmt:message>
									<fmt:message var="hideComment" key="hideComment" bundle="${b }"></fmt:message>
									<fmt:message var="deleteComment" key="deleteComment"
										bundle="${b }"></fmt:message>

									<c:choose>
										<c:when test="${comment.publish == 'no'}">
											<td><i class="fa fa-check fa-2x" id="faag"
												title="${publishComment }"
												onclick="actionComment('publish','${comment.id}','${comment.login}','${comment.date}')"></i></td>
										</c:when>
										<c:when test="${comment.publish == 'yes'}">
											<td><i class="fa fa-minus fa-2x" id="faam"
												title="${hideComment }"
												onclick="actionComment('hide','${comment.id}','${comment.login}','${comment.date}')"></i></td>
										</c:when>
									</c:choose>

									<td><i class="fa fa-times fa-2x" id="faa"
										title="${deleteComment }"
										onclick="actionComment('delete','${comment.id}','${comment.login}','${comment.date}')"></i></td>
								</tr>
							</c:forEach>
						</table>
					</div>

				</div>

				<div id="orderList" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">
							<fmt:message key="orderClients" bundle="${b }" />
						</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th>${loginClient }</th>
								<th>${date }</th>
								<th><fmt:message key="typePay" bundle="${b }" /></th>
								<th><fmt:message key="typeRec" bundle="${b }" /></th>
								<th><fmt:message key="cost" bundle="${b }" /></th>
								<th><fmt:message key="status" bundle="${b }" /></th>


							</tr>
							<c:forEach var="order" items="${order.rows}" varStatus="row">
								<tr>
									<%-- <td><a href="laptop.jsp?id=${comment.id}"><img
								style="margin-top: 10px;"
								src="${pageContext.request.contextPath}${comment.image}"
								width="80px;" height="50px;"></a></td> --%>

									<td><span>${order.login}</span></td>
									<td><span>${order.date}</span></td>
									<td><span>${order.typePayment}</span></td>
									<td><span>${order.typeReceipt}</span></td>
									<td><span>${order.cost}</span></td>
									<td width="265px;"><select name="status"
										onchange="updateStatusOrder(this.value,'${order.id}')">
											<option value="${order.status}" selected>${order.status}</option>
											<option value="registered">Registered</option>
											<option value="canceled">Canceled</option>
											<option value="done">Done</option>
									</select></td>

								</tr>
							</c:forEach>
						</table>
					</div>

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
</html>