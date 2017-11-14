package mysns.sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mysns.member.MemberDAO;
import mysns.util.DBManager;

public class MessageDAO {

	Connection conn;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);

	/**
	 * 메시지 조회
	 * 
	 * @param cnt
	 * @param suid
	 * @return
	 */
	public ArrayList<MessageSet> getAll(int cnt, String suid) {
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();
		conn = DBManager.getConnection();
		String sql;

		try {
			// 전체 게시물 조회
			if ((suid == null) || (suid.equals(""))) {
				sql = "select * from s_message order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnt);
			} else { // 특정 회원 게시물 조회
				sql = "select * from s_message where uid=? order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, suid);
				pstmt.setInt(2, cnt);
			}

			ResultSet rs = pstmt.executeQuery();

			// 위에서 조회한 메시지 별로 MessageSet object를 생성하여 datas에 추가
			while (rs.next()) {
				MessageSet ms = new MessageSet();
				Message m = new Message();
				ArrayList<Reply> rlist = new ArrayList<Reply>();

				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getDate("date") + " / " + rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setUid(rs.getString("uid"));

				// 메시지의 답글 조회
				String rsql = "select * from s_reply where mid=? order by date desc";
				pstmt = conn.prepareStatement(rsql);
				pstmt.setInt(1, rs.getInt("mid"));
				ResultSet rrs = pstmt.executeQuery();

				// 답글별 Reply object를 생성하여 rlist에 추가
				while (rrs.next()) {
					Reply r = new Reply();
					r.setRid(rrs.getInt("rid"));
					r.setUid(rrs.getString("uid"));
					r.setRmsg(rrs.getDate("date") + " / " + rrs.getTime("date"));
					rlist.add(r);
				}

				// rrs의 갯수를 구하기 위해 마지막 row로 커서를 옮김
				// DB query를 통해 갯수를 구할 수도 있으나 DB에 부하를 주게 되므로 지양
				rrs.last();

				// Message object의 댓글수 설정
				m.setReplycount(rrs.getRow());

				// MessageSet object에 Message object 설정
				ms.setMessage(m);

				// MessageSet object에 댓글 목록 설정
				ms.setRlist(rlist);

				// MessageSet Array에 추가
				datas.add(ms);

				rrs.close();
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
				
				if(pstmt != null) {
					pstmt.close();
				}
				
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}

		return datas;
	}

	/**
	 * 신규 메시지 등록
	 * 
	 * @param msg
	 * @return
	 */
	public boolean newMsg(Message msg) {

		conn = DBManager.getConnection();
		String sql = "insert into s_message(uid, msg, date) values(?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getUid());
			pstmt.setString(2, msg.getMsg());
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
	 * 메시지 삭제
	 * 
	 * @param mid
	 * @return
	 */
	public boolean delMsg(int mid) {

		conn = DBManager.getConnection();
		String sql = "delete from s_message where mid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return true;
	}

	/**
	 * 새로운 답글 등록
	 * 
	 * @param reply
	 * @return
	 */
	public boolean newReply(Reply reply) {

		conn = DBManager.getConnection();
		String sql = "insert into s_reply(mid, uid, rmsg, date) values(?,?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply.getMid());
			pstmt.setString(2, reply.getUid());
			pstmt.setString(3, reply.getRmsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return true;
	}

	/**
	 * 답글 삭제
	 * 
	 * @param rid
	 * @return
	 */
	public boolean delReply(int rid) {
		conn = DBManager.getConnection();
		String sql = "delete from s_reply where rid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return true;
	}

	/**
	 * 좋아요 카운트 증가
	 * 
	 * @param mid
	 */
	public void favorite(int mid) {

		conn = DBManager.getConnection();

		// 좋아요 카운트 증가
		String sql = "update s_message set favcount=favcount+1 where mid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
