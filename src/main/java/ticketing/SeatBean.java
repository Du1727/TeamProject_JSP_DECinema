package ticketing;

public class SeatBean {
	private String seatPosition;
	private int status;

	public SeatBean() {

	}

	public SeatBean(String seatPosition, int status) {
		super();
		this.seatPosition = seatPosition;
		this.status = status;
	}

	public String getSeatPosition() {
		return seatPosition;
	}

	public void setSeatPosition(String seatPosition) {
		this.seatPosition = seatPosition;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public void statusToggle() {
		if (this.status != 0) {
			this.status = 0;
		} else {
			this.status = 1;
		}
	}
	public void statusToggle(int i) {
		if (this.status != 0) {
			this.status = 0;
		} else{
			this.status = i;
		}
	}

}
