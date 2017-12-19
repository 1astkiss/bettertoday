package shout.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import shout.util.DBManager;

public class MemberLocationDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Member result = new Member();
	double METER_GEO_RATIO = 0.000009;
	double SUM_DIFF_LIMIT = 0.7066275 * 2;
	
	Logger log = LoggerFactory.getLogger(MemberLocationDAO.class);
	
	public boolean addLocation(MemberLocation location) {
		
		conn = DBManager.getConnection();
		String sql = "insert into shout_member_location(member_id, time, latitude, longitude) "
				+ "values(?,now(),?,?)";
		String sql2 = "delete from shout_member_location_recent where member_id=?";
		String sql3 = "insert into shout_member_location_recent(member_id, time, latitude, longitude) "
				+ "values(?,now(),?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  location.getMember_id());
			pstmt.setDouble(2, location.getLatitude());
			pstmt.setDouble(3,  location.getLongitude());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1,  location.getMember_id());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1,  location.getMember_id());
			pstmt.setDouble(2, location.getLatitude());
			pstmt.setDouble(3,  location.getLongitude());
			pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			log.info("Error Code : {}", e.getErrorCode());
			return false;
		}finally {
			try {
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		log.info("member : {} location registered", location.getMember_id());

		return true;
	}
	
	public LinkedList<MemberLocation> getTarget(String member_id, int distance) {
		
		LinkedList<MemberLocation> target_list = new LinkedList<>();
		conn = DBManager.getConnection();
		String sql1 = "select latitude, longitude from shout_member_location "
						+ "where member_id=? "
						+ "order by time desc limit 0,1";
		
		String sql = "SELECT member_id, time, latitude, longitude "
				+ "FROM "
					+ "shout_member_location_recent recent "
				+ "where "
					+ "abs(recent.latitude - ?) < ? " 
					+ "and abs(recent.longitude - ?) < ? "
					+ "and member_id <> ? "; 
		
		try {
			
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			double shouterLat = 0;
			double shouterLon = 0;
			
			while(rs.next()) {
				MemberLocation target = new MemberLocation(); 
				shouterLat = rs.getDouble("latitude");
				shouterLon = rs.getDouble("longitude");
				target.setMember_id(member_id);
				target.setLatitude(shouterLat);
				target.setLongitude(shouterLon);
				target_list.add(target);
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, shouterLat);
			pstmt.setDouble(2, distance * METER_GEO_RATIO);
			pstmt.setDouble(3, shouterLon);
			pstmt.setDouble(4, distance * METER_GEO_RATIO);
			pstmt.setString(5, member_id);
			System.out.println("pstmt at MLDAO " + pstmt);
			rs = pstmt.executeQuery();
			
			double sumDiff;
			
			while(rs.next()) {
				MemberLocation target = new MemberLocation(); 
				target.setMember_id(rs.getString("member_id"));
				System.out.println("target.getMember_id():" + target.getMember_id());
				target.setLatitude(rs.getDouble("latitude"));
				target.setLongitude(rs.getDouble("longitude"));
				
				/*sumDiff = Math.abs(target.getLatitude() - shouterLat)
							+ Math.abs(target.getLongitude() - shouterLon);
				
				if(sumDiff < (1.41 * distance * METER_GEO_RATIO)) {*/
					target_list.add(target);
				//}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			log.info("Error Code : {}", e.getErrorCode());
		}finally {
			try {
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		for(int i = 0; i < target_list.size(); i++) {
			System.out.println("target_list.get(" + i + ").getMember_id() : " + target_list.get(i).getMember_id());
		}
		return target_list;
	}
}
