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
	Connection conn2;
	PreparedStatement pstmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);

	/**
	 * 매개변수로 넘겨 받은 회원별 이력자료를 DB에 저장 
	 * @param history
	 * @return
	 */
	public boolean addMemberWordHistory(ArrayList<MemberWordHistory> history) {

		conn = DBManager.getConnection();
		conn2 = DBManager.getConnection();
		int questionId = 0;
		int memberLevel = 0;
		
		String sql = "insert into member_word_history(member_id, member_level, question_id, date_created, count_tried, weight, score)"
				+ " values(?,?,?,now(),?,?,?)";
		
		
		
		try {
			for(MemberWordHistory mwh : history ) {
				questionId = mwh.getQuestion_id();
				memberLevel = mwh.getMember_level();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mwh.getMember_id());
				pstmt.setInt(2, mwh.getMember_level());
				pstmt.setInt(3, questionId);
				pstmt.setInt(4, mwh.getCount_tried());
				pstmt.setDouble(5, mwh.getWeight());
				pstmt.setDouble(6, mwh.getScore());
				pstmt.executeUpdate();
				
				String sql3 = "insert into question_correct_by_level (question_id, member_level, try_sum, try_1st) "
						+ "values(" + questionId + "," + memberLevel + ","
						+ "(SELECT COUNT(0) FROM member_word_history WHERE question_id=" + questionId + " and member_level=" + memberLevel + "), "
						+ "(SELECT COUNT(0) FROM member_word_history WHERE question_id=" + questionId + " and member_level=" + memberLevel + " and count_tried = 1)) "
						+ "on duplicate key update "
						+ "try_sum = (SELECT COUNT(0) FROM member_word_history WHERE question_id=" + questionId + " and member_level=" + memberLevel + "), "
						+ "try_1st = (SELECT COUNT(0) FROM member_word_history WHERE question_id=" + questionId + " and member_level=" + memberLevel + " and count_tried = 1)";
				
				pstmt = conn.prepareStatement(sql3);
				pstmt.executeUpdate();
				
				String sql2 = "update questions set weight = (100 - ( " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 1)), 50) * 0.292) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 2)), 50) * 0.228) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 3)), 50) * 0.172) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 4)), 50) * 0.124) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 5)), 50) * 0.084) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 6)), 50) * 0.052) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 7)), 50) * 0.028) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 8)), 50) * 0.012) + " + 
						"            (COALESCE((SELECT (try_1st/try_sum)*100 " + 
						"                        FROM question_correct_by_level " + 
						"                        WHERE (question_id = " + questionId + ")" + 
						"                            AND (member_level = 9)), 50) * 0.004) " + 
						"		) " + 
						"	) " + 
						"	where question_id = " + questionId;

				pstmt = conn2.prepareStatement(sql2);
				/*pstmt.setInt(1,  mwh.getQuestion_id());
				pstmt.setInt(2,  mwh.getQuestion_id());
				pstmt.setInt(3,  mwh.getQuestion_id());
				pstmt.setInt(4,  mwh.getQuestion_id());
				pstmt.setInt(5,  mwh.getQuestion_id());
				pstmt.setInt(6,  mwh.getQuestion_id());
				pstmt.setInt(7,  mwh.getQuestion_id());
				pstmt.setInt(8,  mwh.getQuestion_id());
				pstmt.setInt(9,  mwh.getQuestion_id());
				pstmt.setInt(10,  mwh.getQuestion_id());*/
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		} finally {
			try {
				// 자원 정리
				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return true;
	}

}
