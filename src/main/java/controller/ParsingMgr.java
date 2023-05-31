package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import store.DBConnectionMgr;

public class ParsingMgr {	
	private DBConnectionMgr pool;
	public ParsingMgr() {
		pool = DBConnectionMgr.getInstance();		
	}	
	// 박스오피스 데이터 넣기
	public void insertBoxOffice() throws Exception {
		
		Parsing parsing = new Parsing();
		String[] officeList = parsing.getMovieData(); //박스오피스 영화 목록
		for(int i = 0; i < officeList.length; i++) {
			String movieData[] = parsing.getMovie(officeList[i].split("/")[0]);
			Connection con = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt2 = null;
			String sql = null;
			if(!duplicateCheck(officeList[i].split("/")[0])) {//중복체크
				try {
					con = pool.getConnection();
					sql = "insert movieinfo(name, director, actor, genre, intro, opendt, enddt, photo, runtime, trailer, agelimit, vote)"
							+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt = con.prepareStatement(sql);
					for(int k = 0; k < movieData.length; k++) {
						pstmt.setString(k+1, movieData[k]);		
					}
					pstmt.executeUpdate();
					System.out.println("[ 새로운 추가 ] " + movieData[0]);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);					
				}
			}
			try {
				con = pool.getConnection();
				sql = "update officeinfo set name=?,director=?,actor=?,genre=?,intro=?,opendt=?,enddt=?,photo=?,runtime=?,trailer=?,agelimit=?,vote=?,audiAcc=? where idx=?";
				pstmt2 = con.prepareStatement(sql);
				for(int k = 0; k < movieData.length; k++) {
					pstmt2.setString(k+1, movieData[k]);		
				}
				pstmt2.setString(13, officeList[i].split("/")[1]);
				pstmt2.setInt(14, i+1);
				pstmt2.executeUpdate();			
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt2);					
			}
			
		}
	}

	public boolean duplicateCheck(String movieName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select name from movieinfo where name = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieName);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
		
	}
	
	// 인기 영화 입력
	public void insertMovie() throws Exception {
		
		Parsing parsing = new Parsing();
		String[][] movieData = parsing.popularMovieList();

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert movieinfo(name, director, actor, genre, intro, opendt, enddt, photo, runtime, trailer, agelimit, vote)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i < movieData.length; i++) {
				for(int j = 0; j < 12; j++) {
					pstmt.setString(j+1, movieData[i][j]);					
				}				
				pstmt.executeUpdate();	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public static void main(String[] args) throws Exception {
		ParsingMgr mgr = new ParsingMgr();
		mgr.insertBoxOffice();
	}
	
}
