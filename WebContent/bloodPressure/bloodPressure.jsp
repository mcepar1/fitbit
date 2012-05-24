<%--@elvariable id="bp" type="com.fitbit.api.common.model.bp.Bp"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Krvni pritisk</rapid:override>

<rapid:override name="showForm">
	<%@include file="../common/errors.jsp"%>
	<jsp:include page="../common/showForm.jsp">
		<jsp:param value="/fitbit/bp" name="action" />
	</jsp:include>
</rapid:override>

<rapid:override name="postForm">

	<form action="/fitbit/bp" method="post" id="post"
		class="ym-form ym-columnar">
		<h2>Vnesi podatke</h2>

		<div class="ym-fbox-text">
			<label for="date_post">Datum:</label> <input id="date_post"
				name="date" type="text" value="${date}" />
		</div>

		<div class="ym-fbox-text">
			<label for="systolic">Sistolični pritisk:</label> <input
				id="systolic" name="systolic" type="text" value="" />
		</div>

		<div class="ym-fbox-text">
			<label for="diastolic">Diastolični pritisk:</label> <input
				id="diastolic" name="diastolic" type="text" value="" />
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
					systolic : {
						required : true,
						digits : true,
						min : 1,
						max : 300
					},
					diastolic : {
						required : true,
						digits : true,
						min : 1,
						max : 300
					}
				}
			});
		});
	</script>
</rapid:override>

<rapid:override name="body">

	<h1>Podatki o krvnem pritisku za ${date}.</h1>

	<table border="2">
		<tr>
			<th>ID</th>
			<th>Sistolični pritisk</th>
			<th>Diastolični pritisk</th>
			<th></th>
		</tr>
		<c:forEach var="bpLog" items="${bp.bp}">
			<tr>
				<td>${bpLog.logId}</td>
				<td>${bpLog.systolic}</td>
				<td>${bpLog.diastolic}</td>
				<td><a href="#"><div class="ym-fbox-button">
							<button type="submit" class="ym-button ym-delete"
								style="margin: 0">Izbrisi</button>
						</div></a></td>
			</tr>
		</c:forEach>
	</table>

</rapid:override>

<%@include file="../template.jsp"%>