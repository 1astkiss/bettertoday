<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

	System.out.println(request.getParameter("name"));
	pageContext.setAttribute("name",request.getParameter("name"));

%>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script>
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
	$('#aa').append("<br>url : " + url);
    
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

/* $('#aa').append("<br>" + getParameterByName("name")); */
$('#aa').append("${name}");

</script>
