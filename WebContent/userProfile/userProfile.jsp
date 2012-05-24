<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--@elvariable id="userInfo" type="com.fitbit.api.common.model.user.UserInfo"--%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Uporabnik</rapid:override>
<rapid:override name="body">
	<table>
		<tr>
			<td>Polno ime:</td>
			<td>${userInfo.fullName}</td>
		</tr>
		<tr>
			<td>Prikazno ime:</td>
			<td>${userInfo.displayName}</td>
		</tr>
		<tr>
			<td>Vzdevek:</td>
			<td>${userInfo.nickname}</td>
		</tr>
		<tr>
			<td>Spol:</td>
			<td>${userInfo.gender}</td>
		</tr>
		<tr>
			<td>Rojstni dan:</td>
			<td>${userInfo.dateOfBirth}</td>
		</tr>
		<tr>
			<td>Višina:</td>
			<td>${userInfo.height}</td>
		</tr>
		<tr>
			<td>Teža:</td>
			<td>${userInfo.weight}</td>
		</tr>
		<tr>
			<td>Število prehojenih korakov:</td>
			<td>${userInfo.strideLengthWalking}</td>
		</tr>
		<tr>
			<td>Število pretečenih korakov:</td>
			<td>${userInfo.strideLengthRunning}</td>
		</tr>
		<tr>
			<td>Mesto:</td>
			<td>${userInfo.city}</td>
		</tr>
		<tr>
			<td>Občina:</td>
			<td>${userInfo.state}</td>
		</tr>
		<tr>
			<td>Država:</td>
			<td>${userInfo.country}</td>
		</tr>
		<tr>
			<td>Časovni pas:</td>
			<td>${userInfo.timezone}</td>
		</tr>
		<tr>
			<td>Offset From UTC (Millis):</td>
			<td>${userInfo.offsetFromUTCMillis}</td>
		</tr>
	</table>
</rapid:override>

<%@include file="../template.jsp"%>