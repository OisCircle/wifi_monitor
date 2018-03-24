package com.qcq.wifi_monitor.entity;

import java.util.Date;

public class Info {
	int id;
	int rssi;
	String mac;
	Date time;
	int s_id;
	public Info(){
		
	}
	public Info(int id, int rssi, String mac, Date time, int s_id) {
		this.id = id;
		this.rssi = rssi;
		this.mac = mac;
		this.time = time;
		this.s_id = s_id;
	}
	@Override
	public String toString() {
		return "Info [id=" + id + ", rssi=" + rssi + ", mac=" + mac + ", time=" + time + ", s_id=" + s_id + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRssi() {
		return rssi;
	}
	public void setRssi(int rssi) {
		this.rssi = rssi;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getS_id() {
		return s_id;
	}
	public void setS_id(int s_id) {
		this.s_id = s_id;
	}
}
