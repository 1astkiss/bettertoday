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

public class QuestionsDAO {

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
	public boolean newQuestion(Question question) {

		conn = DBManager.getConnection();
		String sql = "insert into questions(date_created, creator_id, word, selection1, selection2, selection3, selection4, answer)"
				+ " values(now(),?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, question.getCreator_id());
			pstmt.setString(2, question.getWord());
			pstmt.setString(3, question.getSelection1());
			pstmt.setString(4, question.getSelection2());
			pstmt.setString(5, question.getSelection3());
			pstmt.setString(6, question.getSelection4());
			pstmt.setInt(7, question.getAnswer());
			pstmt.executeUpdate();
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

	/**
	 * 메시지 조회
	 * 
	 * @param cnt
	 * @param suid
	 * @return
	 */
	public ArrayList<Question> getQuestion(String member_id) {
		conn = DBManager.getConnection();
		String sql;
		Question question = new Question();
		ArrayList<Question> questions = new ArrayList<Question>();

		try {
			sql = "select word, selection1, selection2, selection3, selection4, answer, weight from questions order by date_created desc limit 0,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 10);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			ResultSet rs = pstmt.executeQuery();

			// 위에서 조회한 메시지 별로 MessageSet object를 생성하여 datas에 추가
			while (rs.next()) {
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getInt("weight"));
				questions.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		} finally {
			try {
				// 자원 정리
				if (rs != null) {
					rs.close();
				}

				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}

		return questions;
	}

	/**
	 * 메시지 삭제
	 * 
	 * @param mid
	 * @return
	 *//*
		 * public boolean delMsg(int mid) {
		 * 
		 * conn = DBManager.getConnection(); String sql =
		 * "delete from s_message where mid=?";
		 * 
		 * try { pstmt = conn.prepareStatement(sql); pstmt.setInt(1, mid);
		 * pstmt.executeUpdate(); } catch (SQLException e) { e.printStackTrace();
		 * System.out.println(e.getErrorCode()); return false; } finally { try {
		 * pstmt.close(); conn.close(); } catch (SQLException e) { e.printStackTrace();
		 * } }
		 * 
		 * return true; }
		 */

}
