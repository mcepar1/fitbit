<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${errors != null}">
	<h1>Napake:</h1>
	<ul>
		<c:forEach var="message" items="${errors}">
			<li>${message}</li>
		</c:forEach>
	</ul>
</c:if>