package com.qcq.wifi_monitor.dto;
//DTO匹配页面要求搜索分钟，信号强度
public class SeekerFilterDTO {
	int id;
	int minute;
	int rssi;
	public SeekerFilterDTO(int id, int minute, int rssi) {
		super();
		this.id = id;
		this.minute = minute;
		this.rssi = rssi;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMinute() {
		return minute;
	}
	public void setMinute(int minute) {
		this.minute = minute;
	}
	public int getRssi() {
		return rssi;
	}
	public void setRssi(int rssi) {
		this.rssi = rssi;
	}
}
