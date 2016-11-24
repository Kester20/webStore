<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<fmt:setLocale value="${language}" />
<fmt:setBundle var="b" basename="resources/content" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/page.css">
<title>Web store</title>


<style>
#sliderImages {
	position: relative;
	margin-top:30px;
	margin-bottom:0px;
/*  	margin: 100px auto;  */
 	padding: 5px; 
	width: 99%;
	height: 360px;
	background-color: #fff;
	/* border: 5px solid grey;
	border-radius: 15px; */
}

#scr {
	margin: 20px auto;
	width: 800px;
	height: 400px;
	margin-top: 20px;
	background-color: white;
	background-size: cover;
	/*  border: 2px solid black;
	border-radius: 10px; */ 
}

.left, .right {
	position: absolute;
	top: 150px;
	width: 25px;
	height: 70px;
	font: 12pt arial, tahoma, sans-serif;
	text-align: center;
}

.left {
	left: 5px;
}

.right {
	right: 5px;
}
</style>
<script>
	var slider = {
		slides : [ 'images/hp2.jpg','images/hp.jpg','images/oi.jpg', 'images/acer3.jpg'  ],
		frame : 0, // текущий кадр для отбражения - индекс картинки из массива
		set : function(image) { // установка нужного фона слайдеру
			document.getElementById("scr").style.backgroundImage = "url("
					+ image + ")";
		},
		init : function() { // запуск слайдера с картинкой с нулевым индексом
			this.set(this.slides[this.frame]);
		},
		left : function() { // крутим на один кадр влево
			this.frame--;
			if (this.frame < 0)
				this.frame = this.slides.length - 1;
			this.set(this.slides[this.frame]);
		},
		right : function() { // крутим на один кадр вправо
			this.frame++;
			if (this.frame == this.slides.length)
				this.frame = 0;
			this.set(this.slides[this.frame]);
		}
	};
	window.onload = function() { // запуск слайдера после загрузки документа
		slider.init();
		setInterval(function() { // ставим пятисекундный интервал для перелистывания картинок
			slider.right();
		}, 2000);
	};
</script>


</head>
<body>

	<div id="all">
		<div id="main">
			<div id="content">
				<jsp:include page="menubar.jsp"></jsp:include>


				<div id="sliderImages">
					<button class="left" onclick="slider.left();"><</button>
					<div id="scr"></div>
					<button class="right" onclick="slider.right();">></button>
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