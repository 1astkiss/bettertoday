package words.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import words.util.DBManager;

public class MemberDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Member result = new Member();
	
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	/** 
	 * 신규회원등록
	 * @param member
	 * @return
	 */
	public boolean addMember(Member member) {
		
		conn = DBManager.getConnection();
		String sql = "insert into words_member(member_id, passwd, nickname, email, date_created, birth_year) "
				+ "values(?,?,?,?,now(),?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  member.getMember_id());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3,  member.getNickname());
			pstmt.setString(4, member.getEmail());
			pstmt.setInt(5, member.getBirth_year());
			pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}", e.getErrorCode());
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
	
	
	/**
	 * 회원 로그인
	 * @param member_id
	 * @param passwd
	 * @return
	 */
	public Member login(String member_id) {
		
		conn = DBManager.getConnection();
		
		String sql;
		System.out.println("member_id : " + member_id);
		
		try {
			//회원 기본 정보 가져오기
			sql = "select member_id, passwd, can_make_question, member_level from words_member where member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			rs.next();
			
			result.setMember_id(member_id);
			result.setPasswd(rs.getString("passwd"));
			result.setCan_make_question(rs.getInt("can_make_question"));
			//문제풀이 이력이 없는 가입자의 경우 기본 레벨 세팅
			result.setMember_level(rs.getInt("member_level"));
			
			//문제풀이 이력이 있는 가입자의 경우 이력에 따른 레벨 세팅
			sql = "select avg_30, avg_31_to_60, avg_61_to_90, avg_91_plus from words_member_with_score where member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs != null) {
				rs.next();
				
				double[] avgArray = {rs.getDouble("avg_30"), rs.getDouble("avg_31_to_60") * 0.9, rs.getDouble("avg_61_to_90") * 0.8, rs.getDouble("avg_91_plus")* 0.7};
				double avgTotal = 0;
				int avgCount = 0;
				for(int i = 0; i < avgArray.length; i++) {
					if(avgArray[i] != 0) {
						avgTotal += avgArray[i];
						avgCount++;
					}
				}
				
				double avgFinal = avgTotal / avgCount;
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
				
				result.setMember_level(member_level);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}
	
	