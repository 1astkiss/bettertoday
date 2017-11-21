<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<!-- 문제 DB로부터 가져오 문제들을 저장하는 LinkedList -->
<jsp:useBean id="questionDAO_result" class="java.util.LinkedList" scope="session">
</jsp:useBean>

<!-- 문제하나가 종료될때마다 회원별 이력을 담아 두는 객체  -->
<jsp:useBean id="mwh" class="words.question.MemberWordHistory">
	<!-- 문제풀이 페이지에서 넘어온 문제이력 데이터를 mwh에 저장 -->
	<jsp:setProperty name="mwh" property="*"/>
</jsp:useBean>

<!-- 문제이력 DB로 보내기 위한 회원별 문제풀이 이력을 임시로 저장해두는 객체  -->
<jsp:useBean id="word_history" class="java.util.ArrayList" scope="session"/>

<!-- 문제이력DB에 Access하는 객체 -->
<jsp:useBean id="mwh_dao" class="words.question.MemberWordHistoryDAO"/>

<!-- 문제DB에 Access하는 객체 -->
<jsp:useBean id="questions_dao" class="words.question.QuestionsDAO" />

<!-- 문제하나를 담아두는 객체 -->
<jsp:useBean id="question" class="words.question.Question">
	<!-- 문제출제 페이지에서 넘어온 데이타를 question 객체에 저장 -->
	<jsp:setProperty name="question" property="*" />
</jsp:useBean>

<%
	// 기본 파라미터 정리
	
	// LinkedList<Question> questionDAO_result = new LinkedList<Question>();
	// questionDAO_result = (LinkedList<Question>)session.getAttribute("questionDAO_result");
	
	// 컨트롤러페이지를 요청하는 페이지에서 넘겨주는 action 값
	String action = request.getParameter("action");

	// 문제풀이 페이지에서 넘겨주는 이력저장 여부 flag
	String history = request.getParameter("history");
	
	// 문제이력 DB로 보내기 위한 회원별 문제풀이 이력을 임시로 저장해두는 객체
	ArrayList<MemberWordHistory> mwh_list = new ArrayList<MemberWordHistory>();
	// session에 저장되어 있는 내용을 내려 받음
	mwh_list = (ArrayList<MemberWordHistory>)session.getAttribute("word_history");
	
	// 홈 url
	String home;
	String member_id = session.getAttribute("member_id").toString();
	int member_level= Integer.parseInt(session.getAttribute("member_level").toString());

	home = "words_main.jsp";

	switch(action){
	
	// 문제 출제	
	case "quiz":
		System.out.println(questionDAO_result.size());
		if(history != null && history.equals("yes")){
			System.out.println("count_tried : " + mwh.getCount_tried());
			mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			mwh_list.add(mwh);
			//System.out.println("first word in history : " + ((ArrayList<MemberWordHistory>)word_history).get(0).getHistory_id());
			session.setAttribute("word_history", mwh_list);
		}
		
		if(questionDAO_result.size() > 0){
			
		}else{
 			questionDAO_result = questions_dao.getQuestion(member_id);
 			
 			if(history != null){
 				if(mwh_dao.addMemberWordHistory((ArrayList<MemberWordHistory>)word_history)){
 					word_history.clear();
 				}
 			} 
 			
			System.out.println(questionDAO_result.size());
		}
		
		request.setAttribute("question", questionDAO_result.pop());
		session.setAttribute("questionDAO_result", questionDAO_result);
		// DB에서 가져온 문제를 request 객체에 담기
		pageContext.forward("quiz.jsp");
		 
		break;
	
	// 메인화면으로	
	case "home":
		if(history != null && history.equals("yes")){
			System.out.println("count_tried : " + mwh.getCount_tried());
			mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			mwh_list.add(mwh);
		
			if(mwh_dao.addMemberWordHistory((ArrayList<MemberWordHistory>)word_history)){
					word_history.clear();
			}
		}
		
		pageContext.forward(home);
		break;
		
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
		
	}
%>