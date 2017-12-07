<%@ tag pageEncoding="UTF-8" body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- 회원이 로그인한 상태인 경우 -->
<c:choose>

	<c:when test="${member_id != null }">
		<script src="http://maps.google.com/maps/api/js?sensor=false&key=AIzaSyBX0GLjYUXfqeDsp43_rxuBfTyBcdi7qTI"></script>
		<script>
		$(function(){
			
			var element = document.getElementById('map');
			var map = new google.maps.Map(element, {
				zoom: 20,
				center: new google.maps.LatLng(37.501773, 127.025318),
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
			
			var lat, lon;
			
			navigator.geolocation.watchPosition(function(position){
				lat = position.coords.latitude;
				lon = position.coords.longitude;
				var marker = new google.maps.Marker({
					position: new google.maps.LatLng(lat, lon),
					map: map
				});
				
				new google.maps.Marker({
					position: new google.maps.LatLng(lat+0.000100, lon),
					map: map
				});
				
				map.setCenter(marker.getPosition());
				map.setZoom(18);
				//alert(position.coords.accuracy + ':' + position.coords.speed);
				$('#lat').val(lat);
				$('#lon').val(lon);
			});
			
			
			/* setInterval(function(){
				if(lon != null){
					$('#location_btn').click();
				}
			}, 3000); */
			
		});
		</script>
			
		<form name="member_location" method="post" action="member_control.jsp">
		<table>
			<tr>
				<td>Latitude</td>
				<td><input id="lat" type="text" name="latitude" value=""> </td>
			</tr>
			<tr>
				<td>Longitude</td>
				<td><input id="lon" type="text" name="longitude" value=""> </td>
			</tr>
			<tr>
				<td colspan='2'>
					<input type="hidden" name="action" value="new_location"> 
					<input id="location_btn" type="submit" value="AddToDB" >
				</td>
			</tr>
		</table>
		</form>
		
		<div id="map"></div>
		</c:when>
	
	<c:otherwise>
		<hr>
	
		<!-- Welcome message 출력 -->
		<h2 style="text-align: center">Lets shout!!!</h2>
		<hr>
		<p class="info">회원가입후 로그인하세요</p>
	</c:otherwise>
</c:choose>
