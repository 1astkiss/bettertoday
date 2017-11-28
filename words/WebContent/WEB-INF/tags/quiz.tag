<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- 회원이 로그인한 상태인 경우 -->
<c:choose>

	<c:when test="${member_id != null }">
		
		<!-- 퀴즈시작 페이지 링크 -->
		<h1 style="text-align: center"><a href="words_control.jsp?action=quiz">퀴즈 시작</a></h1>
	</c:when>
	
	<c:otherwise>
	
		<!-- Welcome message 출력 -->
		<h2 style="text-align: center">Lets have some fun with words</h2>
	</c:otherwise>
</c:choose>
