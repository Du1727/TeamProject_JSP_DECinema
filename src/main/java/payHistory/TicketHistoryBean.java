package payHistory;

import ticketing.MovieInfoBean;
import ticketing.ScreeningInfoBean;

public class TicketHistoryBean {
	private MovieInfoBean mBean;
	private ScreeningInfoBean sBean;
	private int price;
	private String peopleInfo;
	private String payDt;
	public MovieInfoBean getmBean() {
		return mBean;
	}
	public void setmBean(MovieInfoBean mBean) {
		this.mBean = mBean;
	}
	public ScreeningInfoBean getsBean() {
		return sBean;
	}
	public void setsBean(ScreeningInfoBean sBean) {
		this.sBean = sBean;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPeopleInfo() {
		return peopleInfo;
	}
	public void setPeopleInfo(String peopleInfo) {
		this.peopleInfo = peopleInfo;
	}
	public String getPayDt() {
		return payDt;
	}
	public void setPayDt(String payDt) {
		this.payDt = payDt;
	}
}
