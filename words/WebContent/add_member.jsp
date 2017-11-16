<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a new member</title>
<style>
h2 {
	text-align : center;
}

table {
	margin: auto;
}

tr:last-child {
	text-align : center;
}

</style>
</head>
<body>
	<H2>회원가입</h2>
	<hr>
	<form method="post" action="member_control.jsp?action=add">
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="member_id" size="10" required></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="passwd" size="10" required></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="nickname" size="30" placeholder="실명 혹은 영어 이름(nickname)" required></td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td><input type="email" name="email" size="10"></td>
			</tr>
			<tr>
				<td>출생년도</td>
				<td><input type="number" name="birth_year" min="1900" max="2030" step="1" value="2001" required></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="회원등록"></td>
			</tr>
		</table>
	</form>
</body>
</html>