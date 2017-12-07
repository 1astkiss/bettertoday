package shout.member;

import shout.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MemberDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Member result = new Member();
	
	Logger log = LoggerFactory.getLogger(MemberDAO.class);
	
	/** 
	 * 신규회원등록
	 * @param member
	 * @return
	 */
	public boolean addMember(Member member) {
		
		conn = DBManager.getConnection();
		String sql = "insert into shout_member(member_id, password, member_type, birth_year, sex, mobile, email, date_created) "
				+ "values(?,?,?,?,?,?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  member.getMember_id());
			pstmt.setString(2, member.getPassword());
			pstmt.setInt(3,  member.getMember_type());
			pstmt.setInt(4, member.getBirth_year());
			pstmt.setString(5, member.getSex());
			pstmt.setString(6, member.getMobile());
			pstmt.setString(7, member.getEmail());
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
		
		log.info("member : {} created", member.getMember_id());

		return true;
	}
	
	/**
	 * 회원 로그인
	 * @param member_id
	 * @param passwd
	 * @return
	 */
	public Member login(String member_id) {
		
		conn = DBManager.getConnection();
		
		String sql;
		
		try {
			//회원 기본 정보 가져오기
			sql = "select member_id, password, member_type from shout_member where member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
				result.setMember_id(member_id);
				result.setPassword(rs.getString("password"));
				result.setMember_type(rs.getInt("member_type"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		log.info("member_id : {} logged in", member_id);

		return result;
	}
	
	
	/** 
	 * 회원정보 변경
	 * @param member
	 * @return
	 *//*
	public boolean modifyMember(Member member) {
		
		conn = DBManager.getConnection();
		String sql = "update words_member "
				+ "set passwd=?, nickname=?, email=?, birth_year=? "
				+ "where member_id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getNickname());
			pstmt.setString(3, member.getEmail());
			pstmt.setInt(4, member.getBirth_year());
			pstmt.setString(5, member.getMember_id());
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
		
		return true;
	}
	
	
	
	*//**
	 * 과거 문제풀이 이력에 따른 실시간 회원 레벨 산정
	 * @param member_id
	 * @return
	 *//*
	public int chkMemberLevel(String member_id) {
		
		double avgFinal = chkMemberAverage(member_id);

		int member_level = 0;
		
		if(avgFinal < 20) member_level = 1;
		else if(avgFinal < 30) member_level = 2;
		else if(avgFinal < 40) member_level = 3;
		else if(avgFinal < 50) member_level = 4;
		else if(avgFinal < 60) member_level = 5;
		else if(avgFinal < 70) member_level = 6;
		else if(avgFinal < 80) member_level = 7;
		else if(avgFinal < 90) member_level = 8;
		else member_level = 9;
		
		return member_level;
	}
	
	*//**
	 * 과거 문제풀이 이력에 따른 실시간 회원 레벨 산정
	 * @param member_id
	 * @return
	 *//*
	public int chkMemberLevel(double avgFinal) {
		
		int member_level = 0;
				
		if(avgFinal < 20) member_level = 1;
		else if(avgFinal < 30) member_level = 2;
		else if(avgFinal < 40) member_level = 3;
		else if(avgFinal < 50) member_level = 4;
		else if(avgFinal < 60) member_level = 5;
		else if(avgFinal < 70) member_level = 6;
		else if(avgFinal < 80) member_level = 7;
		else if(avgFinal < 90) member_level = 8;
		else member_level = 9;
			
		return member_level;
	}
	
	*//**
	 * 과거 문제풀이 이력에 따른 실시간 회원 평점 산정
	 * @param member_id
	 * @return
	 *//*
	public double chkMemberAverage(String member_id) {
		
		conn = DBManager.getConnection();
		String sql;
		double avgFinal = 0;
		
		try {
			sql = "select avg_30, avg_31_to_60, avg_61_to_90, avg_91_plus from words_member_with_score where member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				double[] avgArray = {rs.getDouble("avg_30"), rs.getDouble("avg_31_to_60") * 0.9, rs.getDouble("avg_61_to_90") * 0.8, rs.getDouble("avg_91_plus")* 0.7};
				double avgTotal = 0;
				int avgCount = 0;
				for(int i = 0; i < avgArray.length; i++) {
					if(avgArray[i] != 0) {
						avgTotal += avgArray[i];
						avgCount++;
					}
				}
				
				//avgCount가 0일 경우 0으로 나누게 되는 문제 해결
				if (avgCount != 0) {
					avgFinal = avgTotal / avgCount;
				}
				
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return avgFinal;
	}
	
	*//**
	 * 신규 산정된 회원레벨을 회원 DB에 update
	 * @param member_id
	 * @param member_level
	 * @return
	 *//*
	public boolean setMemberLevel(String member_id, int member_level) {
		
		conn = DBManager.getConnection();
		String sql;
		int rows_updated = 0;
		
		try {
			sql = "UPDATE words_member set member_level = ? where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_level);
			pstmt.setString(2, member_id);
			rows_updated = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		if (rows_updated == 0) {
			return false;
		}else {
			return true;
		}
	}*/
}
	
	