<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 출제권한이 있는 회원인 경우 문제출제 페이지 링크 활성화 -->
<c:if test="${can_make_question == 1}">
	<form method = "post" action="modify_question.jsp">
		<input type='hidden' name='modify_question' value='' id='modify_question'>
		<input type='submit' value='문제수정' id='modify_q_btn'>
	</form>
</c:if>
