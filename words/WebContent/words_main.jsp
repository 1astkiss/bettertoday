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
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	$(function() {
		$("#accordion").accordion({
			heightStyle : "content",
		});
	});

	function newuser() {
		window
				.open(
						"new_user.jsp",
						"newuser",
						"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=400,height=240");
	}
</script>

<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
	<header>
		<div class="container1">
			<h1 class="fontface" id="title">My Simple words</h1>
		</div>
	</header>

	<nav>
		<div class="menu">
			<ul>
				<li><a href="#">Home</a></li>
				<!-- 				<li><a href="javascript:newuser()">New User</a></li> -->
				<li><a href="new_user.jsp">New User</a></li>
				<li><words:login /></li>
			</ul>
		</div>
	</nav>
	<div align="center">
		<hr>
		<h2 style="text-align: center">다음 문제에 5초내에 답하세요</h2>
		<br>
		<table>
			<tr>
				<td colspan="2"><h2>delay</h2></td>
			</tr>
			<tr>
				<td><a href="#">.1.</a>
				<td>
				<td>지연하다</td>
			</tr>
			<tr>
				<td><a href="#">.2.</a>
				<td>
				<td>빨리가다</td>
			</tr>
			<tr>
				<td><a href="#">.3.</a>
				<td>
				<td>돌아서다</td>
			</tr>
			<tr>
				<td><a href="#">.4.</a>
				<td>
				<td>당연하다</td>
			</tr>
		</table>

		<a href="words_control.jsp?action=getall&cnt=${cnt+5 }&suid=${suid }">더보기&gt;&gt;</a>
	</div>
	</section>

	<aside id="sidebar2">
		<!-- sidebar2 -->
		<h2>새로운 친구들.!!</h2>
		<ul>
			<c:forEach var="n" items="${nusers }">
				<li><a href="words_control.jsp?action=getall&suid=${n}">${n}</a></li>
			</c:forEach>
		</ul>

		<br> <br>
		<h3>We're Social Too!!</h3>
		<img src="img/facebook_32.png"> <img src="img/twitter_32.png">
		<img src="img/youtube_32.png"> <br> <br> <br> <br>

		<h3>Links</h3>
		<ul>
			<li><a href="#">한빛미디어</a></li>
			<li><a href="#">가천대학교</a></li>
			<li><a href="#">가천대학교 길병원</a></li>
		</ul>

	</aside>
	<!-- end of sidebar -->
	</section>
	</div>

	<footer>
		<div class="container1">
			<section id="footer-area">

				<section id="footer-outer-block">
					<aside class="footer-segment">
						<h4>About</h4>
						<ul>
							<li><a href="#">About My Simple words</a></li>
							<li><a href="#">Copyright</a></li>
							<li><a href="#">Author</a></li>
						</ul>
					</aside>
					<!-- end of #first footer segment -->

					<aside class="footer-segment">
						<h4>Java Web Programming</h4>
						<ul>
							<li><a href="#">Book Information</a></li>
							<li><a href="#">Table of contents</a></li>
							<li><a href="#">Book History</a></li>
						</ul>
					</aside>
					<!-- end of #second footer segment -->

					<aside class="footer-segment">
						<h4>Contact Us</h4>
						<ul>
							<li><a href="#">Book Support</a></li>
							<li><a href="#">Publication</a></li>
							<li><a href="#">Investor Relations</a></li>
						</ul>
					</aside>
					<!-- end of #third footer segment -->

					<aside class="footer-segment">
						<h4>Hee Joung Hwang</h4>
						<p>
							&copy; 2014 <a href="#">dinfree.com</a>
						</p>
					</aside>
					<!-- end of #fourth footer segment -->

				</section>
				<!-- end of footer-outer-block -->

			</section>
			<!-- end of footer-area -->
		</div>
	</footer>
</body>
</html>