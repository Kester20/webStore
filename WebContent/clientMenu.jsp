<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<c:if test="${sessionScope.client == null}">
	<%
		response.sendRedirect("#logIn");
	%>
</c:if>

<%
	String r = request.getParameter("goToOrder");
%>

<c:if test="<%=r != null%>">

	<%
		response.sendRedirect("order.jsp");
	%>

</c:if>

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />
<sql:query dataSource="${ws}"
	sql="select * from client where client.id = '${sessionScope.clientId }'"
	var="client"></sql:query>

<sql:query dataSource="${ws}"
	sql="SELECT laptop.id,laptop.image, laptop.model, `order`.date, `order`.status, `order`.`cost`,`order`.`typePayment`
,`order`.`typeReceipt`,`order`.`idClient`, `order_laptop`.`idLaptop`, order_laptop.idOrder, order_laptop.numberLaptops
FROM `order_laptop` INNER JOIN `laptop` ON order_laptop.idLaptop = laptop.id INNER JOIN `order` on order_laptop.idOrder = `order`.`id`
WHERE `order`.`idClient`  = ${sessionScope.clientId} GROUP BY `order`.id"
	var="order"></sql:query>



<sql:query dataSource="${ws}"
	sql="select laptop.id ,laptop.model,laptop.price,laptop.image from `laptop` 
	inner join wishList on laptop.id = wishList.idLaptop where idClient=  ${sessionScope.clientId}"
	var="wish"></sql:query>

<sql:query dataSource="${ws}"
	sql="select laptop.id ,laptop.model,laptop.price,laptop.image, comment.text, comment.date, comment.idClient 
	from `comment` inner join laptop on comment.idLaptop = laptop.id where comment.idClient=  ${sessionScope.clientId}"
	var="comment"></sql:query>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/icons.css">
<link rel="stylesheet" type="text/css" href="css/modal.css">
<title><fmt:message var="clientMenu" key="clientMenu"
		bundle="${b }">
	</fmt:message></title>
<script type='text/javascript' src='js/new.js'></script>
<script type="text/javascript">
	var variable;
	var id = ${sessionScope.clientId};

	function setValue(value, vari) {

		document.getElementById('value').value = value;
		variable = vari;
		var obj = document.getElementById('value');
		document.getElementById('variable').value = variable;

		switch (variable) {

		case "phone": {
			
			var newO = document.createElement('input');
			newO.setAttribute('type', 'tel');
			newO.setAttribute('maxlength', '11');
			newO.setAttribute('pattern', '80[0-9]{9}');
			//newO.setAttribute('placeholder',"Телефон в формате 80 *********");
			newO.setAttribute('name', obj.getAttribute('name'));
			newO.setAttribute('id', obj.getAttribute('id'));
			newO.setAttribute('value', obj.getAttribute('value'));
			obj.parentNode.replaceChild(newO, obj);
			newO.focus();
			break;
		}

		case "email": {
			
			var newO = document.createElement('input');
			newO.setAttribute('type', 'email');
			newO.setAttribute('name', obj.getAttribute('name'));
			newO.setAttribute('id', obj.getAttribute('id'));
			newO.setAttribute('value', obj.getAttribute('value'));
			obj.parentNode.replaceChild(newO, obj);
			newO.focus();
			break;
		}

		default:
			var newO = document.createElement('input');
			newO.setAttribute('type', 'text');
			newO.setAttribute('name', obj.getAttribute('name'));
			newO.setAttribute('id', obj.getAttribute('id'));
			newO.setAttribute('value', obj.getAttribute('value'));
			obj.parentNode.replaceChild(newO, obj);
			newO.focus();
			break;
		}

		document.getElementById('value').value = value;
	}

	function deleteFromWish(idClient, idLaptop) {
		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'WishListServlet?action=deleteFromWish&idLaptop='
				+ idLaptop + "&idClient=" + idClient, true); // Открываем
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
	
	function deleteOrder(idClient, date){
		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'ClientServlet?action=deleteOrder&idClient='
				+ idClient + "&date=" + date, true); // Открываем
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
	
</script>

</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>
				<h2 align="center" style="font-size: 24px;">${clientMenu }</h2>


				<div style="background: #eeeeec; height: 450px;">
					<table align="right"
						style="text-align: center; font-size: 30px; margin-top: 50px;">

						<tr>
							<td width="100px;">
								<div class="item">
									<a href="#orderList"><i class="fa fa-list-alt fa-4x"
										id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="myOrders" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td width="100px;">
								<div class="item">
									<a href="#commentList"><i class="fa fa-comment-o fa-4x"
										id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="myComments" bundle="${b }" />
									</h2>
								</div>
							</td>

							<td width="100px;">
								<div class="item">
									<a href="#wishList"><i class="fa fa-heart fa-4x" id="fa"></i></a>
									<h2 style="font-size: 20px;">
										<fmt:message key="wishList" bundle="${b }" />
									</h2>
								</div>
							</td>
						</tr>

					</table>

					<div>
						<c:forEach var="client" items="${client.rows}" varStatus="row">
							<h2 align="center" style="font-size: 24px;">
								<fmt:message key="personalInfo" bundle="${b }" />
							</h2>

							<table
								style="width: 35%; margin-left: 20px; text-align: center; margin-top: 20px;">
								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="name" bundle="${b }" /></span></td>
									<td width="100px;">${client.name}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.name}','name','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

								<tr>
									<td colspan="3"><hr></td>
								</tr>

								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="mail" bundle="${b }" /></span></td>
									<td width="100px;">${client.email}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.email}','email','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

								<tr>
									<td colspan="3"><hr></td>
								</tr>

								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="tel" bundle="${b }" /></span></td>
									<td width="100px;">${client.phone}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.phone}','phone','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

								<tr>
									<td colspan="3"><hr></td>
								</tr>

								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="city" bundle="${b }" /></span></td>
									<td width="100px;">${client.town}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.town}','town','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

								<tr>
									<td colspan="3"><hr></td>
								</tr>

								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="street" bundle="${b }" /></span></td>
									<td width="100px;">${client.street}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.street}','street','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

								<tr>
									<td colspan="3"><hr></td>
								</tr>

								<tr>
									<td width="100px;"><span style="color: gray;"><fmt:message
												key="house" bundle="${b }" /></span></td>
									<td width="100px;">${client.house}</td>
									<td width="100px;"><a href="#updateValue"
										onclick="setValue('${client.house}','house','${client.email}')"><i
											class="fa fa-pencil-square-o fa-2x" id="faSmall"></i></a></td>
								</tr>

							</table>
						</c:forEach>
					</div>


				</div>

				<div id="wishList" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">
							<fmt:message key="wishList" bundle="${b }" />
						</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th><fmt:message key="product" bundle="${b }" /></th>
								<th><fmt:message key="model" bundle="${b }" /></th>
								<th><fmt:message key="priceAddLaptop" bundle="${b}" /></th>
								<th><fmt:message key="delete" bundle="${b }" /></th>

							</tr>
							<c:forEach var="wish" items="${wish.rows}" varStatus="row">
								<tr>
									<td><a href="laptop.jsp?id=${wish.id}"><img
											style="margin-top: 10px;"
											src="${pageContext.request.contextPath}${wish.image}"
											width="80px;" height="50px;"></a></td>
									<td><span>${wish.model}</span></td>
									<td><span>${wish.price} грн</span></td>
									<td><i class="fa fa-times fa-2x" id="faa"
										onclick="deleteFromWish('${sessionScope.clientId }','${wish.id}')"></i></td>
								</tr>
							</c:forEach>
						</table>
					</div>

				</div>


				<div id="orderList" class="modalDialog" style="overflow: auto;">

					<div>

						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">
							<fmt:message key="myOrders" bundle="${b }" />
						</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th><fmt:message key="product" bundle="${b }" /></th>

								<th><fmt:message key="date" bundle="${b }" /></th>
								<th><fmt:message key="status" bundle="${b }" /></th>
								<th><fmt:message key="cost" bundle="${b }" /></th>
								<th><fmt:message key="typePay" bundle="${b }" /></th>
								<th><fmt:message key="typeRec" bundle="${b }" /></th>
								<th><fmt:message key="delete" bundle="${b }" /></th>
							</tr>
							<c:forEach var="order" items="${order.rows}" varStatus="row">

								<tr>

									<td><sql:query dataSource="${ws}"
											sql="SELECT laptop.id,laptop.image, laptop.model, `order`.`idClient`, `order_laptop`.`idLaptop`, order_laptop.idOrder,
						 order_laptop.numberLaptops FROM `order_laptop` INNER JOIN `laptop` ON order_laptop.idLaptop = laptop.id 
						INNER JOIN `order` on order_laptop.idOrder = `order`.`id` WHERE `order`.`idClient` = ${sessionScope.clientId} AND `order`.date = '${order.date}'"
											var="product"></sql:query> <c:forEach var="product"
											items="${product.rows}" varStatus="row">

											<a href="laptop.jsp?id=${product.id}"><img
												style="margin-top: 10px; color: black;"
												src="${pageContext.request.contextPath}${product.image}"
												width="80px;" height="50px;"><span>${product.numberLaptops}</span></a>
										</c:forEach></td>



									<td><span>${order.date}</span></td>
									<td><span>${order.status}</span></td>
									<td><span>${order.cost}</span></td>
									<td><span>${order.typePayment}</span></td>
									<td><span>${order.typeReceipt}</span></td>
									<td><i class="fa fa-times fa-2x" id="faa"
										title="${deleteComment }"
										onclick="deleteOrder('${order.idClient}','${order.date}')"></i></td>
								</tr>

							</c:forEach>
						</table>


					</div>
				</div>


				<div id="commentList" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">Ваши отзывы</h2>

						<table
							style="width: 100%; border-collapse: collapse; text-align: center;"
							border="1">
							<tr>
								<th><fmt:message key="product" bundle="${b }" /></th>
								<th><fmt:message key="model" bundle="${b }" /></th>
								<th><fmt:message key="priceAddLaptop" bundle="${b}" /></th>
								<th><fmt:message key="text" bundle="${b}" /></th>
								<th><fmt:message key="date" bundle="${b }" /></th>

							</tr>
							<c:forEach var="comment" items="${comment.rows}" varStatus="row">
								<tr>
									<td><a href="laptop.jsp?id=${comment.id}"><img
											style="margin-top: 10px;"
											src="${pageContext.request.contextPath}${comment.image}"
											width="80px;" height="50px;"></a></td>
									<td><span>${comment.model}</span></td>
									<td><span>${comment.price} грн</span></td>
									<td><span>${comment.text}</span></td>
									<td><span>${comment.date}</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>

				</div>



				<fmt:message var="submitAdd" key="submitAdd" bundle="${b}"></fmt:message>
				<div id="updateValue" class="modalDialog" style="overflow: auto;">

					<div>
						<a href="#close" title="Закрыть" class="close">X</a>
						<h2 align="center" style="font-size: 24px;">
							<fmt:message key="enterNewValue" bundle="${b }" />
						</h2>

						<div align="center">

							<form action="ClientServlet?action=update" method="post"
								id="form">
								<div>
									<input type="hidden" value="" id="variable" name="variable">
									<input type="hidden" value="${sessionScope.clientId}" id="id"
										name="id"> <input type="text" name="value" id="value"
										autofocus required value=""> <br>
								</div>
								<input type="submit" name="submit" value="${submitAdd}"
									style="width: 50%;">
							</form>
						</div>
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