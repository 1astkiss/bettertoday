<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:choose>
	<c:when test="${member_id != null }">
		<li><a href="#"> 틀린문제복습 &nbsp;&nbsp; </a></li>
		
			<!-- 출제권한이 있는 회원인 경우 문제출제 버튼 활성화 --> 
			<c:if test="${true}">
				<li><a href="add_question.jsp"> 문제출제 &nbsp;&nbsp; </a></li>
			</c:if>
		<li class="nav_menu_right"><form name="loginform" method="post"
				action="member_control.jsp">
		<input type="hidden" name="action" value="logout">
					<input type="submit" value="로그아웃">
			</form></li>
			<li class="nav_menu_right"><a href="#">회원정보 </a></li>
	</c:when>
	<c:otherwise>
		<li><a href="add_member.jsp">New User &nbsp;&nbsp;</a></li>
		<li class="nav_menu_right">
			<form name="loginform" method="post"
				action="member_control.jsp">
				<input type="hidden" name="action" value="login"> 
				<input type="text" name="member_id" placeholder="ID" size="10"> 
				<input type="password" name="passwd" placeholder="password" size="10"> <input
					type="submit" value="로그인">
			</form>
		</li>
	</c:otherwise>
</c:choose>
