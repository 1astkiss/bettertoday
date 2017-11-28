<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a new word</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />
<style>
h1 {
text-align:center;
	line-height: 50px;
	background: #333;
	color: #fff;
}

table {
	margin: auto;
}
</style>
</head>
<body>

	<div>
		<h1>Add a new word here</h1>
		<br>
		<form name="add_question" method="post"	action="words_control.jsp">
			<input type="hidden" name="action" value="add">
			<table id="question_table">
				<tr>
					<td id="table_head" colspan="2"><textarea name="word"
							placeholder="new word here...." cols="38" rows="3"></textarea></td>
				</tr>
				<tr>
					<td class="select 1" id="cc">( 1 )</td>
					<td><textarea name="selection1"
							placeholder="first selection here..." cols="33" rows="3"></textarea>
					</td>
				</tr>
				<tr>
					<td class="select 2">( 2 )</td>
					<td><textarea name="selection2"
							placeholder="second selection here..." cols="33" rows="3"></textarea></td>
				</tr>
				<tr>
					<td class="select 3">( 3 )</td>
					<td><textarea name="selection3"
							placeholder="third selection here..." cols="33" rows="3"></textarea></td>
				</tr>
				<tr>
					<td class="select 4">( 4 )</td>
					<td><textarea name="selection4"
							placeholder="fourth selection here..." cols="33" rows="3"></textarea></td>
				</tr>
				<tr>
					<td>Answer</td>
					<td><input type="radio" name="answer" value="1">(1)&nbsp; 
					<input type="radio" name="answer" value="2">(2)&nbsp; 
					<input type="radio" name="answer" value="3">(3)&nbsp; 
					<input type="radio" name="answer" value="4">(4) </td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="Add"> <input type="button"
						value="Home" onclick="document.location.href='words_main.jsp'" ></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>