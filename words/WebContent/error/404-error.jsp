<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>words: 404-error</title>
</head>
<body>
	<div align="center">
		<h2>words: 404-error 발생!</h2>
		<hr>

		<table>
			<tr width="100%" bgcolor="orange">
				<td>요청하신 파일을 찾을 수 없습니다. <br> URL주소를 다시한번 확인해 주세요...
				</td>
			</tr>
			<tr>
				<td>${now }
					<p>
						요청 실패 URI: ${pageContext.errorData.requestURI }<br> 상태코드:
						${pageContext.errorData.statusCode }<br>
				</td>
			</tr>
		</table>
		
		<h3><a href="words_control.jsp?action=home">시작화면으로 가기 </a></h3>
	</div>
</body>
</html>