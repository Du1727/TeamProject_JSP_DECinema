package ticketing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Vector;
import board.DBConnectionMgr;
import payHistory.TicketHistoryBean;

public class TicketingMgr {

	private DBConnectionMgr pool;

	public TicketingMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	public Vector<MovieInfoBean> getMovieList(String str) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MovieInfoBean> vlist = new Vector<>();
		String sql2 = "";
		
		try {
			con = pool.getConnection();
			if (str.equals("최신순")) {
				sql = "select * from movieinfo order by opendt desc";
			} else {
				sql = "select * from movieinfo order by vote desc";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MovieInfoBean bean = new MovieInfoBean(rs.getInt("idx"), rs.getString("name"), "2D",
						rs.getString("agelimit"), rs.getString("photo"), rs.getString("director"),
						rs.getString("actor"), rs.getString("genre"), rs.getString("intro"), rs.getString("opendt"),
						rs.getString("enddt"), rs.getString("runtime"), rs.getString("trailer"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public Vector<MovieInfoBean> getMovieSearch(String str) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String change = "%"+str+"%";
		Vector<MovieInfoBean> vlist = new Vector<>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM movieinfo "
					+ "WHERE name LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, change);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MovieInfoBean bean = new MovieInfoBean(rs.getInt("idx"), rs.getString("name"), "2D",
						rs.getString("agelimit"), rs.getString("photo"), rs.getString("director"),
						rs.getString("actor"), rs.getString("genre"), rs.getString("intro"), rs.getString("opendt"),
						rs.getString("enddt"), rs.getString("runtime"), rs.getString("trailer"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public MovieInfoBean getMovieInfo(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MovieInfoBean bean = new MovieInfoBean();
		try {
			con = pool.getConnection();
			sql = "select * from movieinfo where idx = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setIdx(idx);
				bean.setMovieNm(rs.getString("name"));
				bean.setAgeLimit(rs.getString("agelimit"));
				bean.setPosterPath(rs.getString("photo"));
				bean.setMovieDmType("2D");
				bean.setDirector(rs.getString("director"));
				bean.setActor(rs.getString("actor"));
				bean.setGenre(rs.getString("genre"));
				bean.setIntro(rs.getString("intro"));
				bean.setOpenDt(rs.getString("opendt"));
				bean.setEndDt(rs.getString("enddt"));
				bean.setRuntime(rs.getString("runtime"));
				bean.setTrailerPath(rs.getString("trailer"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	public Vector<CityBean> getCityList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CityBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from city";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CityBean bean = new CityBean(rs.getString("address"), rs.getInt("num"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public Vector<TheaterBean> getTheaterList(String city, String section) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TheaterBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from theater where city_address=? and theaterName=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, city);
			pstmt.setString(2, section);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				TheaterBean bean = new TheaterBean(rs.getString("theaterName"), rs.getInt("seat"),
						rs.getInt("theaterNum"), rs.getString("city_address"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
//		System.out.println("Mgr : "+vlist.get(0).getCityAddress());
		return vlist;
	}

	public Vector<String> getTheaterNmList(String city) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select DISTINCT theaterName from theater where city_address = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, city);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vlist.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public HashMap<Integer, Vector<ScreeningInfoBean>> getScrnList(String city, String section, String date,
			int movieIdx, HashMap<Integer, String> seatFilter) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		HashMap<Integer, Vector<ScreeningInfoBean>> scrnListMap = new HashMap<Integer, Vector<ScreeningInfoBean>>();
		String temp[] = date.split("[.]");
		try {
			con = pool.getConnection();
			sql = "SELECT s.movieIdx, s.city_address, s.sectionName, s.theaterNum, s.screenTime, s.endTime, s.reservedSeats, t.seat\r\n"
					+ "FROM screeninginfo s, theater t\r\n"
					+ "WHERE s.city_address=t.city_address AND s.sectionName=t.theaterName AND s.theaterNum=t.theaterNum"
					+ " AND s.city_address=? AND s.sectionName=? AND s.screenTime between ? and ? AND s.movieIdx=?";
			if (seatFilter != null && seatFilter.size()>0) {
				for (int key : seatFilter.keySet()) {
					sql += " AND ((s.theaterNum = ? AND s.reservedSeats NOT LIKE ?";
					String[] spliter = seatFilter.get(key).split("/");
					for (int i = 1; i < spliter.length; i++) {
						sql += " AND s.reservedSeats NOT LIKE ?";
					}
					sql += ") OR s.theaterNum != ?)";
				}
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, city);
			pstmt.setString(2, section);
			pstmt.setString(3, temp[0].trim() + "-" + temp[1].trim() + "-" + temp[2].trim() + " 00:00:00");
			pstmt.setString(4, temp[0].trim() + "-" + temp[1].trim() + "-" + temp[2].trim() + " 23:59:59");
			pstmt.setInt(5, movieIdx);
			if (seatFilter != null) {
				int sqlIdx = 6;
				for (int key : seatFilter.keySet()) {
					pstmt.setInt(sqlIdx, key);
					sqlIdx++;
					String[] spliter = seatFilter.get(key).split("/");
					pstmt.setString(sqlIdx, "%"+spliter[0]+"%");
					sqlIdx++;
					for (int i = 1; i < spliter.length; i++) {
						pstmt.setString(sqlIdx, "%"+spliter[i]+"%");
						sqlIdx++;
					}
					pstmt.setInt(sqlIdx, key);
					sqlIdx++;
				}
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String[] reservedSeat = rs.getString("reservedSeats").split("/");
				Vector<String> vRS = new Vector<String>(Arrays.asList(reservedSeat));
				ScreeningInfoBean bean = new ScreeningInfoBean(rs.getInt("movieIdx"), city, section,
						rs.getInt("theaterNum"), rs.getString("screenTime"), rs.getString("endTime"), rs.getInt("seat"), reservedSeat.length,
						vRS);
				if (scrnListMap.get(bean.getTheaterNum()) != null) {
					scrnListMap.get(bean.getTheaterNum()).add(bean);
				} else {
					Vector<ScreeningInfoBean> vlist = new Vector<>();
					vlist.add(bean);
					scrnListMap.put(bean.getTheaterNum(), vlist);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return scrnListMap;
	}
	
	public Vector<SeatBean> getSeatInfo(int movieIdx, String city, String section, int theaterNum, String date,
			String time) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SeatBean> vlist = new Vector<>();
		String temp[] = date.split("[.]");
		String screenTime = temp[0].trim() + "-" + temp[1].trim() + "-" + temp[2].trim() + " " + time;
		String seatPosition[][] = new String[26][15];
		for (int i = 0; i < seatPosition.length; i++) {
			for (int j = 0; j < seatPosition[i].length; j++) {
				seatPosition[i][j] = new String();
				if (j < 9) {
					seatPosition[i][j] = "" + (char) (i + 65) + "0" + (j + 1);
				} else {
					seatPosition[i][j] = "" + (char) (i + 65) + (j + 1);
				}
			}
		}
		try {
			con = pool.getConnection();
			sql = "SELECT s.reservedSeats, t.seat\r\n" + "FROM screeninginfo s, theater t\r\n"
					+ "WHERE s.city_address=t.city_address AND s.sectionName=t.theaterName AND s.theaterNum=t.theaterNum AND "
					+ "s.movieIdx = ? and s.city_address = ? and s.sectionName = ? and s.theaterNum = ? and s.screenTime = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieIdx);
			pstmt.setString(2, city);
			pstmt.setString(3, section);
			pstmt.setInt(4, theaterNum);
			pstmt.setString(5, screenTime);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String[] rsvS = rs.getString(1).split("/");
				Vector<String> rsvSv = new Vector<>(Arrays.asList(rsvS));
				for (int i = 0; i < rs.getInt(2); i++) {
					if (rsvSv.size() > 0) {
						for (int j = 0; j < rsvSv.size(); j++) {
							if (rsvSv.get(j).equals(seatPosition[(int) (i / 15.0)][i % 15])) {
								rsvSv.remove(j);
								SeatBean bean = new SeatBean(seatPosition[(int) (i / 15.0)][i % 15], 2);
								vlist.add(bean);
								break;
							}
							if (j == rsvSv.size() - 1) {
								SeatBean bean = new SeatBean(seatPosition[(int) (i / 15.0)][i % 15], 0);
								vlist.add(bean);
							}
						}
					} else {
						SeatBean bean = new SeatBean(seatPosition[(int) (i / 15.0)][i % 15], 0);
						vlist.add(bean);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public int deletePastTime() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int updateRows = 0;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			con = pool.getConnection();
			sql = "delete from screeninginfo where screenTime < ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, transFormat.format(new Date()));
			updateRows = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return updateRows;
	}
	
	public boolean insertTicketingInfo(ScreeningInfoBean sBean, String id, int totalPrice, String peopleInfo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int updateRows = 0;
		Vector<String> checkSeats = sBean.getReservedSeatsPosition();
		try {
			con = pool.getConnection();
			sql = "select reservedSeats from ticketinginfo where movieIdx = ? and city_address = ? and sectionName = ? and theaterNum = ? and screenTime = ? and (state = 0 or state = 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sBean.getMovieIdx());
			pstmt.setString(2, sBean.getCityAddress());
			pstmt.setString(3, sBean.getSectionName());
			pstmt.setInt(4, sBean.getTheaterNum());
			pstmt.setString(5, sBean.getScreenTime());
			rs = pstmt.executeQuery();
			boolean flag = false;
			while(rs.next()) {
				String[] temp = rs.getString(1).split("/");
				for (int i = 0; i < temp.length; i++) {
					for (int j = 0; j < checkSeats.size(); j++) {
						if (checkSeats.get(j).equals(temp[i])) {
							flag = true;
							break;
						}
					}
					if (flag) {
						break;
					}
				}
				if (flag) {
					break;
				}
			}
			if (!flag) {
				sql = "insert ticketinginfo values(?,?,?,?,?,?,?,?,?,NOW(),NOW(),0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, sBean.getMovieIdx());
				pstmt.setString(3, sBean.getCityAddress());
				pstmt.setString(4, sBean.getSectionName());
				pstmt.setInt(5, sBean.getTheaterNum());
				pstmt.setString(6, sBean.getScreenTime());
				StringBuilder sb = new StringBuilder();
				for (int i = 0; i < sBean.getReservedSeatsPosition().size(); i++) {
					sb.append(sBean.getReservedSeatsPosition().get(i));
					sb.append("/");
				}
				pstmt.setString(7, sb.toString());
				pstmt.setInt(8, totalPrice);
				pstmt.setString(9, peopleInfo);
				updateRows = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return updateRows>0?true:false;
	}
	
	public void updateTicketInfo(int state, ScreeningInfoBean bean, int movieIdx, String id, String reservedSeats) {
		System.out.println(state+"/"+id+"/"+movieIdx+"/"+bean.getCityAddress()+"/"+bean.getSectionName()+"/"+bean.getTheaterNum()+"/"+bean.getScreenTime()+"/"+reservedSeats);
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE ticketinginfo\r\n"
					+ "SET state = ?, lastUpdateTime = NOW()\r\n"
					+ "WHERE memberId = ? AND movieIdx = ? AND city_address = ? AND sectionName = ? AND theaterNum = ? AND screenTime = ? AND reservedSeats = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setString(2, id);
			pstmt.setInt(3, movieIdx);
			pstmt.setString(4, bean.getCityAddress());
			pstmt.setString(5, bean.getSectionName());
			pstmt.setInt(6, bean.getTheaterNum());
			pstmt.setString(7, bean.getScreenTime());
			pstmt.setString(8, reservedSeats);
			pstmt.executeUpdate();
			if (state == 1) {
				sql = "UPDATE screeningInfo\r\n"
						+ "SET reservedSeats = CONCAT(reservedSeats, ?)\r\n"
						+ "WHERE movieIdx = ? AND city_address = ? AND sectionName = ? AND theaterNum = ? AND screenTime = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, reservedSeats);
				pstmt.setInt(2, movieIdx);
				pstmt.setString(3, bean.getCityAddress());
				pstmt.setString(4, bean.getSectionName());
				pstmt.setInt(5, bean.getTheaterNum());
				pstmt.setString(6, bean.getScreenTime());
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}
