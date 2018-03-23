package com.qcq.wifi_monitor.dto;

public class SeekerTimeSearchingDTO {
	int id;
	int hour;
	int minute;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public int getMinute() {
		return minute;
	}
	public void setMinute(int minute) {
		this.minute = minute;
	}
	public SeekerTimeSearchingDTO(int id, int hour, int minute) {
		super();
		this.id = id;
		this.hour = hour;
		this.minute = minute;
	}
	public SeekerTimeSearchingDTO(){
		
	}
}
