<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


	<c:choose>
		<c:when test="${uid != null }">
<form name="loginform" method="post" action="user_control.jsp">
			<li><a href="#"> :: </a></li>

			<!-- 출제권한이 있는 회원인 경우 문제출제 버튼 활성화 -->
			<c:if test="${true}">
				<li><a href="#"> 문제 출제 &nbsp;&nbsp; </a></li>
			</c:if>
			
			<li><a href="#"> 틀린문제 복습 &nbsp;&nbsp; </a></li>
			<input type="hidden" name="action" value="logout">
			<input type="submit" value="로그아웃">
</form>
		</c:when>
		<c:otherwise>
			<li><a href="new_user.jsp">New User &nbsp;&nbsp;</a></li>
<li><form name="loginform" method="post" action="user_control.jsp">
			<input type="hidden" name="action" value="login">
			<span>ID : </span><input type="text" name="uid" size="10">
			<span>&nbsp;Password : </span><input type="password" name="passwd" size="10">
			<input type="submit" value="로그인">
</form></li>
		</c:otherwise>
	</c:choose>
