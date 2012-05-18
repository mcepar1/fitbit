<%--@elvariable id="bp" type="com.fitbit.api.common.model.bp.Bp"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Krvni pritisk</title>
</head>
<body>

	<h1>Prikaži podatke</h1>
	<form action="/fitbit/bp" method="get">
		<table>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" value="${date}"/></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="Prikaži" /></td>
			</tr>
		</table>

		<c:if test="${bp != null}">
			<c:forEach var="bpLog" items="${bp.bp}">
				<table>
					<tr>
						<td>Systolic:</td>
						<td>${bpLog.systolic}</td>
					</tr>
					<tr>
						<td>Diastolic:</td>
						<td>${bpLog.diastolic}</td>
					</tr>
				</table>
				<hr />
			</c:forEach>
		</c:if>
	</form>

<h1>Vnesi podatke</h1>
	<form action="/fitbit/bp" method="post">
		<table>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" /></td>
			</tr>

			<tr>
				<td>Systolic:</td>
				<td><input type="text" name="systolic" /></td>
			</tr>
			
			<tr>
				<td>Diastolic:</td>
				<td><input type="text" name="diastolic" /></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" value="Shrani podatke" /></td>
			</tr>
		</table>

	</form>
</body>
</html>