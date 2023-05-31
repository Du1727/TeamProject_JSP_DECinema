package ticketing;

import java.util.Vector;

public class ScreeningInfoBean {
	private int movieIdx;
	private String cityAddress;
	private String sectionName;
	private int theaterNum;
	private String screenTime;
	private String endTime;
	private int totalSeat;
	private int reservedSeat;
	private Vector<String> reservedSeatsPosition;
	
	public ScreeningInfoBean() {
		
	}

	public ScreeningInfoBean(int movieIdx, String cityAddress, String sectionName, int theaterNum, String screenTime,
			String endTime, int totalSeat, int reservedSeat, Vector<String> reservedSeatsPosition) {
		super();
		this.movieIdx = movieIdx;
		this.cityAddress = cityAddress;
		this.sectionName = sectionName;
		this.theaterNum = theaterNum;
		this.screenTime = screenTime;
		this.endTime = endTime;
		this.totalSeat = totalSeat;
		this.reservedSeat = reservedSeat;
		this.reservedSeatsPosition = reservedSeatsPosition;
	}

	public int getMovieIdx() {
		return movieIdx;
	}

	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}

	public String getCityAddress() {
		return cityAddress;
	}

	public void setCityAddress(String cityAddress) {
		this.cityAddress = cityAddress;
	}

	public String getSectionName() {
		return sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}

	public int getTheaterNum() {
		return theaterNum;
	}

	public void setTheaterNum(int theaterNum) {
		this.theaterNum = theaterNum;
	}

	public String getScreenTime() {
		return screenTime;
	}

	public void setScreenTime(String screenTime) {
		this.screenTime = screenTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getTotalSeat() {
		return totalSeat;
	}

	public void setTotalSeat(int totalSeat) {
		this.totalSeat = totalSeat;
	}

	public int getReservedSeat() {
		return reservedSeat;
	}

	public void setReservedSeat(int reservedSeat) {
		this.reservedSeat = reservedSeat;
	}

	public Vector<String> getReservedSeatsPosition() {
		return reservedSeatsPosition;
	}

	public void setReservedSeatsPosition(Vector<String> reservedSeatsPosition) {
		this.reservedSeatsPosition = reservedSeatsPosition;
	}
}
