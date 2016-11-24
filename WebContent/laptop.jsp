<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<sql:setDataSource var="ws" dataSource="jdbc/web_store" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/tabs.css">
<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/page.css">
<script type="text/javascript" src="js/new.js"></script>
<script type="text/javascript">
	/* Функция, создающая экземпляр XMLHTTP */
	function addToCart(id) {
		
		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('POST', 'CartServlet?id=' + id, true); // Открываем асинхронное соединение
		/* xmlhttp.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded'); // Отправляем тип содержимого */
		xmlhttp.send("id=" + encodeURIComponent(id)); // Отправляем POST-запрос
		xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
			if (xmlhttp.readyState == 4) { // Ответ пришёл
				if (xmlhttp.status == 200) { // Сервер вернул код 200 (что хорошо)
					window.location.href = xmlhttp.responseText;
					window.location.reload();
					xmlhttp.abort();
				}
			}
		};
		
	}
	function addToWish(idLaptop, idClient, lang) {
		
		if(idClient == ""){
			if(lang == "en_US"){				
				alert("For this action you need to be user of our site. Please log in with your login and password.");
			}else{
				alert("Для данного дейсвия нужно быть пользователем сайта.Зайдите под своим логином и паролем.");
			}
			document.getElementById("href").style.color = "red";
			document.getElementById("href").style.textDecoration = "underline";
		}else{
			
			var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
			xmlhttp.open('POST', 'WishListServlet?action=addToWish&idLaptop='+idLaptop + "&idClient="+idClient, true); // Открываем асинхронное соединение
			 xmlhttp.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded'); // Отправляем тип содержимого 
			xmlhttp.send(); // Отправляем POST-запрос
			xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
				if (xmlhttp.readyState == 4) { // Ответ пришёл
					if (xmlhttp.status == 200) { // Сервер вернул код 200 (что хорошо)
						/* window.location.href = xmlhttp.responseText; */
						if(lang == "ru_RU"){							
							alert("Товар добавлен в список желаний.");
						}else{
							alert("The product was add to your wish list.")
						}
						xmlhttp.abort();
					}
				}
			};
		}
		
		
		/* var form = document.getElementById("addToWish");
		form.submit(); */
	}
	
	function addComment(idLaptop, idClient, lang) {
		
		if(idClient == ""){
			if(lang == "en_US"){				
				alert("For this action you need to be user of our site. Please log in with your login and password.");
			}else{
				alert("Для данного дейсвия нужно быть пользователем сайта.Зайдите под своим логином и паролем.");
			}
			document.getElementById("href").style.color = "red";
			document.getElementById("href").style.textDecoration = "underline";
		}else{
			var text = document.getElementById("textarea").value;
			var params = 'action=addComment' + '&text=' + encodeURIComponent(text) + '&idLaptop=' + idLaptop + 
			 '&idClient=' + idClient;
			//var newText = encodeURIComponent(text);
			var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
			
			xmlhttp.open('POST', 'CommentServlet', true); // Открываем асинхронное соединение
			 xmlhttp.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded;charset=utf-8'); // Отправляем тип содержимого 
			xmlhttp.send(params); // Отправляем POST-запрос
			xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
				if (xmlhttp.readyState == 4) { // Ответ пришёл
					if (xmlhttp.status == 200) { // Сервер вернул код 200 (что хорошо)
						/* window.location.href = xmlhttp.responseText; */
						if(lang == "en_US"){
							alert("Your comment succesfully registered.");
						}else{
							alert("Ваш отзыв успешно зарегистрирован.");
						}
						document.getElementById("textarea").value = "";
						xmlhttp.abort();
					}
				}
			};
		}
		
	}
	
	function checkTextArea(idClient, lang){
		if(idClient == ""){
			if(lang == "en_US"){				
				alert("For this action you need to be user of our site. Please log in with your login and password.");
			}else{
				alert("Для данного дейсвия нужно быть пользователем сайта.Зайдите под своим логином и паролем.");
			}
			
			document.getElementById("href2").focus();
			document.getElementById("href").style.color = "red";
			document.getElementById("href").style.textDecoration = "underline";
			window.scrollTo(0, 0);
		}
	}
</script>


<title>Laptop</title>
</head>
<body>
	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>

				<div style="background: #eeeeec; height: 1171px;">
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

						<h2
							style="margin-left: 20px; font-size: x-large; font-weight: normal;">
							<fmt:message key="laptop" bundle="${b }" />
							${laptop.producer} ${laptop.model}
						</h2>

						<div
							style="background: #fff; float: right; width: 440px; margin-top: 20px; border: 1px solid #ddd; margin-right: 380px; height: 200px;">
							<h2
								style="font-weight: normal; font-size: x-large; text-align: center;">
								${laptop.price}
								<fmt:message key="money" bundle="${b }" />
							</h2>

							<div tabindex="1" id="href2" style="margin-right: 9999px;"></div>

							<a href="#" style="text-decoration: none; color: #3465a4;"
								onclick="addToWish('${id}','${sessionScope.clientId}','${language }')"><label
								id="like" style="margin-left: 100px;"></label> <fmt:message
									key="addToWish" bundle="${b }" /></a> <br> <a href="#"
								style="margin-left: 110px;" onclick="addToCart(${laptop.id})">
								<button style="margin-top: 10px;">
									<i id="fam" class="fa fa-cart-arrow-down fa-1x"
										style="font-size: 25px;"></i>
									<fmt:message key="BUY" bundle="${b }" />
								</button>
							</a>

						</div>


						<%-- <form
				action="ClientServlet?action=addToWish&idLaptop=${id}&idClient=${sessionScope.clientId}"
				method="post" id="addToWish" style="display: none;"></form> --%>


						<div class="photo" style="margin-left: 20px; margin-top: 41px;">
							<img alt=""
								src="${pageContext.request.contextPath}${laptop.image}"
								width="290px;" height="200px;">
						</div>

						<br>
						<br>

						<div class="tabs">
							<input id="tab1" type="radio" name="tabs" checked> <label
								for="tab1" title="Вкладка 1"><fmt:message
									key="parameters" bundle="${b }" /></label> <input id="tab2"
								type="radio" name="tabs"> <label for="tab2"
								title="Вкладка 2"><i class="fa fa-comment-o"
								style="font-size: 20px;"></i> <fmt:message key="commentsLaptop"
									bundle="${b }" /></label> <input id="tab3" type="radio" name="tabs">
							<label for="tab3" title="Вкладка 3">Вкладка 3</label> <input
								id="tab4" type="radio" name="tabs"> <label for="tab4"
								title="Вкладка 4">Вкладка 4</label>

							<section id="content1">

								<p style="font-size: x-large;">
									<fmt:message key="parameters" bundle="${b }" />
									${laptop.producer}
								</p>

								<table cellpadding="0"
									style="border-collapse: collapse; width: 100%; border-spacing: 1px 1px;">
									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="producerAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.producer}</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="CPUAddLaptop" bundle="${b}"></fmt:message>
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.CPU}</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="screenAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.screen}</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="screenResAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.screenRes}"</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">RAM:</p>
										</td>

										<td>
											<p id="second">${laptop.RAM}GB</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="amountAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.amountHardDrive}GB</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="colorAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.color}</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="weightAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.weight}<fmt:message key="kg"
													bundle="${b }" />
											</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="videoCardAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.video}</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="guaranteeAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.guarantee}<fmt:message
													key="month" bundle="${b }" />
												.
											</p>
										</td>
									</tr>

									<tr>
										<td width="50%">
											<p id="first">
												<fmt:message key="modelAddLaptop" bundle="${b}" />
												:
											</p>
										</td>

										<td>
											<p id="second">${laptop.model}</p>
										</td>
									</tr>

								</table>

							</section>
							<section id="content2">

								<c:set var="comment"
									value="SELECT comment.text,comment.date,comment.publish,client.login,laptop.id FROM comment 
					INNER JOIN client on comment.idClient = client.id 
					INNER JOIN laptop ON comment.idLaptop = laptop.id 
					WHERE laptop.id = ${id} AND comment.publish = 'yes'"></c:set>
								<sql:query dataSource="${ws}" var="comment" sql="${comment}"></sql:query>

								<c:forEach var="comment" items="${comment.rows}" varStatus="row">

									<span style="float: right; margin-top: 20px;">${comment.date}</span>
									<div align="left">
										<h3 style="color: #3465a4">
											<i class="fa fa-user" style="color: #3465a4;"></i>
											${comment.login }
										</h3>
										<p>${comment.text}</p>
										<hr>
									</div>
								</c:forEach>


								<fmt:message var="textAreaInfo" key="textAreaInfo"
									bundle="${b }">
								</fmt:message>
								<c:set var="info" value="${ textAreaInfo}"></c:set>

								<br>
								<p>
									<fmt:message key="writeComment" bundle="${b }" />
								</p>
								<textarea rows="6" cols="93" style="overflow: auto;"
									onfocus="checkTextArea('${clientId}','${language }')"
									placeholder="${info}" id="textarea"></textarea>

								<button style="float: right; width: 200px; margin-right: 3px;"
									onclick="addComment('${id}','${sessionScope.clientId}','${language }')">
									<i class="fa fa-pencil"></i>
									<fmt:message key="writeComment" bundle="${b }" />
								</button>

								<div style="height: 70px;"></div>


							</section>
							<section id="content3">
								<p>Здесь размещаете любое содержание....</p>
							</section>
							<section id="content4">
								<p>Здесь размещаете любое содержание....</p>
							</section>
						</div>

					</c:forEach>



				</div>
			</div>
		</div>
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