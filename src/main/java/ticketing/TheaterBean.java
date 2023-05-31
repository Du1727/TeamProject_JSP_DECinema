package ticketing;

public class TheaterBean {
	private String name;
	private int seat;
	private int num;
	private String cityAddress;
	public TheaterBean(String name, int seat, int num, String cityAddress) {
		super();
		this.name = name;
		this.seat = seat;
		this.num = num;
		this.cityAddress = cityAddress;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCityAddress() {
		return cityAddress;
	}
	public void setCityAddress(String cityAddress) {
		this.cityAddress = cityAddress;
	}
}
