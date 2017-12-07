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
	
	Logger log = LoggerFactory.getLogger(MemberLocationDAO.class);
	
	public boolean addLocation(MemberLocation location) {
		
		conn = DBManager.getConnection();
		String sql = "insert into shout_member_location(member_id, time, latitude, longitude) "
				+ "values(?,now(),?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
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
		
		log.info("member : {} located registered", location.getMember_id());

		return true;
	}
	
	public boolean getTarget(String member_id, int distance) {
		MemberLocation target =new MemberLocation(); 
		LinkedList<MemberLocation> target_list = new LinkedList<>();
		conn = DBManager.getConnection();
		String sql = "SELECT member_id, time, latitude, longitude "
				+ "FROM "
					+ "(select member_id, time, latitude, longitude "
						+ "from bettertoday.shout_member_location_recent "
						+ "group by member_id) recent "
				+"where "
					+ "abs(recent.latitude - (select latitude "
												+ "from bettertoday.shout_member_location "
//												+ "where member_id=? "
												+ "order by time desc limit 0,1)"
						+ ") < ? " 
					+ "and abs(recent.longitude - (select longitude "
													+ "from bettertoday.shout_member_location "
													+ "where member_id='a' "
													+ "order by time desc limit 0,1)) < ?"; 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setDouble(2, distance*0.000009);
			pstmt.setDouble(3,  distance*0.000009);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				target.setMember_id(rs.getString("member_id"));
				target.setLatitude(rs.getDouble("latitude"));
				target.setLongitude(rs.getDouble("longitude"));
				
				if(target.getLatitude)
				// Question객체를 LinkedList에 추가
				target_list.add(target);
			}
			
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
		
		log.info("member : {} located registered", location.getMember_id());
		
		return true;
	}
}
