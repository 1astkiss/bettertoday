package mysns.sns;

public class Message {

	// 게시글 id
	private int mid;
	
	// 작성자 id
	private String uid;
	
	// 게시문 내용
	private String msg;
	
	// 게시일, 시간
	private String date;
	
	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getFavcount() {
		return favcount;
	}

	public void setFavcount(int favcount) {
		this.favcount = favcount;
	}

	public int getReplycount() {
		return replycount;
	}

	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}

	// 좋아요 횟수
	private int favcount;
	
	// 댓글 수
	private int replycount;
	
}
