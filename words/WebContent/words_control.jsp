<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" %>

<%@ page import="words.question.*, words.member.*, java.util.*, java.lang.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 메시지 처리 beans -->
<jsp:useBean id="msg" class="words.question.Message" />
<jsp:useBean id="msgdao" class="words.question.MessageDAO" />
<jsp:useBean id="reply" class="words.question.Reply" />

<!-- Property 설정 -->
<jsp:setProperty name="msg" property="*" />
<jsp:setProperty name="reply" property="*" />

<%
	// 기본 파라미터 정리
	// 컨트롤러 요청 action 값
	String action = request.getParameter("action");

	// 다음 페이지 요청 카운트
	String cnt = request.getParameter("cnt");

	// 특정 회원 게시물 only
	String suid;
	suid = request.getParameter("suid");

	// 홈 url
	String home;

	// 메시지 페이지 카운트
	int mcnt;

	if ((cnt != null) && (suid != null)) {
		// 각 action 처리 후 메인으로 돌아가기 위한 기본 url
		home = "words_control.jsp?action=getall&cnt=" + cnt + "&suid=" + suid;
		mcnt = Integer.parseInt(request.getParameter("cnt"));
	} else {
		// 게시물 작성시 현재 상태와 상관없이 전체 게시물의 첫페이지로 이동하기 위한 url
		home = "words_control.jsp?action=getall";

		// 첫 페이지 요청인 경우 기본 게시물 5개씩
		mcnt = 5;
	}

	// 댓글이 달린 게시물 위치 정보 : accordion 상태 유지 목적
	request.setAttribute("curmsg", request.getParameter("curmsg"));

	// 새로운 메시지 등록
	if (action.equals("newmsg")) {
		if (msgdao.newMsg(msg)) {
			response.sendRedirect(home);
	//		pageContext.forward(home);
		} else {
			throw new Exception("메시지 등록 오류!!");
		}
	
	// 댓글 등록	
	} else if (action.equals("newreply")) {
		System.out.println(reply.getRmsg());
		if(msgdao.newReply(reply)){
			pageContext.forward(home);
		}else{
			throw new Exception("댓글 등록 오류!!");
		}
		
	// 메시지 삭제
	}else if(action.equals("delmsg")){
		if(msgdao.delMsg(reply.getMid())){
		//	response.sendRedirect(home);
			System.out.println("home : " + home);
			pageContext.forward(home);
		}else{
			throw new Exception("메시지 삭제 오류!!");
		}

	// 댓글 삭제
	}else if(action.equals("delreply")){
		System.out.println("reply.getRid() : " + reply.getRid());
		if(msgdao.delReply(reply.getRid())){
			pageContext.forward(home);
		}else{
			throw new Exception("댓글 삭제 오류!!");
		}

	// 전체 게시글 가져오기	
	}else if(action.equals("getall")){
		System.out.println("getall at words_control.jsp");
		ArrayList<MessageSet> datas = msgdao.getAll(mcnt, suid);
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		
		// 게시글 목록
		request.setAttribute("datas", datas);
		
		// 신규 회원 목록
		request.setAttribute("users", nusers);
		
		// 특정 회원 only인 경우 회원 uid 저장
		request.setAttribute("suid", suid);
		
		// 현재 페이지 카운트 정보 저장
		request.setAttribute("cnt", mcnt);
		
		pageContext.forward("words_main.jsp");
	
	// 좋아요 추가
	}else if(action.equals("fav")){
		System.out.println("msg.getMid() : " + msg.getMid());
		msgdao.favorite(msg.getMid());
		pageContext.forward(home);
	}
%>