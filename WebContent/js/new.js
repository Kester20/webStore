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

function setKeyValue(idLaptop, value) {
	
	
	var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
	xmlhttp.open('POST', 'CartServlet?action=setKeyValue&idLaptop=' + idLaptop + "&value=" + value, true); // Открываем
																		// асинхронное
																		// соединение

	xmlhttp.send(); // Отправляем POST-запрос
	xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
		if (xmlhttp.readyState == 4) { // Ответ пришёл
			if (xmlhttp.status == 200) { // Сервер вернул код 200 (что
											// хорошо)
					
				//window.location.reload();
			}
		}
	};
}

function updateTotal(idLaptop,value) {
	
	setKeyValue(idLaptop, value);
	var table = document.getElementById("table");
	var tr = table.rows.length;
	var td = null;

	var x = [];
	var y = [];
	var index = 0;
	var index2 = 0;

	for (var i = 1; i < tr; i++) {
		td = table.rows[i].cells.length;

		for (var n = 2; n < 3; n++) {
			x[index++] = table.rows[i].cells[n].getElementsByTagName("input")[0].value;
		}

		for (var n = 3; n < 4; n++) {
			y[index2++] = parseInt(table.rows[i].cells[n].innerHTML);
		}
	}

	var sum = 0;
	for (var z = 0; z < y.length; z++) {
		sum += x[z] * y[z];
	}
	document.getElementById("total").innerHTML = sum;
	document.getElementById("cost").value = sum;
	
	
	var quantity = 0;
	for (var q = 0; q < x.length; q++) {
		quantity += parseInt(x[q]);
	}
	document.getElementById("quantity").value = quantity;
	return sum;
}

function deleteId(id) {
	var xmlhttp = getXmlHttp(); // Создаём объект XMLHTTP
	xmlhttp.open('POST', 'CartServlet?action=delete&id=' + id, true); // Открываем
																		// асинхронное
																		// соединение

	xmlhttp.send("id=" + encodeURIComponent(id)); // Отправляем POST-запрос
	xmlhttp.onreadystatechange = function() { // Ждём ответа от сервера
		if (xmlhttp.readyState == 4) { // Ответ пришёл
			if (xmlhttp.status == 200) { // Сервер вернул код 200 (что
											// хорошо)

				window.location.reload();
			}
		}
	};
}