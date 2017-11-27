package words.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import words.member.MemberDAO;
import words.util.DBManager;

public class QuestionsDAO {

	Connection conn;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs = null;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	int SameLevelQuestions = 20;
	int OneLevelUpQuestions = 15;
	int TwoLevelUpQuestions = 10;
	int TotalQuestionsByLevel = SameLevelQuestions + OneLevelUpQuestions+TwoLevelUpQuestions;
	int MIN_WEIGHT = 0;
	int MAX_WEIGHT = 100;
	int NUM_OF_WRONG = 5;
	int NUM_OF_QUESTIONS = 10;

	
	/**
	 * 매개변수로 넘겨받은 회원아이디를 바탕으로 회원별 맞춤 문제를 선정하여 return
	 * @param member_id
	 * @return
	 */
	public LinkedList<Question> getQuestion(String member_id, int member_level) {
		conn = DBManager.getConnection();
		String sql;
		LinkedList<Question> tmp_questions = new LinkedList<Question>();
		LinkedList<Question> questions = new LinkedList<Question>();
		try {
			sql = "SELECT word, selection1, selection2, selection3, selection4, answer, weight, question_id "
					+ "FROM questions_with_weight "
					+ "WHERE weight >= ? AND weight < ? "
					+ "ORDER BY rand() limit 0,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_level * 10);
			pstmt.setInt(2, (member_level + 1) * 10);
			pstmt.setInt(3, SameLevelQuestions);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			rs = pstmt.executeQuery();

			// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
			while (rs.next()) {
				Question question = new Question();
				
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getDouble("weight"));
				question.setQuestion_id(rs.getInt("question_id"));
				
				// Question객체를 LinkedList에 추가
				tmp_questions.add(question);
			}
			
			sql = "SELECT word, selection1, selection2, selection3, selection4, answer, weight, question_id "
					+ "FROM questions_with_weight "
					+ "WHERE weight >= ? AND weight < ? "
					+ "ORDER BY rand() limit 0,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (member_level + 1) * 10);
			pstmt.setInt(2, (member_level + 2) * 10);
			pstmt.setInt(3, OneLevelUpQuestions);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			rs = pstmt.executeQuery();

			// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
			while (rs.next()) {
				Question question = new Question();
				
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getDouble("weight"));
				question.setQuestion_id(rs.getInt("question_id"));
				
				// Question객체를 LinkedList에 추가
				tmp_questions.add(question);
			}
			
			sql = "SELECT word, selection1, selection2, selection3, selection4, answer, weight, question_id "
					+ "FROM questions_with_weight "
					+ "WHERE weight >= ? AND weight < ? "
					+ "ORDER BY rand() limit 0,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (member_level + 2) * 10);
			pstmt.setInt(2, (member_level + 3) * 10);
			pstmt.setInt(3, TwoLevelUpQuestions);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			rs = pstmt.executeQuery();

			// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
			while (rs.next()) {
				Question question = new Question();
				
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getDouble("weight"));
				question.setQuestion_id(rs.getInt("question_id"));
				
				// Question객체를 LinkedList에 추가
				tmp_questions.add(question);
			}
			
			if(tmp_questions.size() < TotalQuestionsByLevel) {
				sql = "SELECT word, selection1, selection2, selection3, selection4, answer, weight, question_id "
						+ "FROM questions_with_weight "
						+ "WHERE weight >= ? AND weight < ? "
						+ "ORDER BY rand() limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, MIN_WEIGHT);
				pstmt.setInt(2, MAX_WEIGHT);
				pstmt.setInt(3, TotalQuestionsByLevel - tmp_questions.size());
				System.out.println("pstmt at QuestionsDao : " + pstmt);
				rs = pstmt.executeQuery();

				// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
				while (rs.next()) {
					Question question = new Question();
					
					question.setWord(rs.getString("word"));
					question.setSelection1(rs.getString("selection1"));
					question.setSelection2(rs.getString("selection2"));
					question.setSelection3(rs.getString("selection3"));
					question.setSelection4(rs.getString("selection4"));
					question.setAnswer(rs.getInt("answer"));
					question.setWeight(rs.getDouble("weight"));
					question.setQuestion_id(rs.getInt("question_id"));
					
					// Question객체를 LinkedList에 추가
					tmp_questions.add(question);
				}
			}
			
			sql = "SELECT " + 
					"        `mwh`.`question_id` AS `question_id`," + 
					"        `q`.`word` AS `word`,\n" + 
					"        `q`.`selection1` AS `selection1`," + 
					"        `q`.`selection2` AS `selection2`," + 
					"        `q`.`selection3` AS `selection3`," + 
					"        `q`.`selection4` AS `selection4`," + 
					"        `q`.`answer` AS `answer`," + 
					"        `q`.`weight` AS `weight`" + 
					"    FROM " + 
					"        (`member_word_history` `mwh` " + 
					"        JOIN `questions_with_weight` `q` ON ((`mwh`.`question_id` = `q`.`question_id`))) " + 
					"    WHERE " + 
					"        (`mwh`.`count_tried` > 1) "
					+ "AND `mwh`.`member_id` = ?"
					+ "ORDER BY rand() limit 0,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member_id);
			pstmt.setInt(2, NUM_OF_WRONG * 3);
			System.out.println("pstmt at QuestionsDao : " + pstmt);
			rs = pstmt.executeQuery();

			// 위에서 조회한 문제별로 Question object를 생성하여 LinkedList에 추가
			while (rs.next()) {
				Question question = new Question();
				
				question.setWord(rs.getString("word"));
				question.setSelection1(rs.getString("selection1"));
				question.setSelection2(rs.getString("selection2"));
				question.setSelection3(rs.getString("selection3"));
				question.setSelection4(rs.getString("selection4"));
				question.setAnswer(rs.getInt("answer"));
				question.setWeight(rs.getDouble("weight"));
				question.setQuestion_id(rs.getInt("question_id"));
				
				// Question객체를 LinkedList에 추가
				tmp_questions.add(question);
			}
			
			Random rand = new Random();
			int randomInt = 0;
			
			while(tmp_questions.size() > NUM_OF_QUESTIONS) {
				
				randomInt = rand.nextInt(tmp_questions.size()) + 1;
				tmp_questions.remove(randomInt);
				
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

}

