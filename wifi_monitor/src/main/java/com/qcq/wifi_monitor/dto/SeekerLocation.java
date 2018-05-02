package com.qcq.wifi_monitor.dto;

/**
 * @Author O
 * @Description
 * @Date 2018/5/1 9:59
 * @Version 1.0
 */
public class SeekerLocation {
	private double x;
	private double y;
	private int rssi;

	public SeekerLocation() {

	}
	@Override
	public String toString() {
		return "SeekerLocation{" +
				"x=" + x +
				", y=" + y +
				", rssi=" + rssi +
				'}';
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public int getRssi() {
		return rssi;
	}

	public void setRssi(int rssi) {
		this.rssi = rssi;
	}

	public SeekerLocation(double x, double y, int rssi) {
		this.x = x;
		this.y = y;
		this.rssi = rssi;
	}
}
