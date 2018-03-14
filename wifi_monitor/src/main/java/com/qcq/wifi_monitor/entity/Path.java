package com.qcq.wifi_monitor.entity;

public class Path {
	int id;
	String mac;
	Double start_x;
	Double start_y;
	Double end_x;
	Double end_y;
	public Path(){
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public Double getStart_x() {
		return start_x;
	}
	public void setStart_x(Double start_x) {
		this.start_x = start_x;
	}
	public Double getStart_y() {
		return start_y;
	}
	public void setStart_y(Double start_y) {
		this.start_y = start_y;
	}
	public Double getEnd_x() {
		return end_x;
	}
	public void setEnd_x(Double end_x) {
		this.end_x = end_x;
	}
	public Double getEnd_y() {
		return end_y;
	}
	public void setEnd_y(Double end_y) {
		this.end_y = end_y;
	}
	@Override
	public String toString() {
		return "Path [id=" + id + ", mac=" + mac + ", start_x=" + start_x + ", start_y=" + start_y + ", end_x=" + end_x
				+ ", end_y=" + end_y + "]";
	}
	public Path(int id, String mac, Double start_x, Double start_y, Double end_x, Double end_y) {
		super();
		this.id = id;
		this.mac = mac;
		this.start_x = start_x;
		this.start_y = start_y;
		this.end_x = end_x;
		this.end_y = end_y;
	}
}
