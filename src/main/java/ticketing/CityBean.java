package ticketing;

public class CityBean {
	private String address;
	private int num;
	public CityBean(String address, int num) {
		super();
		this.address = address;
		this.num = num;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
}
