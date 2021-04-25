<%@ page language="java" contentType="text/html; 
charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Page</title>
<style type="text/css">
fieldset {
	border: 1px solid #dedede;
}

legend {
	font-size: 20px;
	text-transform: uppercase;
}

.error {
	color: red;
}

.resltTable {
	width: 50%;
	border-collapse: collapse;
	border-spacing: 0px;
}

.resltTable td, .resltTable th {
	border: 1px solid #565454;
}
</style>
</head>
<body>
	<fieldset>
		<legend>User Input From</legend>
		<form:form action="saveuser" method="post" modelAttribute="user">
			<table>
				<tr>
					<th>First Name</th>
					<td><form:input path="fname" /><form:errors path="fname" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Last Name</th>
					<td><form:input path="lname" /><form:errors path="lname" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Email</th>
					<td><form:input path="email" /> <form:errors path="email" cssClass="error" /></td>
				</tr>
				<tr>
					<th>UserName</th>
					<td><form:input path="userName" /> <form:errors path="userName" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Password</th>
					<td><form:input path="password" /> <form:errors path="password" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Role</th>
					<td><form:input path="role" /> <form:errors path="role" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Gender</th>
					<td><form:input path="gender" /> <form:errors path="gender" cssClass="error" /></td>
				</tr>
				<tr>
					<th>Organization</th>
					<td><form:input path="organization" /> <form:errors path="organization" cssClass="error" /></td>
				</tr>
				<tr>
					<td><button type="submit">Submit</button></td>
				</tr>
			</table>
		</form:form>
	</fieldset>
	<br>
	<br>

	<fieldset>
		<legend>Users List</legend>
		<table class="resltTable">
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Email</th>
				<th>UserName</th>
				<th>Password</th>
				<th>Role</th>
				<th>Gender</th>
				<th>Organization</th>
			</tr>
			<c:forEach items="${users}" var="user">
				<tr>
					<td>${user.fname}</td>
					<td>${user.lname}</td>
					<td>${user.email}</td>
					<td>${user.userName}</td>
					<td>${user.password}</td>
					<td>${user.role}</td>
					<td>${user.gender}</td>
					<td>${user.organization}</td>
				</tr>
			</c:forEach>

		</table>
	</fieldset>

</body>
</html>