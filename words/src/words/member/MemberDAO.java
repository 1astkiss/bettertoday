package words.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import words.util.DBManager;

public class MemberDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
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
	 * @param uid
	 * @param passwd
	 * @return
	 */
	public boolean login(String member_id, String passwd) {
		
		conn = DBManager.getConnection();
		String sql = "select member_id, passwd from words_member where member_id=?";
		boolean result = false;
		System.out.println("member_id : " + member_id);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			System.out.println("pstmt : " + pstmt);
			System.out.println("Is rs null? : " + rs=="");
			rs = pstmt.executeQuery();
			System.out.println("Is rs null? : " + rs=="");
			rs.next();
			
			if(rs.getString("passwd").equals(passwd)) {
				result = true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
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
	
	