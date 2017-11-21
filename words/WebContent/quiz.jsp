<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, words.question.Question"%>

<!-- 회원별 문제 이력 데이터를 저장하는 변수 -->
<jsp:useBean id="mwh" class="words.question.MemberWordHistory" scope="session"/>

<!-- words_control.jsp에서 보내온 Question 객제 (새로운 문제가 담겨 있음) -->
<jsp:useBean id="question" class="words.question.Question" scope="request"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Page</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<%
	//Question question = new Question();

	// words_control.jsp에서 넘겨준 Question객체를 local변수에저장
	// question = (Question) request.getAttribute("question");
	//request.setAttribute("answer", question.getAnswer());
	//request.setAttribute("word", question.getWord());
	//request.setAttribute("selection1", question.getSelection1());
	//request.setAttribute("selection2", question.getSelection2());
	//request.setAttribute("selection3", question.getSelection3());
	//request.setAttribute("selection4", question.getSelection4());
	//request.setAttribute("question_id", question.getQuestion_id());
%>

<script>

	var count_tried = 0;
	
	var save_history_and_go_home = function(){
		document.location.href='words_control.jsp?action=home&history=yes';
	};
	
	var check_answer = function(selected_answer) {
		var answer = '${question.answer}';
		
		count_tried++;
		
		//오답인 경우
		if (answer != selected_answer){
			switch(selected_answer){ 
			case 1:
				$(".1>a").addClass("wrong_answer");
				break;
			case 2:
				$(".2>a").addClass("wrong_answer");
				break;
			case 3:
				$(".3>a").addClass("wrong_answer");
				break;
			case 4:
				$(".4>a").addClass("wrong_answer");
				break;
			};
			
		}else{ //정답인 경우
			
			switch(selected_answer){ 
			case 1:
				$(".1>a").addClass("right_answer");
				break;
			case 2:
				$(".2>a").addClass("right_answer");
				break;
			case 3:
				$(".3>a").addClass("right_answer");
				break;
			case 4:
				$(".4>a").addClass("right_answer");
				break;
			};
		
			$('div').append("<tr id='next_quiz'>");
			$('div').append("<td colspan='2'>정답입니다!!!<br>"
			+ "<form method='post' action='words_control.jsp?action=quiz&history=yes'>"
			+ "<input type='hidden' name='question_id' value='${question.question_id}'>"
			+ "<input type='hidden' name='count_tried' value='' id='count_tried_next'>"
			+ "<input type='submit' value='다음문제'>"
			+ "</form>"
			+ "<form method='post' action='words_control.jsp?action=home&history=yes'>"
			+ "<input type='hidden' name='question_id' value='${question.question_id}'>"
			+ "<input type='hidden' name='count_tried' value='' id='count_tried_home'>"
			+ "<input type='submit' value='퀴즈그만' id='quit_button'>"
			+ "</form>"
			+ "</td>"
			+ "</tr>");
			$('#count_tried_next,#count_tried_home').attr('value', count_tried);
			$('form').css('display','inline');

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
				<td id="table_head" colspan="2">'${question.word}'</td>
			</tr>
			<tr>
				<td class="select 1" id="cc"><a
					href="javascript:check_answer(1)">( 1 )</a></td>
				<td id="1">${question.selection1 }</td>
			</tr>
			<tr>
				<td class="select 2"><a href="javascript:check_answer(2)">(
						2 )</a></td>
				<td id="2">${question.selection2 }</td>
			</tr>
			<tr>
				<td class="select 3"><a href="javascript:check_answer(3)">(
						3 )</a></td>
				<td id="3">${question.selection3 }</td>
			</tr>
			<tr>
				<td class="select 4"><a href="javascript:check_answer(4)">(
						4 )</a></td>
				<td id="4">${question.selection4 }</td>
			</tr>
		</table>

	</div>
</body>
</html>