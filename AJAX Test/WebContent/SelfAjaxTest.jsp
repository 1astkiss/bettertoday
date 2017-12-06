<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

System.out.println(request.getParameter("name"));
pageContext.setAttribute("name",request.getParameter("name"));

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<title>Insert title here</title>
<script>
$(function(){
	
	var request = new XMLHttpRequest();
	//request.open('get', 'SelfAjaxTest.jsp?name=c', false);
	request.open('get', 'data.jsp?name=c', false);
	
	request.send();
	$('#aa').append("${name}");
});
</script>
</head>
<body>
<H1 id="aa">aa</H1>

This is client data!!!

</body>
</html>