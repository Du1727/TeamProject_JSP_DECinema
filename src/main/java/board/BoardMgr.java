package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class BoardMgr {

	static DBConnectionMgr pool;	
	public static final String SAVEFOLDER = "C:/Jsp/jsp_teamproject/src/main/webapp/assets/img/store/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;
	
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 문의게시글 등록
	public boolean insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않는다면*/)
				dir.mkdirs();	// 상위폴더가 없어도 생성가능
				// mkdir : 상위폴더가 없으면 생성불가
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING
							,new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			if(multi.getFilesystemName("filename") != null){
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");
			
			
			con = pool.getConnection();
			sql = "INSERT INTO board (id, `subject`, content, secret, regdt,    `count`, filename, filesize) "
					+ "values(?,?,?,?,?,     ?,?,?)";
			pstmt = con.prepareStatement(sql);
			System.out.println(" id : " + multi.getParameter("idKey"));
			System.out.println(" subject : " + multi.getParameter("subject"));
			System.out.println(" content : " + multi.getParameter("content"));
			System.out.println(" filename : " + filename);
			System.out.println(" filesize : " + filesize);
			pstmt.setString(1, multi.getParameter("idKey"));
			pstmt.setString(2, multi.getParameter("subject"));
			pstmt.setString(3, multi.getParameter("content"));
			

			//비밀글을 체크 null -> 0 변환처리
			if(multi.getParameter("secret")==null) { pstmt.setString(4, "0"); }
			else { pstmt.setString(4, multi.getParameter("secret"));}
			
			
			//오늘날짜 받아와서, 타입 변환  
			LocalDateTime localtime = LocalDateTime.now();
			DateTimeFormatter time_format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String regDate =  localtime.format(time_format);
			
			pstmt.setString(5, regDate);
			pstmt.setInt(6, 0);
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			if(pstmt.executeUpdate()==1)
				flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	
	// 문의게시글 등록 backup
/*	public boolean insertBord(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO board (id, `subject`, content, secret, regdt,    `count`) "
				+ "values(?,?,?,?,?,     ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getSecret());
			
			//오늘날짜 받아와서, 타입 변환  
			LocalDateTime localtime = LocalDateTime.now();
			DateTimeFormatter time_format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String regDate =  localtime.format(time_format);
			
			pstmt.setString(5, regDate);
			pstmt.setInt(6, 0);
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

*/
	


	
	// Board Total Count : 총 게시물 수 
	public int getBoardTotalCount( String keyField, String keyWord) {
		Connection con1 = null;
		Connection con2 = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String sql = null;
		String keyFieldTrans = null;
		String keyWordTrans = null;
		int totalCount = 0;
		try {
			con1 = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord ==null) {
				// 검색이 아닌 경우
				sql  = "select count(*) from Board";
				pstmt1 = con1.prepareStatement(sql);
			}else{
				if(keyField.equals("name")) {
					con2 = pool.getConnection();
					sql = "SELECT ID FROM member WHERE NAME LIKE ?";
					pstmt2 = con2.prepareStatement(sql);
					pstmt2.setString(1, "%" + keyWord + "%");
					rs2 = pstmt2.executeQuery();

					if(rs2.next()) keyWordTrans = rs2.getString(1);
					else keyWordTrans = keyWord;
					
					keyFieldTrans = "ID";
					
					
				}else if(keyField.equals("subject")) {
					keyFieldTrans = "subject";
					keyWordTrans = keyWord;
				}
				
				
				sql = "select count(*) from Board where " + keyFieldTrans + " like ?";
				pstmt1 = con1.prepareStatement(sql);
				pstmt1.setString(1, "%" + keyWordTrans + "%");
			}
			rs1 = pstmt1.executeQuery();
			if(rs1.next()) totalCount = rs1.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con1, pstmt1, rs1);
//			pool.freeConnection(con2, pstmt2, rs2);
		}
		return totalCount;
	}
	

	
	
	// 문의게시글 목록 조회
	public Vector<BoardBean> getBoardList(String keyField, String keyWord,int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String keyFieldTrans = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord ==null) {
				sql = " SELECT B.IDX, B.SUBJECT, B.CONTENT, M.NAME, B.REGDT, B.COUNT, B.SECRET "
				    + " FROM   BOARD B, member M "
				    + " WHERE  B.ID = M.ID"
					+ " order by idx desc , idx LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				if(keyField.equals("name")) {
					keyFieldTrans = "M.NAME";
				}else if(keyField.equals("subject")) {
					keyFieldTrans = "B.SUBJECT";
				}
				
				sql = " SELECT B.IDX, B.SUBJECT, B.CONTENT, M.NAME, B.REGDT, B.COUNT, B.SECRET "
					    + " FROM   BOARD B, member M "
					    + " WHERE  B.ID = M.ID"
					    + " AND " + keyFieldTrans + " like ? "
						+ " order by idx desc, idx LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setIdx(rs.getInt(1));
				bean.setSubject(rs.getString(2));
				bean.setContent(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setRegdt(rs.getString(5));
				bean.setCount(rs.getInt(6));
				bean.setSecret(rs.getString(7));
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//게시글 조회수 증가 
	public void incBoardViewCount(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE BOARD SET COUNT=COUNT+1 WHERE IDX = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 선택한 게시글 내용 조회
	public BoardBean getOneBoardContent(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
		
			sql = " SELECT IDX, SUBJECT, CONTENT, SECRET, FILENAME, ANSWER FROM board WHERE IDX = ?" ; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				// 조회수 증가
			    incBoardViewCount(idx);
				
				
				bean.setIdx(rs.getInt(1));
				bean.setSubject(rs.getString(2));
				bean.setContent(rs.getString(3));
				bean.setSecret(rs.getString(4));
				bean.setFilename(rs.getString(5));
				bean.setAnswer(rs.getString(6));
				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	

	
	
	//게시글 수정 
	public boolean updateBord(BoardBean bean, int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE BOARD SET `SUBJECT`=?, CONTENT=?, SECRET=?, FILENAME=?, ANSWER=?  WHERE IDX = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSecret());
			pstmt.setString(4, bean.getFilename());
			pstmt.setString(5, bean.getAnswer());
			pstmt.setInt(6, idx);
			
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	
	//게시글 삭제 
	public boolean deleteBord(BoardBean bean, int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM BOARD WHERE IDX = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	//게시글 "첨부파일" 삭제 
	public boolean deleteAttachFile(BoardBean bean, int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE BOARD SET FILENAME = NULL , FILESIZE = 0 WHERE IDX = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// 게시판 작성자 ID확인 
	public String getBoardWriterId(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String boardWriterId = null;
		try {
			con = pool.getConnection();
		
			sql = " SELECT ID FROM board WHERE IDX = ?" ; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) boardWriterId = rs.getString(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return boardWriterId;
	}
	
	// 해당 사용자의 권한 확인
	public String checkAuthority(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String authority = "";
		try {
			con = pool.getConnection();
			sql = "select authority from member where id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				authority = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return authority;
		
	}
	
}