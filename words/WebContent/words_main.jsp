<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="words"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My words</title>
<link rel="stylesheet" href="css/styles.css" type="text/css"
	media="screen" />

<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
</script>
<style>

</style>

<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
	<header>
			<h1>My Simple Words</h1>
	</header>

	<nav>
		<div class="menu">
			<ul>
				<li><a href="#">Home &nbsp;&nbsp;</a></li>
				<words:login />
			</ul>
		</div>
	</nav>
	<div align="center">
	<br>
		<hr>
		<words:quiz />
		<hr>
	</div>

	