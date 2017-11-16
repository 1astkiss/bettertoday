<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="words"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My words</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	var check_answer = function(selected_answer) {
		
		//오답인 경우
		switch(selected_answer){
		case 1:
			$(".1>a").addClass("disabled");
			break;
		case 2:
			$(".2>a").addClass("disabled");
			break;
		case 3:
			$(".3>a").addClass("disabled");
			break;
		case 4:
			$(".4>a").addClass("disabled");
			break;
		}
	};
</script>
<style>

</style>

<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
	<header>
			<h1>My Simple Words</h1>
	</header>

	<div align="center">
	<br>
		<hr>
		<h2 style="text-align: center">다음 문제에 5초내에 답하세요</h2>
		<hr>
		<table id="question_table">
			<tr>
				<td id="table_head" colspan="2">delay</td>
			</tr>
			<tr>
				<td class="select 1" id="cc"><a href="javascript:check_answer(1)">( 1 )</a></td>
				<td>지연하다</td>
			</tr>
			<tr>
				<td class="select 2"><a href="javascript:check_answer(2)">( 2 )</a></td>
				<td>빨리가다</td>
			</tr>
			<tr>
				<td class="select 3"><a href="javascript:check_answer(3)">( 3 )</a></td>
				<td>돌아서다</td>
			</tr>
			<tr>
				<td class="select 4"><a href="javascript:check_answer(4)">( 4 )</a></td>
				<td>당연하다</td>
			</tr>
		</table>

		<a href="words_control.jsp?action=getall&cnt=${cnt+5 }&suid=${suid }">다음문제&gt;&gt;</a>
	</div>
</body>
</html>