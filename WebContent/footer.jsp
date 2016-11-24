<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />	
	
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="css/FontAwesome/css/font-awesome.min.css">
<style type="text/css">
.social>li {
	position: relative;
	display: inline-block;
	margin-right: 14px;
}

#faf {
	font-size: 30px;
	color: #3465a4;	
}

#fafw {
	font-size: 40px;
	color: #3465a4;
}

.footerList {
	float: right;
	margin-right: 40px;
}

#faf:HOVER {
	color: #204a87;
}
</style>
<script type="text/javascript">
	function changeLanguage(language) {

		var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
		xmlhttp.open('GET', 'ChangeLocaleServlet?language=' + language, true);

		/* xmlhttp.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded'); // Отправляем тип содержимого  */
		xmlhttp.send();
		xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
			if (xmlhttp.readyState == 4) { // Ответ пришёл
				if (xmlhttp.status == 200) { // Сервер вернул код 200 (что	
					window.location.href = xmlhttp.responseText;
					//changeValue(language);
				}
			}
		};
	}
	
</script>


</head>
<body>

	<fmt:message var="wordLang" key="wordLang" bundle="${b }"></fmt:message>
	<footer class="site-footer">
		<a class="fa fa-language" id="fafw"
			style="padding-top: 17px; float: left; margin-left: 80px;"></a>
		<div
			style="margin-left: 10px;; margin-top: 14px; width: 20%; float: left;">
			<select id="select"
				style="background-color: #3465a4; color: #fff; width: 180px; margin-top: 0px;" onchange="changeLanguage(this.value)">
				<option value="ru_RU" style="display: none;">${wordLang }</option>
				<option value="ru_RU">РУССКИЙ</option>
				<option value="en_US">ENGLISH</option>
			</select> <span id="copyright"></span>
		</div>
		
		
		<%-- <jsp:useBean id="now" scope="application" class="java.util.Date" /> 
Copyright © ${now.year + 1900} My Company --%>
		
		<div class="footerList">
			<ul class="social">
				<li><a href="#" class="fa fa-vk" id="faf"></a></li>
				<li><a href="#" class="fa fa-facebook" id="faf"></a></li>
				<li><a href="#" class="fa fa-twitter" id="faf"></a></li>
				<li><a href="#" class="fa fa-instagram" id="faf"></a></li>
				<li><a href="#" class="fa fa-linkedin" id="faf"></a></li>
				<li><a href="#" class="fa fa-rss" id="faf"></a></li>
			</ul>
		</div>


	</footer>


</body>
</html>