<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>New User</title>
</head>
<body align="center">
	<H2>회원가입</h2>
	<hr>
	<form method="post" action="user_control.jsp?action=new">
		<table align="center">
			<tr>
				<td>Name</td>
				<td><input type="text" name="name" size="10" required></td>
			</tr>
			<tr>
				<td>ID</td>
				<td><input type="text" name="uid" size="10" required></td>
			</tr>
			<tr>
				<td>e-mail</td>
				<td><input type="email" name="email" size="10"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="passwd" size="10" required></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="회원등록"></td>
			</tr>
		</table>
	</form>
</body>
</html>