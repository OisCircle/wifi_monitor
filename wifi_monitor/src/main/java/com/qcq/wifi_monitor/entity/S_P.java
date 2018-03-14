package com.qcq.wifi_monitor.entity;

public class S_P {
	//seeker id
	int s_id;
	//phone mac
	String p_mac;
	public S_P(){
		
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
	public String getP_mac() {
		return p_mac;
	}
	public void setP_mac(String p_mac) {
		this.p_mac = p_mac;
	}
	@Override
	public String toString() {
		return "S_P [s_id=" + s_id + ", p_mac=" + p_mac + "]";
	}
	public S_P(int s_id, String p_mac) {
		super();
		this.s_id = s_id;
		this.p_mac = p_mac;
	}
}
