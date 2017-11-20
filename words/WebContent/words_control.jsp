<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<jsp:useBean id="result" class="java.util.LinkedList" scope="session"/>
<jsp:useBean id="word_history" class="java.util.ArrayList" scope="session"/>
<jsp:useBean id="mwh" class="words.question.MemberWordHistory">
<jsp:setProperty name="mwh" property="*"/>
</jsp:useBean>
<jsp:useBean id="mwh_dao" class="words.question.MemberWordHistoryDAO"/>
<jsp:useBean id="questions_dao" class="words.question.QuestionsDAO" />

<jsp:useBean id="question" class="words.question.Question">
<!-- Property 설정 -->
<jsp:setProperty name="question" property="*" />
</jsp:useBean>

<%
	// 기본 파라미터 정리
	// 컨트롤러 요청 action 값
	String action = request.getParameter("action");
	System.out.println("action at words_control : " + action);
	String history = request.getParameter("history");
	ArrayList<MemberWordHistory> mwh_list = new ArrayList<MemberWordHistory>();
	mwh_list = (ArrayList<MemberWordHistory>)session.getAttribute("word_history");
	MemberWordHistory mwh2 = new MemberWordHistory();
	//mwh2 = (MemberWordHistory)request.getAttribute("mwh");
	
	// 홈 url
	String home;
	String member_id = session.getAttribute("member_id").toString();
	int member_level= Integer.parseInt(session.getAttribute("member_level").toString());

	home = "words_main.jsp";

	switch(action){
	
	// 문제 출제	
	case "quiz":
		System.out.println(result.size());
		if(history != null && history.equals("yes")){
//			MemberWordHistory mwh2 = (MemberWordHistory)request.getAttribute("mwh");
			System.out.println("count_tried : " + mwh.getCount_tried());
			mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			mwh_list.add(mwh);
			session.setAttribute("word_history", mwh_list);
		}
		
		if(result.size() > 0){
			
		}else{
 			result = questions_dao.getQuestion(member_id);
 			
 			if(history != null){
 				if(mwh_dao.addMemberWordHistory((ArrayList<MemberWordHistory>)word_history)){
 					word_history.clear();
 				}
 			}
 			
			System.out.println(result.size());
		}
		
		request.setAttribute("question", result.pop());
		session.setAttribute("result", result);
		// DB에서 가져온 문제를 request 객체에 담기
		pageContext.forward("quiz.jsp");
		 
		break;
	
	// 메인화면으로	
	case "home":
		if(history != null && history.equals("yes")){
//			MemberWordHistory mwh2 = (MemberWordHistory)request.getAttribute("mwh");
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