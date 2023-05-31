package store;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class cartMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = 
			"C:/java/JSP/DEC/src/main/webapp/store";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB
	
	public cartMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//장바구니 담기
	public boolean addCart(cartBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert cart(productNo,quantity,id)"
					+ "values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getProductNo());
			pstmt.setInt(2, bean.getQuantity());
			pstmt.setString(3, bean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//특정 아이디에 해당하는 카트목록 가져오기
	public Vector<cartBean> getCart(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<cartBean> vlist = new Vector<cartBean>();
		try {
			con = pool.getConnection();
			sql = "select * from cart where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cartBean bean = new cartBean();
				bean.setNo(rs.getInt("no"));
				bean.setProductNo(rs.getInt("productno"));
				bean.setQuantity(rs.getInt("quantity"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//카트 내역 전부 가져오기
	public Vector<cartBean> getCartAll(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<cartBean> vlist = new Vector<cartBean>();
		try {
			con = pool.getConnection();
			sql = "select * from cart";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cartBean bean = new cartBean();
				bean.setNo(rs.getInt("no"));
				bean.setProductNo(rs.getInt("productno"));
				bean.setQuantity(rs.getInt("quantity"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//선택한 카트내역 삭제하기
	public boolean deleteCart(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag= false;
		try {
			con = pool.getConnection();
			sql = "delete from cart where no = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			if(pstmt.executeUpdate()==1) {
				flag= true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//결제 완료했을 시에 그 아이디와 관련된 내역 삭제
	public boolean deleteCart(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag= false;
		try {
			con = pool.getConnection();
			sql = "delete from cart where id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			if(pstmt.executeUpdate()==1) {
				flag= true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	public static void main(String[] args) {
		cartMgr cmgr= new cartMgr();
		Vector<cartBean> vlist = new Vector<cartBean>();
		vlist=cmgr.getCartAll();
		System.out.println(vlist.size());
				
	}
}
