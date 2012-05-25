<%--@elvariable id="heart" type="com.fitbit.api.common.model.heart.Heart"--%>
<%--@elvariable id="date" type="java.lang.String"--%>
<%--@elvariable id="errors" type="java.util.List"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>

<rapid:override name="title">Srce</rapid:override>


<rapid:override name="showForm">
	<%@include file="../common/errors.jsp"%>
	<jsp:include page="../common/showForm.jsp">
		<jsp:param value="/fitbit/heart" name="action" />
	</jsp:include>
</rapid:override>


<rapid:override name="postForm">
	<form action="/fitbit/heart" method="post" id="post"
		class="ym-form ym-columnar">

		<h2>Vnesi podatke</h2>

		<div class="ym-fbox-text">
			<label for="date_post">Datum:</label> <input id="date_post"
				name="date" type="text" value="${date}" />
		</div>
		<div class="ym-fbox-text">
			<label for="tracker">Tracker:</label> <input id="tracker"
				name="tracker" type="text" value="" />
		</div>
		<div class="ym-fbox-text">
			<label for="rate">Pulz:</label> <input id="rate" name="rate"
				type="text" value="" />
		</div>
		<div class="ym-fbox-text">
			<label for="time">Čas:</label> <input id="time" name="time"
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
					tracker : {
						required : true
					},
					rate : {
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

	<h1>Podatki o srčnem utripu za ${date}.</h1>

	<table border="2">
		<tr>
			<th>Pulz</th>
			<th>Čas</th>
			<th>Tracker:</th>
			<th></th>
		</tr>
		<c:forEach var="log" items="${heart.heartLog}">

			<tr id="${log.logId}_row">
				<td>${log.heartRate}</td>
				<td>${log.time}</td>
				<td>${log.tracker}</td>
				<td>
					<form id="${log.logId}_form" action="deleteHeartRate" method="get">
						<input name="id" type="hidden" value="${log.logId}" />
						<div class="ym-fbox-button">
							<button id="${log.logId}_button" type="button"
								class="ym-button ym-delete" style="margin: 0">Izbrisi</button>
							<script type="text/javascript">
								$("#${log.logId}_button")
										.click(
												function() {
													dataString = "id="
															+ "${log.logId}";

													$
															.getJSON(
																	"deleteHeartRate?",
																	dataString,
																	function(
																			data) {
																		if (data.succesful) {
																			$(
																					"#${log.logId}_row")
																					.remove();
																			alert(data.message);
																		} else {
																			alert(data.message);
																		}
																	});
												});
							</script>
						</div>
					</form>
				</td>
			</tr>

		</c:forEach>
	</table>

</rapid:override>

<%@include file="../template.jsp"%>