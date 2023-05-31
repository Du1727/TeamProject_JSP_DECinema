package payHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Vector;
import board.DBConnectionMgr;
import sale.saleBean;
import store.storeBean;
import ticketing.MovieInfoBean;
import ticketing.ScreeningInfoBean;
import utils.Utils;

public class PayHistoryMgr {

	private DBConnectionMgr pool;

	public PayHistoryMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void insertRandomSales() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		Vector<storeBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select idx, price from product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				storeBean bean = new storeBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setPrice(rs.getInt("price"));
				vlist.add(bean);
			}
			sql = "insert sale values(null,?,?,?,?,?)";
			for (int i = 0; i < 30; i++) {
				String date = String.format("%02d", (int)(Math.random()*30)+1);
				String hour = String.format("%02d", (int)(Math.random()*13));
				String min = String.format("%02d", (int)(Math.random()*6)*10);
				int quan = (int)(Math.random()*3)+1;
				storeBean bean = vlist.get((int)(Math.random()*vlist.size()));
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "aaa");
				pstmt.setInt(2, bean.getIdx());
				pstmt.setInt(3, quan);
				pstmt.setInt(4, bean.getPrice()*quan);
				pstmt.setString(5, "2023-04-"+date+" "+hour+":"+min+":00");
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public void insertRandomTicketSales() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		Vector<TicketHistoryBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "SELECT m.idx, m.photo, s.city_address, s.sectionName, s.theaterNum, s.screenTime\r\n"
					+ "FROM movieinfo m, screeninginfo s\r\n"
					+ "WHERE m.idx = s.movieIdx";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TicketHistoryBean bean = new TicketHistoryBean();
				MovieInfoBean mbean = new MovieInfoBean();
				ScreeningInfoBean sbean = new ScreeningInfoBean();
				mbean.setIdx(rs.getInt("idx"));
				mbean.setPosterPath(rs.getString("photo"));
				sbean.setCityAddress(rs.getString("city_address"));
				sbean.setSectionName(rs.getString("sectionName"));
				sbean.setTheaterNum(rs.getInt("theaterNum"));
				sbean.setScreenTime(rs.getString("screenTime"));
				bean.setmBean(mbean);
				bean.setsBean(sbean);
				vlist.add(bean);
			}
			sql = "insert ticketingInfo values(?,?,?,?,?,?,?,?,?,?,1)";
			for (int i = 0; i < 30; i++) {
				String date = String.format("%02d", (int)(Math.random()*30)+1);
				String hour = String.format("%02d", (int)(Math.random()*13));
				String min = String.format("%02d", (int)(Math.random()*6)*10);
				int quan = (int)(Math.random()*4)+1;
				int seatsIdx = (int)(Math.random()*16)+1;
				String seats = Utils.parseSeatPosition(seatsIdx);
				for (int j = 0; j < quan; j++) {
					seats += "/"+Utils.parseSeatPosition(seatsIdx+j+1);
				}
				TicketHistoryBean bean = vlist.get((int)(Math.random()*vlist.size()));
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bean.getmBean().getIdx());
				pstmt.setString(2, bean.getsBean().getCityAddress());
				pstmt.setString(3, bean.getsBean().getSectionName());
				pstmt.setInt(4, bean.getsBean().getTheaterNum());
				pstmt.setString(5, bean.getsBean().getScreenTime());
				pstmt.setString(6, seats);
				pstmt.setInt(7, quan*14000);
				pstmt.setString(8, quan+"/0/0");
				pstmt.setString(9, "2023-04-"+date+" "+hour+":"+min+":00");
				pstmt.setString(10, "2023-04-"+date+" "+hour+":"+min+":00");
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public Vector<payHistoryBean> getPayHistoryList(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<payHistoryBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "SELECT s.quantity, s.price AS sPrice, s.paydt, p.name, p.price AS pPrice, p.image\r\n"
					+ "FROM sale s, product p\r\n"
					+ "WHERE s.productNo=p.idx AND s.id = ?"
					+ "ORDER BY s.paydt DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				storeBean stBean = new storeBean();
				saleBean saBean = new saleBean();
				saBean.setQuantity(rs.getInt("quantity"));
				saBean.setPrice(rs.getInt("sPrice"));
				saBean.setPaydt(rs.getString("paydt"));
				stBean.setName(rs.getString("name"));
				stBean.setPrice(rs.getInt("pPrice"));
				stBean.setImage(rs.getString("image"));
				payHistoryBean bean = new payHistoryBean();
				bean.setSalebean(saBean);
				bean.setStorebean(stBean);
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<TicketHistoryBean> getTicketHistoryList(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TicketHistoryBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "SELECT m.name, m.photo, t.city_address, t.sectionName, t.theaterNum, t.screenTime, t.reservedSeats, t.price, t.peopleInfo, t.firstInsertionTime\r\n"
					+ "FROM ticketinginfo t, movieinfo m\r\n"
					+ "WHERE m.idx = t.movieIdx AND t.memberId = ?"
					+ "ORDER BY t.lastUpdateTime DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieInfoBean mbean = new MovieInfoBean();
				ScreeningInfoBean sbean = new ScreeningInfoBean();
				TicketHistoryBean bean = new TicketHistoryBean();
				mbean.setMovieNm(rs.getString("name"));
				mbean.setPosterPath(rs.getString("photo"));
				bean.setmBean(mbean);
				sbean.setCityAddress(rs.getString("city_address"));
				sbean.setSectionName(rs.getString("sectionName"));
				sbean.setTheaterNum(rs.getInt("theaterNum"));
				sbean.setScreenTime(rs.getString("screenTime"));
				Vector<String> reservedSeats = new Vector<>(Arrays.asList(rs.getString("reservedSeats").split("/")));
				sbean.setReservedSeatsPosition(reservedSeats);
				bean.setsBean(sbean);
				String[] peopleInfo = rs.getString("peopleInfo").split("/");
				bean.setPrice(Integer.parseInt(peopleInfo[0])*14000+Integer.parseInt(peopleInfo[1])*10000+Integer.parseInt(peopleInfo[2])*7000);
				bean.setPeopleInfo(rs.getString("peopleInfo"));
				bean.setPayDt(rs.getString("firstInsertionTime"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
