package words.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

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
	 * @param question
	 * @return
	 */
	public boolean newQuestion(Question question) {

		conn = DBManager.getConnection();
		String sql = "insert into questions(date_created, creator_id, word, selection1, selection2, selection3, selection4, answer)"
				+ " values(now(),?,?,?,?,?,?,?)";

		try {
			// query문 작성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, question.getCreator_id());
			pstmt.setString(2, question.getWord());
			pstmt.setString(3, question.getSelection1());
			pstmt.setString(4, question.getSelection2());
			pstmt.setString(5, question.getSelection3());
			pstmt.setString(6, question.getSelection4());
			pstmt.setInt(7, question.getAnswer());
			
			// 문제등록
			pstmt.executeUpdate();
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

	/**
	 * 매개변수로 넘겨받은 회원아이디를 바탕으로 회원별 맞춤 문제를 선정하여 return
	 * @param member_id
	 * @return
	 */
	public LinkedList<Question> getQuestion(String member_id) {
		conn = DBManager.getConnection();
		String sql;
		LinkedList<Question> questions = new LinkedList<Question>();

		try {
			sql = "select word, selection1, selection2, selection3, selection4, answer, weight, question_id from questions order by date_created desc limit 0,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 10);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			ResultSet rs = pstmt.executeQuery();

			// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
			while (rs.next()) {
				Question question = new Question();
				
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getInt("weight"));
				question.setQuestion_id(rs.getInt("question_id"));
				
				// Question객체를 LinkedList에 추가
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

		// LinkedList 객체를 return
		return questions;
	}

}
