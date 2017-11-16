<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:choose>
	<c:when test="${member_id != null }">
		<h2 style="text-align: center"><a href="words_control.jsp?action=quiz">퀴즈 시작</a></h2>
	</c:when>
	<c:otherwise>
		
	</c:otherwise>
</c:choose>
