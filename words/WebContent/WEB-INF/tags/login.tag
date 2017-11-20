<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


	<!-- 회원이 로그인한 상태인 경우 -->
<c:choose>

	<c:when test="${member_id != null }">
		<!--  틀린문제 복습페이지로 링크 -->
		<li><a href="#"> 틀린문제복습 &nbsp;&nbsp; </a></li>

		<!-- 출제권한이 있는 회원인 경우 문제출제 페이지 링크 활성화 -->
		<c:if test="${can_make_question == 1}">
			<li><a href="add_question.jsp"> 문제출제 &nbsp;&nbsp; </a></li>
		</c:if>

		<!--  로그아웃 링크 -->
		<li class="nav_menu_right">
			<form name="loginform" method="post" action="member_control.jsp">
				<input type="hidden" name="action" value="logout"> 
				<input type="submit" value="로그아웃">
			</form>
		</li>
		
		<!--  회원정보 링크 -->
		<li class="nav_menu_right"><a href="#">회원정보 </a></li>
	</c:when>
	
	<c:otherwise>
		<!-- 신규회원 가입 페이지 링크 -->
		<li><a href="add_member.jsp">New User &nbsp;&nbsp;</a></li>
		
		<!--  로그인 폼 : 아이디, 패스워드입력 -->
		<li class="nav_menu_right">
			<form name="loginform" method="post" action="member_control.jsp">
				<input type="hidden" name="action" value="login">
				<input type="text" name="member_id" placeholder="ID" size="10">
				<input type="password" name="passwd" placeholder="password" size="10">
				<input type="submit" value="로그인">
			</form>
		</li>
	</c:otherwise>
</c:choose>
