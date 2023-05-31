package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class storeMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/java/JSP/second/JSP_TeamProject/project/src/main/webapp/assets/img/store/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024 * 1024 * 20;// 20MB

	public storeMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 제품 정보 모두 가져오기
	public Vector<storeBean> productAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<storeBean> vlist = new Vector<storeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				storeBean bean = new storeBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setDetail(rs.getString("detail"));
				bean.setName(rs.getString("name"));
				bean.setImage(rs.getString("image"));
				bean.setPrice(rs.getInt("price"));
				bean.setStatus(rs.getInt("status"));
				bean.setCategory(rs.getString("category"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public int countCategory() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;

		try {
			con = pool.getConnection();
			sql = "SELECT count(DISTINCT category)as count FROM product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}

//	//제퓸 카테고리 호출
	public String[] getCategory() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String[] str = new String[countCategory()];
		int i = 0;

		try {
			con = pool.getConnection();
			sql = "SELECT DISTINCT category FROM product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				str[i] = rs.getString("category");
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return str;
	}

	// 제품 정보 타입별로 가져오기
	public Vector<storeBean> getProductCategory(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<storeBean> vlist = new Vector<storeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from product where category = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				storeBean bean = new storeBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setDetail(rs.getString("detail"));
				bean.setName(rs.getString("name"));
				bean.setImage(rs.getString("image"));
				bean.setPrice(rs.getInt("price"));
				bean.setStatus(rs.getInt("status"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 하이라이트 가져오기
	public Vector<storeBean> getHighLight() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<storeBean> vlist = new Vector<storeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from product where highlight = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				storeBean bean = new storeBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setDetail(rs.getString("detail"));
				bean.setName(rs.getString("name"));
				bean.setImage(rs.getString("image"));
				bean.setPrice(rs.getInt("price"));
				bean.setStatus(rs.getInt("status"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 제품 하나 선택
	public storeBean selectProduct(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		storeBean bean = new storeBean();
		try {
			con = pool.getConnection();
			sql = "select name,detail,price,category,status,image from product where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// name,detail,price,category,status,image,highlight
				bean.setDetail(rs.getString("detail"));
				bean.setName(rs.getString("name"));
				bean.setImage(rs.getString("image"));
				bean.setPrice(rs.getInt("price"));
				bean.setStatus(rs.getInt("status"));
				bean.setCategory(rs.getString("category"));
				bean.setHighlight(rs.getInt("highlight"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 제품 추가하기
	public boolean insertProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING,
					new DefaultFileRenamePolicy());
			con = pool.getConnection();
			if (multi.getFilesystemName("filename") != null) {
				// 이미지 추가
				// idx,name,detail,price,category,status,image
				sql = "insert product(name,detail,price,category,status,image,highlight)" + "values(?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("productName"));
				pstmt.setString(2, multi.getParameter("productDetail"));
				pstmt.setInt(3, UtilMgr.parseInt(multi, "productPrice"));
				pstmt.setString(4, multi.getParameter("productCategory"));
				if (multi.getParameter("productStatus") == null) {
					pstmt.setInt(5, 0);
				} else {
					pstmt.setInt(5, 1);
				}
				pstmt.setString(6, multi.getFilesystemName("filename"));
				if (multi.getParameter("productHighLgiht") == null) {
					pstmt.setInt(7, 0);
				} else {
					pstmt.setInt(7, 1);
				}
			} else {
				// 이미지 추가 없을때
				sql = "insert product(name,detail,price,category,status,highlight)" + "values(?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("productName"));
				pstmt.setString(2, multi.getParameter("productDetail"));
				pstmt.setInt(3, UtilMgr.parseInt(multi, "productPrice"));
				pstmt.setString(4, multi.getParameter("productCategory"));
				if (multi.getParameter("productStatus") == null) {
					pstmt.setInt(5, 0);
				} else {
					pstmt.setInt(5, 1);
				}
				if (multi.getParameter("productHighLgiht") == null) {
					pstmt.setInt(6, 0);
				} else {
					pstmt.setInt(6, 1);
				}
			}

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;

	}

	// 제품 수정
	public boolean modifyProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING,
					new DefaultFileRenamePolicy());
			con = pool.getConnection();
			if (multi.getFilesystemName("filename") != null) {
				// 이미지 수정
				// idx,name,detail,price,category,status,image
				sql = "update product SET name = ?, " + "    detail = ?, " + "    price = ?, " + "    category = ?, "
						+ "    status = ?, " + " image = ?, " + "highlight = ?" + "where idx = ?";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, multi.getParameter("productName"));
				pstmt.setString(2, multi.getParameter("productDetail"));
				pstmt.setInt(3, UtilMgr.parseInt(multi, "productPrice"));
				pstmt.setString(4, multi.getParameter("productCategory"));
				if (multi.getParameter("productStatus") == null) {
					pstmt.setInt(5, 0);
				} else {
					pstmt.setInt(5, 1);
				}
				pstmt.setString(6, multi.getFilesystemName("filename"));
				if (multi.getParameter("productHighLgiht") == null) {
					pstmt.setInt(7, 0);
				} else {
					pstmt.setInt(7, 1);
				}
				
				pstmt.setInt(8, UtilMgr.parseInt(multi, "productNo"));
			} else {
				// 이미지 수정 아님
				sql = "update product SET NAME = ?, detail = ?, price = ?,   category = ? ,"
						+ "STATUS = ?,  highlight = ? where idx = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("productName"));
				pstmt.setString(2, multi.getParameter("productDetail"));
				pstmt.setInt(3, UtilMgr.parseInt(multi, "productPrice"));
				pstmt.setString(4, multi.getParameter("productCategory"));
				if (multi.getParameter("productStatus") == null) {
					pstmt.setInt(5, 0);
				} else {
					pstmt.setInt(5, 1);
				}
				if (multi.getParameter("productHighLgiht") == null) {
					pstmt.setInt(6, 0);
				} else {
					pstmt.setInt(6, 1);
				}
				pstmt.setInt(7, UtilMgr.parseInt(multi, "productNo"));
			}

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;

	}

	public storeBean getProduct(int no/* 상품idx */) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		storeBean bean = new storeBean();
		try {
			con = pool.getConnection();
			sql = "select idx,name,detail,price,category,status,image,highlight " + "from Product where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setIdx(rs.getInt("idx"));
				bean.setName(rs.getString("name"));
				bean.setDetail(rs.getString("detail"));
				bean.setPrice(rs.getInt("price"));
				bean.setCategory(rs.getString("category"));
				bean.setStatus(rs.getInt("status"));
				bean.setHighlight(rs.getInt("highlight"));
				bean.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 제품 삭제
	public boolean deleteProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING,
					new DefaultFileRenamePolicy());
			con = pool.getConnection();
				// 이미지 수정
				// idx,name,detail,price,category,status,image
				sql = "DELETE FROM product WHERE IDX = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, UtilMgr.parseInt(multi, "productNo"));
				

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;

	}

}
