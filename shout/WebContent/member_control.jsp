<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="shout.member.Member, java.util.concurrent.TimeUnit, org.slf4j.*" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="member" class="shout.member.Member" >
	<!-- 신규회원 가입페이지에서 넘어온 데이타를 member객체에 저장 -->
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<jsp:useBean id="location" class="shout.member.MemberLocation" >
	<!-- 신규회원 가입페이지에서 넘어온 데이타를 member객체에 저장 -->
	<jsp:setProperty name="location" property="*" />
</jsp:useBean>

<jsp:useBean id="mdao" class="shout.member.MemberDAO" />
<jsp:useBean id="mldao" class="shout.member.MemberLocationDAO" />

<%
	// 요청 action 값
	String action = request.getParameter("action");
	Logger log = LoggerFactory.getLogger(this.getClass());
	String member_id = null;
	
	if(session.getAttribute("member_id") != null){
		member_id = session.getAttribute("member_id").toString();
	}
	
	switch(action){
	
		// 신규회원 등록
		case "add":
			// 신규회원 정보를 담은 Member객체를 DB에 추가
			if(mdao.addMember(member)){
				// 성공시 회원가입 성공 안내페이지로 이동
				response.sendRedirect("add_member_success.jsp");
			}else{
				log.error("member add failed for {}...", member.getMember_id());
				out.println("<script>document.write()'같은 아이디가 있네요...'); history.go(-1);</script>");
			}
			
			break;
			
		// 로그인
		case "login":
			Member memberInfoFromDB = new Member();
			
			// 로그인 폼에 입력한 아이디를 매개변수로 보내어 회원정보 객체를 가져옴
			memberInfoFromDB = mdao.login(member.getMember_id());
			
			// DB에서 가져온 회원정보의 password와 로그인 폼에 입력한 password가 일치할 경우 로그인 처리
			if(memberInfoFromDB.getPassword().equals(member.getPassword())){
				// session에 회원정보 (아이디, 문제출제권한여부, 회원레벨) 저장			
				session.setAttribute("member_id", memberInfoFromDB.getMember_id());
				session.setAttribute("member_type", memberInfoFromDB.getMember_type());
				session.setAttribute("password", memberInfoFromDB.getPassword());
				
				// 시작페이지로 이동
				pageContext.forward("shout_control.jsp?action=home");
			}else{
				out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.'); history.go(-1);</script>");
			}
			
			break;
			
		// 신규위치 등록
		case "new_location":
			
			location.setMember_id(member_id);
			
			// DB에서 가져온 회원정보의 password와 로그인 폼에 입력한 password가 일치할 경우 로그인 처리
			if(mldao.addLocation(location)){
				
				// 시작페이지로 이동
				pageContext.forward("shout_control.jsp?action=home");
			}else{
				out.println("<script>alert('위치정보 저장에 실패했습니다.'); history.go(-1);</script>");
			}
			
			break;
		
		// 로그아웃
		case "logout":
			//세션에 저장된 값 초기화
			session.invalidate();
			
			// 시작화면으로 이동
			response.sendRedirect("shout_main.jsp");
			
			break;
		}	
			
	/* // 회원정보 관리
	case "modify":
		if(mdao.modifyMember(member)){
			
			// 성공시 회원가입 성공 안내페이지로 이동
			response.sendRedirect("modify_member_success.jsp");
		}else{
			log.error("member modify for {} failed...", member.getMember_id());
			out.println("<script>document.write()'정보변경이 실패하였습니다...'); history.go(-1);</script>");
		}
		
		break;
		*/
	
	
	
	
%>
