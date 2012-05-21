<%--@elvariable id="userInfo" type="com.fitbit.api.common.model.user.UserInfo"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Uporabnik</title>
</head>
<body>

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

	<a href="http://localhost:8080/fitbit/heart?date=2012-05-16">Srce</a>
	<a href="http://localhost:8080/fitbit/weigth?date=2012-05-16">Teža</a>
	<a href="http://localhost:8080/fitbit/bp?date=2012-05-16">Krvni pritisk</a>
</body>
</html>