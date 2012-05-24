<%--@elvariable id="weight" type="java.lang.Double"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Teža</rapid:override>

<rapid:override name="showForm">
	<%@include file="../common/errors.jsp"%>
	<jsp:include page="../common/showForm.jsp">
		<jsp:param value="/fitbit/heart" name="action" />
	</jsp:include>
</rapid:override>

<rapid:override name="postForm">
	<form action="/fitbit/weigth" method="post" id="post"
		class="ym-form ym-columnar">

		<h2>Vnesi podatke</h2>

		<div class="ym-fbox-text">
			<label for="date_post">Datum:</label> <input id="date_post"
				name="date" type="text" value="${date}" />
		</div>
		<div class="ym-fbox-text">
			<label for="weight">Tracker:</label> <input id="weight" name="weight"
				type="text" value="" />
		</div>

		<div class="ym-fbox-button">
			<button type="submit" class="ym-button ym-save">Shrani</button>
		</div>

	</form>

	<script type="text/JavaScript">
		$(document).ready(function() {
			$('#post').validate({
				rules : {
					date : {
						required : true,
						date : true
					},
					weight : {
						required : true,
						number : true
					}

				}
			});
		});
	</script>
</rapid:override>

<rapid:override name="body">

	<table>
		<tr>
			<td>Teža:</td>
			<td>${weight}</td>
		</tr>
	</table>

</rapid:override>


<%@include file="../template.jsp"%>