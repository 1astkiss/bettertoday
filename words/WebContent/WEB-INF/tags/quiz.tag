<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- 회원이 로그인한 상태인 경우 -->
<c:choose>

	<c:when test="${member_id != null }">
		
		<!-- 퀴즈시작 페이지 링크 -->
		<hr>
		<h1 style="text-align: center"><a href="words_control.jsp?action=quiz">퀴즈 시작</a></h1>
		<hr>
		<ul class="info">
			<li>퀴즈시작을 누르면 시작됩니다.</li>
			<li>한 문제당 3번의 기회가 주어집니다.</li>
			<li>한번의 기회당 5초의 시간이 주어지며, <br>&nbsp;&nbsp;&nbsp; 5초이내에 답하지 않으면 한번의 기회가 사라집니다.</li>
			<li>기회를 적게 사용할 수록 점수가 높습니다.</li>
		</ul>
	</c:when>
	
	<c:otherwise>
		<hr>
	
		<!-- Welcome message 출력 -->
		<h2 style="text-align: center">Lets have some fun with words!!!</h2>
		<hr>
		<ul class="info">
			<li>회원가입후 로그인하시면 퀴즈가 시작됩니다.</li>
			<li>문제를 풀 수록 본인의 실력에 맞추어 <br>&nbsp;&nbsp;&nbsp; 문제가 나오기 시작합니다.</li>
		</ul>
	</c:otherwise>
</c:choose>
