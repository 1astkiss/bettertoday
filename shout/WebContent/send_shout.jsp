<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<!-- JSTL을 사용하기 위한 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--  custom tag을 사용하기 위한 처리 -->
<%@ taglib tagdir="/WEB-INF/tags" prefix="shout"%>

<jsp:useBean id="mdao" class="shout.member.MemberDAO" />

<%
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" 
content="width=device-width, initial-scale=1, maximum-scale=1, 
minimum-scale=1, user-scalable=no, target-densitydpi=medium-dpi">
<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />

<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<title>My words</title> 
<style>

html, body {
	height: 100%;
}

#map {
	height: 50%;
}

</style>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script>
function getDistanceFromLatLon(lat1,lon1,lat2,lon2) {
	  var R = 6371*1000; // Radius of the earth in km
	  var dLat = deg2rad(lat2-lat1);  // deg2rad below
	  var dLon = deg2rad(lon2-lon1); 
	  var a = 
	    Math.sin(dLat/2) * Math.sin(dLat/2) +
	    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
	    Math.sin(dLon/2) * Math.sin(dLon/2)
	    ; 
	  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
	  var d = R * c; // Distance in km
	  return d;
	}

	function deg2rad(deg) {
	  return deg * (Math.PI/180)
	}
	
var distance = getDistanceFromLatLon(1.0000,1.0000,1+ 0.000009*0.7066275,1+ 0.000009*0.7066275);

alert("distance : " + distance);
</script>
</head>

<body>
	<header>
		<h1>W<span class="tiny_font">izard </span>O<span class="tiny_font">f &nbsp;</span> S<span class="tiny_font">hout</span></h1>
	</header>
	
	<div>
		<br>
		<form>
		<table>
			<tr>
				<td colspan="2">검색조건</td>
			</tr>
			<tr>
				<td>거리</td>
				<td><input type="number" name="distance" placeholder="거리" min="10" max="3000" step="10">m</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="조회"></td>
			</tr>
		</table>
		</form>		
	</div>
</body>
</html>

