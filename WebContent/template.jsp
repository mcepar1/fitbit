<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="css/vlist.css" />
<link rel="stylesheet" type="text/css" href="css/forms/gray-theme.css" />
<link rel="stylesheet" type="text/css" href="css/custom.css" />

<script type="text/JavaScript" src="js/jquery-1.7.2.js"></script>
<script type="text/JavaScript" src="js/jquery.validate.js"></script>
<script type="text/JavaScript">
	jQuery.extend(jQuery.validator.messages, {
		required : "To polje je obvezno!",
		date : "Datum ni pravilno formatiran!",
		number : "Polje lahko vsebuje le število!",
		digits : "Polje lahko vsebuje le celo število!",
		max: jQuery.validator.format("Število mora biti manjše (ali enako) od {0}!"),
	    min: jQuery.validator.format("Število mora biti večje (ali enako) od {0}!")
	});
	
	
	$.validator.setDefaults({
	    showErrors: function(errorMap, errorList) {
	        if (errorList.length < 1) {
	            $('div.ym-error').remove();
	            return;
	        }
	        $.each(errorList, function(index, error) {
	            $(error.element).next('div.ym-error').remove();
	            $(error.element).after(
	                $('<div/>')
	                    .addClass('ym-fbox-text')
	                    .addClass('ym-error')
	                    .append($('<p/>')
	                    		.addClass('ym-message')
	                    		.text(error.message))
	            );
	        });
	    }
	});
	
	
</script>

<title><rapid:block name="title"></rapid:block></title>

</head>
<body>

	<header>
		<div class="ym-wrapper">
			<div class="ym-wbox">
				<img src="css/img/fitbit_banner.gif" alt="Fitbit" />
			</div>
		</div>
	</header>

	<div class="ym-grid">
		<div class="ym-g20 ym-gl">
			<div class="ym-gbox">
				<nav class="ym-vlist">
					<h6 class="ym-vtitle">Menu</h6>
					<ul>
						<li><span>Meritve</span>
							<ul>
								<li><a
									href="http://localhost:8080/fitbit/heart?date=2012-05-16">Srce</a></li>
								<li><a
									href="http://localhost:8080/fitbit/weigth?date=2012-05-16">Teža</a></li>
								<li><a
									href="http://localhost:8080/fitbit/bp?date=2012-05-16">Krvni
										pritisk</a></li>
							</ul></li>
						<li><span>Nastavitve</span>
							<ul>
								<li><a href="http://localhost:8080/fitbit/user">Profil</a></li>
							</ul></li>
					</ul>
				</nav>
			</div>
			
			<rapid:block name="showForm"></rapid:block>
			<rapid:block name="postForm"></rapid:block>
			
		</div>
		<div class="ym-g80 ym-gr">
			<div class="ym-gbox">
				<rapid:block name="body"></rapid:block>
			</div>
		</div>
	</div>

</body>
</html>