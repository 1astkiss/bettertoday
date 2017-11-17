<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, words.question.Question"%>
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
<%
	LinkedList<Question> questions = (LinkedList<Question>)request.getAttribute("result");
	Question question = new Question();
	int answer;
	question = questions.get(1);
	
	request.setAttribute("answer", question.getAnswer());
	request.setAttribute("word", question.getWord());
	request.setAttribute("selection1", question.getSelection1());
	request.setAttribute("selection2", question.getSelection2());
	request.setAttribute("selection3", question.getSelection3());
	request.setAttribute("selection4", question.getSelection4());
%>

<script>

	var answer = '${answer}';
	alert('${result.pop().answer}'); 
	alert('${result.pop().answer}'); 

	var check_answer = function(selected_answer) {
		
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
			
		}else{ //오답인 경우
			//$(document).ready(function(){ 
				//if($('#next_quiz').html() == null ){
					$('div').append("<tr id='next_quiz'>");
					$('div').append("<td colspan='2'>");
					$('div').append("정답입니다!!!<br>");
					$('div').append("<a href='words_control.jsp?action=quiz'>다음문제&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;</a>");
					$('div').append("<a href='words_control.jsp?action=home'>퀴즈그만&gt;&gt;</a>");
					$('div').append("</td>");
					$('div').append("</tr>");
				//}
			//});
			/* alert("correct!");
			document.location.href="words_control.jsp?action=quiz"; */
		}
	};
	
</script>
<script>
$(document).ready(function(){
	/* var question = ${result.pop()}; */
	/* alert(${result.peek().word}); */
	/* $("#table_head").html("delay");
	$("#1").html("달리다");
	$("#2").html("뛰다");
	$("#3").html("멈추다"); */
/* 	$("#4").html("지연하다");
 */});

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
				<td id="table_head" colspan="2">${word }</td>
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