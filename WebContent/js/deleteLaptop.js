var request = false;



function f(action, id) {

	if (action == "delete") {
		var message = confirm("Вы уверены, что хотите удалить данный ноутбук?");
		if (message == true) {
			var del = "delete";
			send(del, id);
		}
	}

}

function send(del, id) {

	try {
		request = new XMLHttpRequest();
	} catch (trymicrosoft) {
		try {
			request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (othermicrosoft) {
			try {
				request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (failed) {
				request = false;
			}
		}
	}

	if (!request) {

		alert("Error initializing XMLHttpRequest!")
	} else {

		// var phone = document.getElementById("phone").value;
		var url = "AddLaptop?action=" + del + "&id=" + id;
		request.open("GET", url, true);
		request.onreadystatechange = updatePage;
		request.send(null);
	}

}

function updatePage() {

	

	if (request.readyState == 4) {

		if (request.status == 200) {
			alert("Server is done!");
			window.location.href = 'index.jsp';
		} else if (request.status == 404)
			alert("Request URL does not exist");
		else
			alert("Error: status code is " + request.status);
	} 

}