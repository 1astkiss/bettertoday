<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, words.question.Question"%>
<!-- JSTL을 사용하기 위한 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- words_control.jsp에서 보내온 Question 객체 LinkedList (새로운 문제가 담겨 있음) -->
<jsp:useBean id="questions" class="java.util.LinkedList" scope="request" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" 
content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Quiz Page</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script>
	window.onload = function() {
		
		// 퀴즈를 시작할때 첫번째 문제 load
		next_question();
	};

	// words_control.jsp에서 보내온 Question객체 LinkedList를 담아두기 위한 Array
	var q_array = new Array();
	
	// 현재 load된 문제
	var current_question;
	
	// 정답 여부를 확인하기 위해 현재 load된 문제의 정답(DB에서 가져온 값)을 보관
	var current_answer;
	
	// 회원별 문제풀이 이력을 저장했다가 words_control.jsp로 보내기 위해 임시보관하는 Array
	var history_array = new Array();
	
	// 문제를 몇번만에 맞추었는가를 저장
	var count_tried = 0;
	
	// 문제 최대 시도 가능 횟수. 3이상은 점수 산정이 같으므로 최대값을 3으로 설정
	var MAX_TRY = 3;
	
	// 문제 푸는 시간 제한. 제한된 시간내에 답을 click해야 함. 시간내에 안하면 한번 click한 것으로 간주
	var TIME_LIMIT = 5;
	
	// 설정한 시간 제한 timer함수의 id
	var intervalId1;
	var intervalId2;
	var intervalId3;
	
	// 회원별 문제풀이 이력 Array를 words_control.jsp로 보내기 위해 Json String으로 변환한 값
	var json_string = "";

	// request객체에 저장되어 있는 LinkedList(DB에서 가져온 문제)의 문제 정보를 JavaScript 변수에 저장
	<c:forEach var="i" items="${questions}" begin="0" varStatus="status">
		
		// 개별 문제 정보 저장
		var question = {
			'question_id' : '${i.question_id}',
			'word' : '${i.word}',
			'answer' : '${i.answer}',
			'selection1' : '${i.selection1}',
			'selection2' : '${i.selection2}',
			'selection3' : '${i.selection3}',
			'selection4' : '${i.selection4}',
			'weight' : '${i.weight}',
		};
	
		// 개별 문제를 Array에 저장
		q_array.push(question);
	
	</c:forEach>

	
	/***************************************
	
	사용자가 다음 문제 버튼을 눌렀을 때 다음 문제를 출제하는 함수 
	
	****************************************/
	var next_question = function() {
		
		// 문제 시도 횟수를 초기화하고 화면에 표시
		count_tried = 0;
		$('#out_count').html(count_tried);
		
		// 감추었던 타이머를 화면에 표시
		$('#timer').removeClass('hide_element');

		
		// 문제가 하나도 안 남아 있으면 새로운 문제를 가져옴
		if (q_array.length <= 0) {
			
			// 문제이력을 넘겨주면서 words_control로 이동하는 버튼을 시행
			$('#more_question_button').click();
			
		} else { //문제가 남아 있으면 해당 문제를 화면에 load
			
			// 문제 번호의 선택 초기화 
			$('td a').removeClass('wrong_answer');
			$('td a').removeClass('right_answer');
			
			// q_array에서 다음 문제를 꺼내서 load
			current_question = q_array.shift();
			current_answer = Number(current_question.answer);
			$('#table_head').html(current_question.word);
			$('#1').html(current_question.selection1);
			$('#2').html(current_question.selection2);
			$('#3').html(current_question.selection3);
			$('#4').html(current_question.selection4);
			$('#timer').html(TIME_LIMIT);
			$('#time_info').html(TIME_LIMIT);
			$('#next_table').addClass('hide_element');

			// 시간제한을 화면에 표시
			count_down();
		}
	};
	
	
	/***************************************
	
	다음의 경우 정답을 보여주고 문제 컨트롤을 활성화하는 함수
	1. 사용자가 정답을 click한 경우
	2. 최대 시도횟수에 도달한 경우
	
	****************************************/
	var mark_answer = function(answer){

		// 선택번호를 제외한 모든 선택번호 비활성화 
		switch (answer) {
		case 1:
			$('.2>a, .3>a, .4>a').addClass('wrong_answer');
			$(".1>a").addClass("right_answer");
			break;
		case 2:
			$('.1>a, .3>a, .4>a').addClass('wrong_answer');
			$(".2>a").addClass("right_answer");
			break;
		case 3:
			$('.1>a, .2>a, .4>a').addClass('wrong_answer');
			$(".3>a").addClass("right_answer");
			break;
		case 4:
			$('.1>a, .2>a, .3>a').addClass('wrong_answer');
			$(".4>a").addClass("right_answer");
			break;
		};
		
		
		// 다음문제 버튼, 퀴즈 더불러오기(숨김), 그만두기 버튼을 화면에 표시. 
		$('#next_table').removeClass('hide_element');
		$("#answer").html(current_answer);
			
		var score;
		
		switch(count_tried) {
		case 1:
			score = current_question.weight;
			break;
		case 2:
			score = current_question.weight * 0.5;
			break;
		case 3:
			score = current_question.weight * 0.5 * 0.5;
			break;
		default:
			score = 0;
		}
		
		// 문제별 history 객체 생성
		var history={
				'member_id': '${member_id}',
				'member_level': '${member_level}',
				'question_id': current_question.question_id,
				'count_tried': count_tried,
				'weight': current_question.weight,
				'score': score,
		};
		
		// history객체를 array에 저장
		history_array.push(history);
		
		// history가 저장된 Array객체를 words_control.jsp로 보내기 위해 String으로 변환
		json_string =  JSON.stringify(history_array);
		
		// json String을 request객체에 담아 보내기 위해 입력폼에 저장
		$('#history_array').attr('value',json_string);
		$('#history_array2').attr('value',json_string);
		
		// 문제풀이가 끝났으므로 타이머를 감춤
		$('#timer').addClass('hide_element');
		
	};
	
	/***************************************
	
	문제시도 횟수를 증가시키는 함수
		
	****************************************/
	var increase_count_tried = function(){
		
		// 문제시도 횟수 증가
		count_tried++;
		
		// 문제시도 횟수가 최대 시도횟수에 도달한 경우
		if(count_tried >= MAX_TRY){
			
			// 타이머 정지
			clearInterval(intervalId2);
			
			// 문제시도 횟수 표시
			$('#out_count').html(count_tried);
			
			// 문제시도 횟수 증가(0점 처리를 위해 시도횟수를 4로 세팅)
			count_tried++;
			
			// 문제 종료 및 정답 표시
			mark_answer(current_answer);
		}else{	
			// 문제시도 횟수 표시
			$('#out_count').html(count_tried);
		}
	};
	
	
	/***************************************
	
	시간제한(타이머)을 표시하는 함수
		

	****************************************/
	var count_down = function(){
		
		var time_remain = TIME_LIMIT;
		$('#timer').html(time_remain);
		
		// 1초마다 남은 시간을 감소시킴
		intervalId2 = setInterval(function(){
			$('#timer').html(--time_remain);
			
			if(time_remain == 0){
				time_remain = TIME_LIMIT;
				increase_count_tried(); //제한시간이 경과하면 시도횟수 1증가
				$('#timer').html(time_remain);
			}
		}, 1000);
		
	};
	/* var count_down = function(){
		
		// intervalId2가 작동시작하는데 5초가 걸리므로 처음 5초간 처리를 위한 코드
		count_down_sub();
		
		// 5초마다 타이머를 작동시키고 해지하는 일을 반복
		intervalId2 = setInterval(function(){
			
			count_down_sub(); //타이머 실행
			increase_count_tried(); //제한시간이 경과하면 시도횟수 1증가

		}, TIME_LIMIT * 1000);
	}; */
	
	/***************************************
	
	시간제한(타이머)을 표시하는 sub함수
		
	****************************************/
	var count_down_sub = function(){
		// 남은 시간을 제한 시간으로 초기화
		var time_remain = TIME_LIMIT;
		
		// 1초마다 남은 시간을 감소시킴
		// 아래 intervlaId2는 5초후에 시작이 되므로 처음 5초 동안을  위한 처리
		intervalId1 = setInterval(function(){
			time_remain--;
			$('#timer').html(time_remain);
		}, 1000);
		
		// 제한시간이 지나면 위에서 설정한 interval을 해제
		setTimeout(function(){
			clearInterval(intervalId1); //intervaId1을 해제
			time_remain = TIME_LIMIT; //남은시간 초기화  
			$('#timer').html(time_remain); //남은시간 표시
		}, (TIME_LIMIT) * 1000); //TIME_LIMIT을 msec으로 변환해서 적용
		
	}
	
	/***************************************
	
	  사용자가 답을 click하면 정답인지 확인하는 함수 
	
	****************************************/
	var check_answer = function(selected_answer) {

		//타이머 정지
		clearInterval(intervalId1);
		clearInterval(intervalId2);

		// 문제 시도 횟수를 1 증가하고 화면에 표시
		count_tried++;
		$('#out_count').html(count_tried);
 		
 
		//오답인 경우
		if (current_answer != selected_answer) {
			
			// 시도횟수가 시도 가능횟수를 초과하면 문제를 종료하고 정답을 표시
			if(count_tried >= MAX_TRY){
				
				count_tried++; // 0점 처리를 위해 시도횟수를 4로 세팅
				mark_answer(current_answer);
				
			}else{
				//선택한 답이 오답인 경우 선택한 답을 다시 선택하지 못하도록 처리
				switch (selected_answer) {
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
				
				// 다음 시도가 시작되었으므로 타이머 재실행
				count_down();				
				
			}
		} else { //정답을 선택한 경우 
			//정답을 표시하고 문제콘트롤을 활성화
			mark_answer(selected_answer);
		}
	};
	
</script>

<style>
form{
	display: inline;
}
</style>

<body>
	<header>
		<h1>My Simple Words</h1>
	</header>

	<div align="center">
		<hr>
		<h2 style="text-align: center; margin: 0px;">다음 문제에 <span id="time_info"></span>초내에 답하세요</h2>
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
		
		<h1 style="margin:0.2em;">Out Count : <span id='out_count'>0</span></h1>
				
		<H1 id='timer' style="margin:0.2em;"></H1>

		<table id='next_table'>
			<tr id='next_quiz'>
				<td align='center' valign='middle' height='30'>정답은 <span id="answer"></span>번 입니다!!!</td>
				</tr>
			<tr>
				<td>
					<input class='quiz_control' type='button' value='다음문제' onclick='next_question()'>
		
					<form class='hide_element' method='post' action='words_control.jsp?action=quiz'>
						<input type='hidden' name='history_array' value='' id='history_array2'>
						<input type='submit' value='퀴즈더' id='more_question_button'>
					</form>
		
					<form method='post' action='words_control.jsp?action=home'>
						<input type='hidden' name='history_array' value='' id='history_array'>
						<input class='quiz_control' type='submit' value='퀴즈그만' id='quit_button'>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>