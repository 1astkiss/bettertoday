<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, words.question.Question"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="words"%>
<jsp:useBean id="mwh" class="words.question.MemberWordHistory" scope="session"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My words</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<%
	Question question = new Question();
	question=(Question) request.getAttribute("question");
	request.setAttribute("answer", question.getAnswer());
	request.setAttribute("word", question.getWord());
	request.setAttribute("selection1", question.getSelection1());
	request.setAttribute("selection2", question.getSelection2());
	request.setAttribute("selection3", question.getSelection3());
	request.setAttribute("selection4", question.getSelection4());
	request.setAttribute("question_id", question.getQuestion_id());
%>

<script>

	var count_tried = 0;
	
	var save_history_and_go_home = function(){
		document.location.href='words_control.jsp?action=home&history=yes';
	};
	
	var check_answer = function(selected_answer) {
	var answer = '${answer}';
		
		count_tried++;
		
		//오답인 경우
		if (answer != selected_answer){
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
			
		}else{ //정답인 경우
			//$(document).ready(function(){ 
				//if($('#next_quiz').html() == null ){
					$('div').append("<tr id='next_quiz'>");
					$('div').append("<td colspan='2'>정답입니다!!!<br>"
					+ "<form method='post' action='words_control.jsp?action=quiz&history=yes'>"
					+ "<input type='hidden' name='question_id' value='${question_id}'>"
					+ "<input type='hidden' name='count_tried' value='' id='count_tried_next'>"
					+ "<input type='submit' value='다음문제'>"
					+ "</form>"
					+ "<form method='post' action='words_control.jsp?action=home&history=yes'>"
					+ "<input type='hidden' name='question_id' value='${question_id}'>"
					+ "<input type='hidden' name='count_tried' value='' id='count_tried_home'>"
					+ "<input type='submit' value='퀴즈그만' id='quit_button'>"
					+ "</form>"
					+ "</td>"
					+ "</tr>");
					$('#count_tried_next,#count_tried_home').attr('value', count_tried);
					$('form').css('display','inline');
/* 					$('div').append("<td colspan='2'>");
					$('div').append("정답입니다!!!<br>");
					$('div').append("<form method='post' action='words_control.jsp?action=quiz&history=yes'>");
					$('div').append("<input type='hidden' name='question_id' value='${question_id}'>");
					$('div').append("<input type='hidden' name='count_tried' value=" + count_tried + ">");
					$('div').append("<input type='submit' value='다음문제'>");
					$('div').append("<input type='button' onclick='words_control.jsp?action=home&history=yes' value='퀴즈그만'>");
//					$('div').append("<a href='words_control.jsp?action=quiz&history=yes'>다음문제&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;</a>");
//					$('div').append("<a href='words_control.jsp?action=home'>퀴즈그만&gt;&gt;</a>");
					$('div').append("</form>");
					$('div').append("</td>");
					$('div').append("</tr>"); */
				//}
			//});
			/* alert("correct!");
			document.location.href="words_control.jsp?action=quiz"; */
		}
	};
	
</script>
<script>

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
				<td id="table_head" colspan="2">'${word}'</td>
			</tr>
			<tr>
				<td class="select 1" id="cc"><a
					href="javascript:check_answer(1)">( 1 )</a></td>
				<td id="1">${selection1 }</td>
			</tr>
			<tr>
				<td class="select 2"><a href="javascript:check_answer(2)">(
						2 )</a></td>
				<td id="2">${selection2 }</td>
			</tr>
			<tr>
				<td class="select 3"><a href="javascript:check_answer(3)">(
						3 )</a></td>
				<td id="3">${selection3 }</td>
			</tr>
			<tr>
				<td class="select 4"><a href="javascript:check_answer(4)">(
						4 )</a></td>
				<td id="4">${selection4 }</td>
			</tr>
		</table>

	</div>
</body>
</html>