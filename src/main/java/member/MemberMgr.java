package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import store.DBConnectionMgr;

public class MemberMgr {
	private DBConnectionMgr pool;
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}	
	
	public boolean loginMember(String id, String pw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from member where id = ? and pw = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
		
	}
	public Vector<MemberBean> getMemberAll(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPw(rs.getString("pw"));
				bean.setName(rs.getString("name"));
				bean.setRegdt(rs.getString("regdt"));
				bean.setBirthday(rs.getString("birthday"));
				if(rs.getInt("gender") == 0) {
					bean.setGender(false);
				} else {
					bean.setGender(true);
				}
				bean.setMail(rs.getString("mail"));
				bean.setGrade(rs.getString("grade"));
				bean.setPhone(rs.getString("phone"));
				bean.setMileage(rs.getInt("mileage"));
				bean.setAuthority(rs.getString("authority"));
				vlist.addElement(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int countMemberId() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				count++;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	public String[] getMemberIdAll() {		
		
	    String[] memberId = new String[countMemberId()]; 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int i = 0;
			while(rs.next()) {
				memberId[i] = rs.getString("id");
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return memberId;
		
	}
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setPw(rs.getString("pw"));
				bean.setName(rs.getString("name"));
				bean.setRegdt(rs.getString("regdt"));
				bean.setBirthday(rs.getString("birthday"));
				if(rs.getInt("gender") == 0) {
					bean.setGender(false);
				} else {
					bean.setGender(true);
				}
				bean.setMail(rs.getString("mail"));
				bean.setGrade(rs.getString("grade"));
				bean.setPhone(rs.getString("phone"));
				bean.setMileage(rs.getInt("mileage"));
				bean.setAuthority(rs.getString("authority"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
		
	}

	// 회원 가입
	public void insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert member(id, pw, name, gender, birthday, mail, grade, phone, mileage, authority)"
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPw());
			pstmt.setString(3, bean.getName());
			if (bean.getGender()) {
				pstmt.setInt(4, 1);	
			} else {
				pstmt.setInt(4, 0);
			}
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getMail());
			pstmt.setString(7, "Bronze");
			pstmt.setString(8, bean.getPhone());
			pstmt.setInt(9, 1000);
			pstmt.setString(10, "user");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
