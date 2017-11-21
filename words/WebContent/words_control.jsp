<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<!-- 문제 DB로부터 가져온 문제들을 저장하는 LinkedList
	지정된 scope내에 정의되어 있지 않으면 새로 변수를 생성
	이미 정의되어 있으면 그 변수를 참조함
	참조하고자 하는 페이지마다 useBean 선언을 해주어야함.
	useBean 선언을 하지 않은 경우에는 session.getAttribute() 또는 표현언어를 사용하여 활용		
 -->
 
<jsp:useBean id="questionDAO_result" class="java.util.LinkedList" scope="session">
</jsp:useBean>

<!-- 문제하나가 종료될때마다 회원별 이력을 담아 두는 객체  -->
<jsp:useBean id="mwh" class="words.question.MemberWordHistory">
	<!-- 문제풀이 페이지에서 보내온 문제이력 데이터(시도 횟수, 문제 ID)를 mwh에 저장
	MemberWordHistory객체에 setter method가 정의 되어 있는 멤버변수만 자동으로 저장됨 -->
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
	// 컨트롤러페이지를 요청하는 페이지에서 넘겨주는 action 값
	String action = request.getParameter("action");

	// 문제풀이 페이지에서 넘겨주는 이력저장 여부 flag
	String history = request.getParameter("history");
	
	// 문제이력 DB로 보내기 위한 회원별 문제풀이 이력을 임시로 저장해두는 객체
	ArrayList<MemberWordHistory> mwh_list = new ArrayList<MemberWordHistory>();
	
	// 홈 url
	String home = "words_main.jsp";
	
	// 로그인 성공후 session에 저장해둔 회원 아이디와 회원 레벨을 가져와서 저장
	// getAttribute()의 리턴값이 객체이므로 toString()메소드를 사용
	String member_id = session.getAttribute("member_id").toString();
	int member_level= Integer.parseInt(session.getAttribute("member_level").toString());

	// 컨트롤러에 요청하는 action의 구분에 따른 처리
	switch(action){
	
	// 문제 출제를 요청한 경우	
	case "quiz":
		// 문제 이력저장을 요청한 경우 MemberWordHistory객체를 만들어  ArrayList에 추가
		if(history != null && history.equals("yes")){
			//MemberWordHistory객체에 회원ID와 회원레벨 정보를 추가
			mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			
			// 회원이력저장 ArrayList에 MemberWordHistory객체를 추가 
			word_history.add(mwh);
			
			// ArrayList를 session에 저장. 추후에 DB로 보낼때 session에서 꺼내서 보냄
			session.setAttribute("word_history", word_history);
		}
		
		// 아직 출제할 문제가 남아 있을 경우
		if(questionDAO_result.size() > 0){
			
		// 출제할 문제가 남아 있지 않은 경우 새로운 문제를 가져 옴
		}else{
			// 문제를 가져와서 ArrayList<Qeustion>에 저장
 			questionDAO_result = questions_dao.getQuestion(member_id);
 			
			// DB에 저장할 이력정보가 있는 경우 DB에 저장 시행
 			if(history != null){
 				if(mwh_dao.addMemberWordHistory(word_history)){
 					// 저장이 완료된 이력정보 임시저장소인 ArrayList를 청소
 					word_history.clear();
 				}
 			} 
		}
		
		// DB에서 가져온 문제중 첫 문제를 꺼내서 request 객체에 담음
		request.setAttribute("question", questionDAO_result.pop());
		
		// 페이지 이동시 session에 저장된 변수에 변경 내용을 저장해 두어야  추후에 변경된 내용을 활용할 수 있음
		session.setAttribute("questionDAO_result", questionDAO_result);
		
		// 문제 출제 페이지로 이동
		pageContext.forward("quiz.jsp");
		 
		break;
	
	// 메인화면으로	
	case "home":
		
		//문제 페이지에서 시작화면으로 이동하는 경우 현재까지 풀이한 문제의 이력을 저장
		if(history != null && history.equals("yes")){
			System.out.println("count_tried : " + mwh.getCount_tried());
			mwh.setMember_id(member_id);
			mwh.setMember_level(member_level);
			word_history.add(mwh);
		
			if(mwh_dao.addMemberWordHistory(word_history)){
					word_history.clear();
			}
		}
		
		// 시작페이지로 이동
		pageContext.forward(home);
		break;
		
	// 새로운 문제 등록 요청
	case "add":
		// Question객체의 문제 작성자 아이디 설정
		question.setCreator_id(member_id);
		
		// 문제DB에 Question객체를 저장
		if (questions_dao.newQuestion(question)) {
			// 저장이 성공하면 다음문제 출제를 위하여 문제 출제 페이지로 이동
			response.sendRedirect("add_question.jsp");
		} else {
			throw new Exception("문제 등록 오류!!");
		}
		
		break;
		
	}
	
%>