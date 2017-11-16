<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="words.member.Member, java.util.concurrent.TimeUnit" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="member" class="words.member.Member" />
<jsp:setProperty name="member" property="*" />
<jsp:useBean id="mdao" class="words.member.MemberDAO" />

<%
	// 요청 action 값
	String action = request.getParameter("action");

	// 신규회원 등록
	if(action.equals("new")){
		if(mdao.addMember(member)){
//			out.println("<script>document.write('등록 성공!<br>3초후 시작페이지로 이동합니다~'); setTimeout(function(){document.location.href = 'words_main.jsp';},3000);</script>");
			response.sendRedirect("new_user_success.jsp");
		}else{
			out.println("<script>document.write()'같은 아이디가 있네요...'); history.go(-1);</script>");
		}
		
	// 로그인
	}else if(action.equals("login")){
		if(mdao.login(member.getUid(), member.getPasswd())){
			session.setAttribute("uid", member.getUid());
			System.out.println("logged in");
			response.sendRedirect("words_control.jsp?action=getall");
			//pageContext.forward("words_control.jsp?action=getall");
		}else{
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.'); history.go(-1);</script>");
		}
		
	// 로그아웃
	}else if(action.equals("logout")){
		//세션에 저장된 값 초기화
		session.removeAttribute("uid");
		
		// 시작화면으로 이동
		response.sendRedirect("words_control.jsp?action=getall");
	}
%>
