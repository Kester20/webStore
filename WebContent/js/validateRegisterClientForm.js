function getXmlHttp() {
	var xmlhttp;
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
			xmlhttp = false;
		}
	}
	if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}
function checkLogin(login, lang) {
	
	var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
	xmlhttp.open('POST', 'ClientServlet?login=' + login, true); // Открываем
															// асинхронное
															// соединение

	xmlhttp.send("login=" + encodeURIComponent(login)); // Отправляем
														// POST-запрос
	xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
		if (xmlhttp.readyState == 4) { // Ответ пришёл
			if (xmlhttp.status == 200) { // Сервер вернул код 200 (что
											// хорошо)
				if (xmlhttp.responseText == 'true') {
					if(lang == 'ru_RU'){						
						document.getElementById("check_login").innerHTML = "Логин занят!";
					}else{
						document.getElementById("check_login").innerHTML = "This login is already used!";
					}
					document.getElementById("check_login").style.color = "red";
				} else {
					if(lang == 'ru_RU'){
						document.getElementById("check_login").innerHTML = "Логин свободен!";
					}else{
						document.getElementById("check_login").innerHTML = "Login is not used!";
					}
					
					document.getElementById("check_login").style.color = "green";
				}
			}
		}
	};
}

function validate_form() {

	valid = true;

	if (document.getElementById("check_login").style.color == "red") {
		valid = false;
	}

	return valid;
}