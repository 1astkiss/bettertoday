<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<jsp:useBean id="question" class="words.question.Question" />
<jsp:useBean id="result" class="java.util.ArrayList" />
<jsp:useBean id="questions_dao" class="words.question.QuestionsDAO" />

<!-- Property 설정 -->
<jsp:setProperty name="question" property="*" />

<%
	// 기본 파라미터 정리
	// 컨트롤러 요청 action 값
	String action = request.getParameter("action");
	System.out.println("action at words_control : " + action);

	// 홈 url
	String home;
	String member_id = session.getAttribute("member_id").toString();

	home = "words_main.jsp";

	switch(action){
	
	
	// 새로운 문제 등록
	case "add":
		// getAttribute()의 return값이 object이므로 toString()사용
		question.setCreator_id(member_id);
		if (questions_dao.newQuestion(question)) {
			response.sendRedirect("add_question.jsp");
		} else {
			throw new Exception("문제 등록 오류!!");
		}
		
		break;
		
	// 문제 출제	
	case "quiz":
 		result = questions_dao.getQuestion(member_id);
 		request.setAttribute("result", result);
 		
		// DB에서 가져온 문제를 request 객체에 담기
		pageContext.forward("quiz.jsp");
		 
		break;
	
	// 메인화면으로	
	case "home":
		pageContext.forward(home);
		break;
	}
%>