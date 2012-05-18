<%--@elvariable id="heart" type="com.fitbit.api.common.model.heart.Heart"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Srce</title>
</head>
<body>

	<c:if test="${errors != null}">
		<h1>Napake:</h1>
		<ul>
			<c:forEach var="message" items="${errors}">
				<li>${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<h1>Prikaži podatke</h1>
	<form action="/fitbit/heart" method="get">
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
	</form>

	<c:if test="${heart != null}">
		<c:forEach var="log" items="${heart.heartLog}">
			<table>
				<tr>
					<td>Pulz:</td>
					<td>${log.heartRate}</td>
				</tr>
				<tr>
					<td>Čas:</td>
					<td>${log.time}</td>
				</tr>
				<tr>
					<td>Tracker:</td>
					<td>${log.tracker}</td>
				</tr>
			</table>
			<hr />
		</c:forEach>
	</c:if>

	<h1>Vnesi podatke</h1>
	<form action="/fitbit/heart" method="post">
		<table>
			<tr>
				<td>Tracker:</td>
				<td><input name="tracker" type="text" /></td>
			</tr>
			<tr>
				<td>Pulz:</td>
				<td><input name="rate" type="text" /></td>
			</tr>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" /></td>
			</tr>
			<tr>
				<td>Čas:</td>
				<td><input name="time" type="text" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Pošlji" /></td>
			</tr>
		</table>
	</form>
</body>
</html>