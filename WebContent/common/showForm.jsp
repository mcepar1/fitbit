<%--@elvariable id="action" type="java.lang.String"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<form action="${action}" method="get" id="view"
	class="ym-form ym-columnar">
	<h2>Prikaži podatke</h2>

	<div class="ym-fbox-text">
		<label for="date_show">Datum:</label> <input id="date_show"
			name="date" type="text" value="${date}" />
	</div>

	<div class="ym-fbox-button">
		<button type="submit" class="ym-button ym-play">Prikaži</button>
	</div>
</form>

<script type="text/javascript">
	$(document).ready(function() {
		$('#view').validate({
			rules : {
				date : {
					required : true,
					date : true
				}
			}
		});
	});
</script>