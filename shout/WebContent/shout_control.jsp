<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>
<%@ page import="shout.member.*, java.util.*, java.lang.*, org.json.*, javax.swing.JOptionPane" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="mdao" class="shout.member.MemberDAO" />



<%
	/*************************************************
	기본 변수 정의
	*************************************************/
	
	// 홈 url
	String home = "shout_main.jsp";

	// 컨트롤러페이지를 요청하는 페이지에서 넘겨주는 action 값
	String action = request.getParameter("action");

	// 컨트롤러페이지를 요청하는 페이지에서 넘겨주는 renew_score 값
	String renew_score = request.getParameter("renew_score");
	
	// 로그인 성공후 session에 저장해둔 회원 아이디와 회원 레벨을 가져와서 저장
	// getAttribute()의 리턴값이 객체이므로 toString()메소드를 사용
	String member_id = session.getAttribute("member_id").toString();
	int member_type= Integer.parseInt(session.getAttribute("member_type").toString());
	
	// 컨트롤러에 요청하는 action의 구분에 따른 처리
	switch(action){
	
		// 메인화면으로	
		case "home":
			
			// 시작페이지로 이동
			pageContext.forward(home);
			break;
			
	
	/* // 최근에 틀린문제 복습을 요청한 경우
	case "modify":
		System.out.println("modify");
		
		// 문제DB를 update
		if (questions_dao.modifyQuestion(question)) {
			// 수정이 성공하면 성공 페이지로 이동
			pageContext.forward("modify_question_success.jsp");
		} else {
			throw new Exception("문제 수정 오류!!");
		}
		
		break;
		
	// 최근에 틀린문제 복습을 요청한 경우
	case "missed":
		
		// 새로운 문제를 가져오기 전에 기존의 문제들을 비움
		questionDAO_result.clear();
		
		int missed_cnt = 20;
		
		// 문제를 가져와서 ArrayList<Qeustion>에 저장
		questionDAO_result = questions_dao.getQuestion(member_id, member_level, missed_cnt);
			
		if(questionDAO_result.size() == 0){
			pageContext.forward(home);		
			//JOptionPane.showMessageDialog(null, "not enough questions for you");
			System.out.println("not enough questions for you");
			return;
		}
		// DB에서 가져온 문제들을 request 객체에 담음 (quiz.jsp로 보내기 위해)
		request.setAttribute("questions", questionDAO_result);
		
		// 문제 출제 페이지로 이동
		pageContext.forward("quiz_missed.jsp");
		
		break;
	
	// 문제 출제를 요청한 경우	
	case "quiz":
		
		// 저장해야할 문제이력이 있는 경우
		if(word_history.size() > 0){
			
			// 문제이력을 저장
			if(mwh_dao.addMemberWordHistory(word_history)){
				
				// 저장이 완료된 이력정보 ArrayList를 비움
				word_history.clear();
				
				// update된 이력정보를 바탕으로 신규 member_level 산정
				int newMemberLevel = mdao.chkMemberLevel(member_id);
				
				//신규 member_level 산정에 실패한 경우
				if(newMemberLevel == 0){
					
					//신규 member_level 산정에 성공한 경우	
				}else if(mdao.setMemberLevel(member_id, newMemberLevel)){
					//session객체의 member_level update
					session.setAttribute("member_level", newMemberLevel);
				}
			}
			
		}
		
		// 새로운 문제를 가져오기 전에 기존의 문제들을 비움
		questionDAO_result.clear();
		
		// 문제를 가져와서 ArrayList<Qeustion>에 저장
		questionDAO_result = questions_dao.getQuestion(member_id, member_level);
			
		if(questionDAO_result.size() == 0){
			pageContext.forward(home);		
			//JOptionPane.showMessageDialog(null, "not enough questions for you");
			System.out.println("not enough questions for you");
			return;
		}
		// DB에서 가져온 문제들을 request 객체에 담음 (quiz.jsp로 보내기 위해)
		request.setAttribute("questions", questionDAO_result);
		
		// 문제 출제 페이지로 이동
		pageContext.forward("quiz.jsp");
		
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
		 */
	}
	
%>