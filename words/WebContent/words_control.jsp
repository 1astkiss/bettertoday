<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<jsp:useBean id="question" class="words.question.Question" />
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

	home = "word_main.jsp";

	switch(action){
	
	
	// 새로운 문제 등록
	case "add":
		// getAttribute()의 return값이 object이므로 toString()사용
		question.setCreator_id(session.getAttribute("member_id").toString());
		if (questions_dao.newQuestion(question)) {
			response.sendRedirect("add_question.jsp");
		} else {
			throw new Exception("문제 등록 오류!!");
		}
		
		break;
		
	// 문제 출제	
	case "quiz":
		
		/* ArrayList<question> questions = questions_dao.getQuestion();
		
		// 게시글 목록
		request.setAttribute("datas", datas);
		
		// 특정 회원 only인 경우 회원 uid 저장
		request.setAttribute("suid", suid);
		
		// 현재 페이지 카운트 정보 저장
		request.setAttribute("cnt", mcnt);
		
		pageContext.forward("words_main.jsp");
		 */
		break;
	}
%>