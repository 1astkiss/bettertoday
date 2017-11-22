<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, words.question.Question"%>
<!-- JSTL을 사용하기 위한 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- words_control.jsp에서 보내온 Question 객체 (새로운 문제가 담겨 있음) -->
<jsp:useBean id="question" class="words.question.Question" scope="page"/>

<!-- words_control.jsp에서 보내온 Question 객체 LinkedList (새로운 문제가 담겨 있음) -->
<jsp:useBean id="questions" class="java.util.LinkedList" scope="request"/>

<!-- 문제이력 DB로 보내기 위한 회원별 문제풀이 이력을 임시로 저장해두는 객체  -->
<jsp:useBean id="word_history" class="java.util.ArrayList" scope="session"/>

<!-- 회원별 문제 이력 데이터를 저장하는 변수 -->
<jsp:useBean id="mwh" class="words.question.MemberWordHistory" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Page</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
	window.onload = function(){
		next_question();
	};

	var q_array = new Array();
	var list_size = '${questions.size()}';
	var current_answer;
	var question_count = 0;
	
	<c:forEach var="i" items="${questions}" begin="0" varStatus="status">
		var question = {
			'word': '${i.word}',
			'answer': '${i.answer}',
			'selection1': '${i.selection1}',
			'selection2': '${i.selection2}',
			'selection3': '${i.selection3}',
			'selection4': '${i.selection4}',
		};
		
		q_array.push(question);
	
	</c:forEach>
	
		console.log(JSON.stringify(q_array));
	/* for(var i = 0; i < list_size; i++){
		var exp_str_answer = '\${questions.get(' + i + ').answer}';
		alert(exp_str_word);
		var exp_result = eval(exp_str_word);
		var exp_result = "'" + exp_str_word + "'";
		alert(exp_result);
		
	} */
	
	var next_question = function(){
		
		if(q_array.length <= 0){
			document.location.href='words_control.jsp?action=quiz&history=yes';
		}else{
			$('#next_table').remove();
			$('td a').removeClass('wrong_answer');
			$('td a').removeClass('right_answer');
			var current_question = q_array.shift();
			alert('size of questions before : ' + '${questions.size()}');
			alert('size of questions before : ' + '${questions.size()}');
			alert('question_count :' + question_count);
			
			if(false){
			'${questions.poll()}';
			S}
			<c:set target="${mwh}" property="question_id" value="${questions[0].question_id}" >
			</c:set>
			alert('mwh.question_id : ' + '${mwh.question_id}');
			alert('size of questions after : ' + '${questions.size()}');
			current_answer = current_question.answer;
			$('#table_head').html(current_question.word);
			$('#1').html(current_question.selection1);
			$('#2').html(current_question.selection2);
			$('#3').html(current_question.selection3);
			$('#4').html(current_question.selection4);
		}
		
		question_count++;
	};
	
	
	//alert(current_question .answer + ":" + current_question .selection1+":" + current_question .selection2);
	
	var count_tried = 0;
	
	var save_history_and_go_home = function(){
		document.location.href='words_control.jsp?action=home&history=yes';
	};
	
	var check_answer = function(selected_answer) {
		//var answer = '${question.answer}';
		
		count_tried++;
		
		//오답인 경우
		if (current_answer != selected_answer){
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
		
			$('div').append("<table id='next_table'><tr id='next_quiz'>"
			+"<td colspan='2'>정답입니다!!!<br>"
					+ "<input type='button' value='다음문제' onclick='next_question()'>"
			/* + "<form method='post' action='words_control.jsp?action=quiz&history=yes'>"
			+ "<input type='hidden' name='question_id' value='${question.question_id}'>"
			+ "<input type='hidden' name='count_tried' value='' id='count_tried_next'>"
			+ "<input type='submit' value='다음문제'>"
			+ "</form>" */
			+ "<form method='post' action='words_control.jsp?action=home&history=yes'>"
			+ "<input type='hidden' name='question_id' value='${question.question_id}'>"
			+ "<input type='hidden' name='count_tried' value='' id='count_tried_home'>"
			+ "<input type='submit' value='퀴즈그만' id='quit_button'>"
			+ "</form>"
			+ "</td>"
			+ "</tr></table>");
			$('#count_tried_next,#count_tried_home').attr('value', count_tried);
			$('form').css('display','inline');

			//MemberWordHistory객체에 회원ID와 회원레벨 정보를 추가
			<c:set target="${mwh}" property="member_id" value="${member_id}" />
			<c:set target="${mwh}" property="member_level" value="${member_level}"/>
			alert('count_tried : ' + count_tried);
			alert('${mwh.member_id}');
			
			alert('mwh.count_tried' + '${mwh.count_tried}');
			'${word_history.add(mwh)}';
			/* alert('${word_history.get(0).member_id}');
			alert('${word_history.get(0).count_tried}');
			alert('${word_history.get(0).member_level}'); */
			
			
			/* mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			
			// 회원이력저장 ArrayList에 MemberWordHistory객체를 추가 
			word_history.add(mwh);
			
			// ArrayList를 session에 저장. 추후에 DB로 보낼때 session에서 꺼내서 보냄
			session.setAttribute("word_history", word_history); */
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
		</table><br>

	</div>
</body>
</html>