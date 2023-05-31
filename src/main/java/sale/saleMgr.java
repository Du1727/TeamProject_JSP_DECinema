package sale;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import store.DBConnectionMgr;

public class saleMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = 
			"C:/java/JSP/DEC/src/main/webapp/store";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB
	
	public saleMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean addSale(saleBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert sale(id,productNo,quantity,price,paydt)"
					+ "values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setInt(2, bean.getProductNo());
			//카트에서 넘어가는 부분은 대부분 일반상품
			pstmt.setInt(3, bean.getQuantity());
			
			pstmt.setInt(4, bean.getPrice());
			LocalDateTime localtime = LocalDateTime.now();
			DateTimeFormatter time_format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String regDate =  localtime.format(time_format);
			pstmt.setString(5, regDate);

			if(pstmt.executeUpdate()==1) {
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
