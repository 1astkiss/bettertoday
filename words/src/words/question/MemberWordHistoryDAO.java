package words.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import words.member.MemberDAO;
import words.util.DBManager;

public class MemberWordHistoryDAO {

	Connection conn;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);

	/**
	 * 신규 문제 등록
	 * 
	 * @param msg
	 * @return
	 */
	public boolean addMemberWordHistory(ArrayList<MemberWordHistory> history) {

		conn = DBManager.getConnection();
		String sql = "insert into member_word_history(member_id, member_level, question_id, date_created, count_tried)"
				+ " values(?,?,?,now(),?)";

		try {
			for(MemberWordHistory mwh : history ) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mwh.getMember_id());
				pstmt.setInt(2, mwh.getMember_level());
				pstmt.setInt(3, mwh.getQuestion_id());
				pstmt.setInt(4, mwh.getCount_tried());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		} finally {
			try {
				// 자원 정리
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return true;
	}

}
