package payHistory;

import sale.saleBean;
import store.storeBean;

public class payHistoryBean {
	private saleBean salebean;
	private storeBean storebean;
	public saleBean getSalebean() {
		return salebean;
	}
	public void setSalebean(saleBean salebean) {
		this.salebean = salebean;
	}
	public storeBean getStorebean() {
		return storebean;
	}
	public void setStorebean(storeBean storebean) {
		this.storebean = storebean;
	}
}