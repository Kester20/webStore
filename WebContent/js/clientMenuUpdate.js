var variable;
	var id = ${	sessionScope.clientId};

	function setValue(value, vari, mailTo) {
		variable = vari;
		var obj = document.getElementById('value');
		document.getElementById('variable').value = variable;

		switch (variable) {

		case "login": {
			var newO = document.createElement('input');
			newO.setAttribute('type', 'text');
			newO.setAttribute('name', obj.getAttribute('name'));
			newO.setAttribute('id', obj.getAttribute('id'));
			newO.setAttribute('value', obj.getAttribute('value'));
			obj.parentNode.replaceChild(newO, obj);
			newO.focus();
			break;
		}

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
			break;
		}

		document.getElementById('value').value = value;
	}