<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.LinkedList" %>
<%@ page import="shout.member.MemberLocation" %>
    
<jsp:useBean id="mldao" class="shout.member.MemberLocationDAO" />
<%!
public static double distance(double lat1, double lat2, double lon1,
        double lon2) {

    final int R = 6371 * 1000; // Radius of the earth in meters

    double latDistance = Math.toRadians(lat2 - lat1);
    double lonDistance = Math.toRadians(lon2 - lon1);
    double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
            + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
            * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double distance = R * c;

    return distance;
}

%>

<%
double a = Math.toRadians(1000);
System.out.format("%f", a);
int distance = Integer.parseInt((String)request.getParameter("distance"));
String member_id = request.getParameter("member_id");

LinkedList<MemberLocation> targets = new LinkedList<>();

targets = mldao.getTarget(member_id, distance);
System.out.println("targets.size() : " + targets.size());
%>
<%
for(int i = 0; i < targets.size(); i++){
	if(distance(targets.get(0).getLatitude(), 
			targets.get(i).getLatitude(), 
			targets.get(0).getLongitude(), 
			targets.get(i).getLongitude()
			) <= distance){
	
%>
<tr>
	<td><%= targets.get(i).getMember_id() %>
	</td>
	<td><%= targets.get(i).getLatitude() %>
	</td>
	<td><%= targets.get(i).getLongitude() %>
	</td>
	<td><%= distance(targets.get(0).getLatitude(), 
			targets.get(i).getLatitude(), 
			targets.get(0).getLongitude(), 
			targets.get(i).getLongitude()) %>
	</td>
</tr>

<%
	}
}
%>