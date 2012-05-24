<%--@elvariable id="weight" type="java.lang.Double"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Teža</rapid:override>

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
	<form action="/fitbit/weigth" method="get" id="view">
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

		<c:if test="${weight != null}">
			<table>
				<tr>
					<td>Teža:</td>
					<td>${weight}</td>
				</tr>
			</table>
		</c:if>
	</form>

	<h1>Vnesi podatke</h1>
	<form action="/fitbit/weigth" method="post" id="post">
		<table>
			<tr>
				<td>Datum:</td>
				<td><input name="date" type="text" /></td>
			</tr>

			<tr>
				<td>Teža:</td>
				<td><input type="text" name="weight" /></td>
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
					   weight: {required: true, number:true}
					   
				   }
		   });
	});
	</script>
	
</rapid:override>


<%@include file="../template.jsp"%>