<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 
content="width=device-width, initial-scale=1, maximum-scale=1, 
minimum-scale=1, user-scalable=no, target-densitydpi=medium-dpi">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css"
	media="screen" />
<title>words Error Page</title>
</head>
<jsp:useBean id="now" class="java.util.Date" />
<body>
	<header>
		<h1>W<span class="tiny_font">izard </span>O<span class="tiny_font">f &nbsp;</span> W<span class="tiny_font">ords</span></h1>
	</header>
	<div align="center">
		<hr>
		<h2>words 오류발생!!</h2>
		<hr>

		<p>관리자(bettertoday@gmail.com)에게 문의주세요<br> 빠른 시일내에 해결하겠습니다.
			<br><br>${now} </p>
		<p>
			요청 실패 URI: ${pageContext.errorData.requestURI }<br> 상태코드:
			${pageContext.errorData.statusCode }<br> 예외유형:
			${pageContext.errorData.throwable }<br>
		
		<h3><a href="/words/words_main.jsp">시작화면으로 가기 </a></h3>
	</div>
</body>
</html>