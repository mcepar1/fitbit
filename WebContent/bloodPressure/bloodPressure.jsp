<%--@elvariable id="bp" type="com.fitbit.api.common.model.bp.Bp"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Krvni pritisk</rapid:override>
<rapid:override name="body">

	<c:if test="${errors != null}">
		<h1>Napake:</h1>
		<ul>
			<c:forEach var="message" items="${errors}">
				<li>${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<h1>Prikaži podatke</h1>
	<form action="/fitbit/bp" method="get" id="view">
		<table>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" value="${date}" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Prikaži" /></td>
			</tr>
		</table>

		<c:if test="${bp != null}">
			<table>
				<tr>
					<th>ID</th>
					<th>Sistolični</th>
					<th>Diastolični</th>
					<th></th>
				</tr>
				<c:forEach var="bpLog" items="${bp.bp}">
					<tr>
						<td>${bpLog.logId}</td>
						<td>${bpLog.systolic}</td>
						<td>${bpLog.diastolic}</td>
						<th><a href="#">Brisi</a></th>
					</tr>
				</c:forEach>
			</table>
			<hr />
		</c:if>
	</form>

	<h1>Vnesi podatke</h1>
	<form action="/fitbit/bp" method="post" id="post">
		<table>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" /></td>
			</tr>

			<tr>
				<td>Sistolični:</td>
				<td><input type="text" name="systolic" /></td>
			</tr>

			<tr>
				<td>Diastolični:</td>
				<td><input type="text" name="diastolic" /></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="Shrani podatke" /></td>
			</tr>
		</table>

	</form>
	
	<script type="text/JavaScript">
	$(document).ready(function(){
		   $('#view').validate ({
				   rules: {
					   date: {required: true, date: true}
				   }
		   });
	});
	
	$(document).ready(function(){
		   $('#post').validate ({
				   rules: {
					   date: {required: true, date: true},
					   systolic: {required: true, digits:true, min: 1, max: 300},
					   diastolic: {required: true, digits:true, min: 1, max: 300}
				   }
		   });
	});
	</script>
	
</rapid:override>

<%@include file="../template.jsp"%>