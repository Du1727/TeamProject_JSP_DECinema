package movie;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import store.DBConnectionMgr;



public class MovieMgr {
	private DBConnectionMgr pool;
	
	public MovieMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//모든 영화 정보
	public Vector<MovieBean> loadAllMovie(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MovieBean> vlist = new Vector<MovieBean>();
  		try {
			con = pool.getConnection();
			sql = "select * from movieinfo order by opendt desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MovieBean bean = new MovieBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setName(rs.getString("name"));
				bean.setDirector(rs.getString("director"));
				bean.setActor(rs.getString("actor"));
				bean.setGenre(rs.getString("genre"));
				bean.setIntro(rs.getString("intro"));
				bean.setOpendt(rs.getString("opendt"));
				bean.setEnddt(rs.getString("enddt"));
				bean.setPhoto(rs.getString("photo"));
				bean.setRuntime(rs.getString("runtime"));
				bean.setTrailer(rs.getString("trailer"));
				bean.setAgelimit(rs.getString("agelimit"));
				bean.setVote(rs.getString("vote"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	//박스오피스 정보
	public Vector<OfficeBean> loadOfficeMovie(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OfficeBean> vlist = new Vector<OfficeBean>();
  		try {
			con = pool.getConnection();
			sql = "select * from officeinfo";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				OfficeBean bean = new OfficeBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setName(rs.getString("name"));
				bean.setDirector(rs.getString("director"));
				bean.setActor(rs.getString("actor"));
				bean.setGenre(rs.getString("genre"));
				bean.setIntro(rs.getString("intro"));
				bean.setOpendt(rs.getString("opendt"));
				bean.setEnddt(rs.getString("enddt"));
				bean.setPhoto(rs.getString("photo"));
				bean.setRuntime(rs.getString("runtime"));
				bean.setTrailer(rs.getString("trailer"));
				bean.setAgelimit(rs.getString("agelimit"));
				bean.setAudiAcc(rs.getString("audiAcc"));
				bean.setVote(rs.getString("vote"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
}
