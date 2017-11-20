<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="words.member.Member, java.util.concurrent.TimeUnit" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="member" class="words.member.Member" >
<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<jsp:useBean id="mdao" class="words.member.MemberDAO" />

<%
	// 요청 action 값
	String action = request.getParameter("action");

	switch(action){
	
	// 신규회원 등록
	case "add":
		
		if(mdao.addMember(member)){
			response.sendRedirect("add_member_success.jsp");
		}else{
			out.println("<script>document.write()'같은 아이디가 있네요...'); history.go(-1);</script>");
		}
		
		break;
		
	// 로그인
	case "login":
		Member result = new Member();
		System.out.println("member id before login() : " + member.getMember_id());
		result= mdao.login(member.getMember_id());
		if(result.getPasswd().equals(member.getPasswd())){
			System.out.println("member_id : " + session.getAttribute("member_id"));
			session.setAttribute("member_id", member.getMember_id());
			session.setAttribute("can_make_question", result.getCan_make_question());
			System.out.println("member_level at member_control.jsp before setting : " + result.getMember_level());
			session.setAttribute("member_level", result.getMember_level());
			System.out.println("member_level at member_control.jsp after setting : " + session.getAttribute("member_level"));
			pageContext.forward("words_main.jsp?");
		}else{
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.'); history.go(-1);</script>");
		}
		
		break;
		
	// 로그아웃
	case "logout":
		//세션에 저장된 값 초기화
		session.removeAttribute("member_id");
		
		// 시작화면으로 이동
		response.sendRedirect("words_main.jsp");
		
		break;
	}
%>
